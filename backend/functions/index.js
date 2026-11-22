import { initializeApp } from 'firebase-admin/app';
import { getFirestore, FieldValue } from 'firebase-admin/firestore';
import { onDocumentCreated } from 'firebase-functions/v2/firestore';
import { onSchedule } from 'firebase-functions/v2/scheduler';
import { defineSecret } from 'firebase-functions/params';

initializeApp();
const db = getFirestore();
const sid = defineSecret('TWILIO_ACCOUNT_SID');
const token = defineSecret('TWILIO_AUTH_TOKEN');
const sender = defineSecret('TWILIO_FROM');
const secrets = [sid, token, sender];
const dayMs = 86400000;

// A claimed attempt with an ambiguous network outcome needs reconciliation
// before retrying. Blind retries could send a second SOS.
async function sms(route, key, number, body) {
  if (!/^\+[1-9]\d{7,14}$/.test(number ?? '')) throw Error('Invalid delivery route');
  const receipt = route.collection('deliveries').doc(key);
  const claimed = await db.runTransaction(async tx => {
    const previous = await tx.get(receipt);
    if (previous.exists && previous.get('state') !== 'retry') return false;
    if (key.startsWith('sos-') && !previous.exists) {
      const throttle = route.collection('limits').doc('sos');
      const last = await tx.get(throttle);
      if (last.exists && Date.now() - last.get('at').toMillis() < 60000) return false;
      tx.set(throttle, {at:FieldValue.serverTimestamp()});
    }
    tx.set(receipt, {state:'attempting', at:FieldValue.serverTimestamp()});
    return true;
  });
  if (!claimed) return;
  const response = await fetch('https://api.twilio.com/2010-04-01/Accounts/'+sid.value()+'/Messages.json', {
    method:'POST', headers:{Authorization:'Basic '+Buffer.from(sid.value()+':'+token.value()).toString('base64')},
    body:new URLSearchParams({From:sender.value(), To:number, Body:body})
  });
  if (!response.ok) {
    await receipt.update({state:response.status === 429 ? 'retry' : 'failed'});
    throw Error('SMS provider rejected submission');
  }
  const message = await response.json();
  await receipt.update({state:'providerAccepted', providerId:message.sid});
}

export const caneAlert = onDocumentCreated({document:'patients/{uid}/sos/{event}', secrets, retry:true}, async event => {
  const {uid,event:id} = event.params;
  const requested = event.data.get('requestedAt').toMillis();
  if (Date.now()-requested > 5*60000) return;
  const route = db.collection('deliveryRoutes').doc(uid);
  const config = (await route.get()).data();
  if (config?.sosEnabled !== true) return;
  await sms(route,'sos-'+id,config.contactPhone,'StrideCare: a possible cane fall was recorded at '+new Date(event.data.get('fallMs')).toISOString()+'. Please check on '+config.displayName+'.');
});

// India-local midnight has a fixed UTC offset. Process completed calendar
// days, with the previous Monday–Sunday week included each Monday.
export const sendReports = onSchedule({schedule:'15 7 * * *',timeZone:'Asia/Kolkata',secrets,retryCount:3}, async event => {
  const time = Date.parse(event.scheduleTime);
  const offset = 19800000;
  const end = Math.floor((time+offset)/dayMs)*dayMs-offset;
  const monday = new Date(end+offset).getUTCDay() === 1;
  const routes = await db.collection('deliveryRoutes').get();
  const failures = [];
  for (const route of routes.docs) {
    for (const weekly of monday ? [false,true] : [false]) {
      try {
        const config = (await route.ref.get()).data();
        if (!config || !(weekly ? config.weeklyEnabled : config.dailyEnabled)) continue;
        let number = config.contactPhone;
        if (weekly) {
          const clinician = db.collection('clinicians').doc(config.physioUid);
          if (!(await clinician.collection('patients').doc(route.id).get()).exists) continue;
          number = (await db.collection('deliveryPhysios').doc(config.physioUid).get()).get('phone');
        }
        const start = end-(weekly?7:1)*dayMs;
        const walks = await db.collection('patients').doc(route.id).collection('walks')
          .where('startMs','>=',start).where('startMs','<',end).get();
        let steps = 0, duration = 0;
        for (const row of walks.docs) {
          const w = row.data();
          steps += w.steps;
          duration += w.endMs-w.startMs;
        }
        const date = new Date(end+offset-dayMs).toISOString().slice(0,10);
        const period = weekly ? 'Weekly' : 'Daily';
        const summary = walks.empty ? 'No walks have synced for this period.' :
          steps+' steps, '+Math.round(duration/60000)+' walking minutes across '+walks.size+' recorded walks.';
        await sms(route.ref,period+'-'+date,number,'StrideCare '+period.toLowerCase()+' report for '+config.displayName+', ending '+date+': '+summary);
      } catch { failures.push(true); }
    }
  }
  if (failures.length) throw Error('Report submission needs review');
});
