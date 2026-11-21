// Fixed loopback origins deliberately confine these fictitious accounts to the emulator.
import { readFile } from 'node:fs/promises';
import assert from 'node:assert/strict';
const db='http://127.0.0.1:8080/v1/projects/demo-stridecare/databases/(default)/documents';
const auth='http://127.0.0.1:9099/identitytoolkit.googleapis.com/v1/accounts:';
const password='StrideCare-practice-2026';
async function request(url,method,body,token,expected=200){
  const res=await fetch(url,{method,headers:{'Content-Type':'application/json',...(token?{Authorization:'Bearer '+token}:{})},body:body?JSON.stringify(body):undefined});
  const data=await res.json(); assert.equal(res.status,expected,JSON.stringify(data.error));return data;
}
function fields(obj){return {fields:Object.fromEntries(Object.entries(obj).map(([k,v])=>[k,
  v===null?{nullValue:null}:typeof v==='boolean'?{booleanValue:v}:typeof v==='string'?{stringValue:v}:Number.isInteger(v)?{integerValue:String(v)}:{doubleValue:v}]))};}
async function account(name){
  const creds={email:name+'@example.test',password,returnSecureToken:true};
  const login=await fetch(auth+'signInWithPassword?key=demo',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify(creds)});
  return login.ok?login.json():request(auth+'signUp?key=demo','POST',creds);
}
const patient=await account('patient'),physio=await account('physio'),other=await account('unassigned');
for(const [a,role] of [[patient,'patient'],[physio,'clinician'],[other,'clinician']]){
  await request(db+'/accounts/'+a.localId,'PATCH',fields({role}),'owner');
}
const pid=patient.localId;
await request(db+'/clinicians/'+physio.localId+'/patients/'+pid,'PATCH',fields({name:'Practice patient'}),'owner');
const dataset=JSON.parse(await readFile(new URL('./datasets/practice_walks_v1.json',import.meta.url)));
for(const {id,...walk} of dataset.walks){
  const path=db+'/patients/'+pid+'/walks/'+id;
  await request(path,'PATCH',fields(walk),patient.idToken);
  const remote=await request(path,'GET',null,physio.idToken);
  assert.equal(Number(remote.fields.steps.integerValue),walk.steps);
  await request(path,'GET',null,other.idToken,403);
}
const plan=db+'/patients/'+pid+'/plan/current';
const target=fields({speed:0.85,cadence:90,load:150,steps:1000,minutes:15,breathing:false});
await request(plan,'PATCH',target,physio.idToken);
assert.deepEqual((await request(plan,'GET',null,patient.idToken)).fields.speed,target.fields.speed);
await request(plan,'PATCH',target,patient.idToken,403);
await request(plan,'PATCH',target,other.idToken,403);
await request(db+'/accounts/'+other.localId,'PATCH',fields({role:'patient'}),other.idToken,403);
console.log('Verified seven synthetic walks, assigned reads, target delivery, and denied unassigned access.');
