## PRODUCT
StrideCare helps people recovering from fractures, joint surgery or stroke see how well they are healing between physio visits. A clip-on cane module (grip sensor, tip load cell, motion sensor) measures support load, steps, walking time, cadence, estimated walking speed, gait rhythm and falls, and buzzes the handle in real time if the patient overloads the leg or rushes. The app turns this into a simple daily story and a wellness plan (nutrition, yoga, medication reminders). Physios see data on a separate web dashboard. Main users are people aged 50 to 80 who are in pain, a bit scared of falling and not very comfortable with apps.

## TECH STACK
- Flutter (latest stable), Dart, Material 3 heavily customized (must not look like default Material)
- Riverpod for state, Drift (SQLite) for offline storage, fl_chart for charts
- BLE: flutter_reactive_ble, ONLY behind an abstract CaneService interface
- Localization: English, Hindi, Punjabi (ARB files)
- PDF: pdf + printing. Notifications: flutter_local_notifications
- Backend (Phase 5): Firebase Auth + Firestore behind repository interfaces
- Feature-first folder structure

## CRITICAL ARCHITECTURE RULE
Hardware is not ready. Create `abstract class CaneService` with: connect, disconnect, streams for gripState, tipLoad, steps, cadence, estimatedSpeed, gait, fall, battery, plus sendVibration. There is NO startWalk/stopWalk from the UI. Implement `MockCaneService` that generates realistic simulated data: grip on/off events, walking sessions starting and ending naturally, improvement in load and speed over weeks, bad days, brief pauses mid-walk, and occasional falls. Swapping to `BleCaneService` must be a one-line provider change. Stub `BleCaneService` with placeholder GATT UUIDs in one clearly marked config file.

## AUTOMATIC WALK DETECTION (NO START BUTTON)
There must be NO Start/Stop button for walks anywhere in the app. Create a `WalkSessionDetector` class (pure Dart, fully unit-tested, thresholds in one config file):
- START a session when grip is detected AND tip load exceeds a threshold AND at least 3 steps occur within about 5 seconds.
- END a session after about 30 seconds with no steps and no tip load, or when grip is released. Short pauses must NOT end the session.
- On start: if the app is in the foreground, navigate to Live Walk with the calm message "Walk started. Take your time." If in the background, show a quiet ongoing notification; the summary is ready when the app is opened.
- On end: save the WalkSession and show the post-walk summary.
- If the cane is disconnected, Home shows a small text link "Cane not connected. Fix this" to the pairing screen. No walk button.

## WALKING SPEED
- Estimated speed = cadence x stride length. Stride length comes from height (onboarding) and is refined by an optional calibration walk (10 steps in a straight line).
- Track per walk and per day: average speed (m/s), peak speed, cadence (steps/min), estimated stride length, estimated distance.
- Always label it "estimated pace" and present it as a trend, never a precise measurement.
- Show pace in plain words with the number secondary: Slow / Comfortable / Brisk.
- The physio can set a max pace/cadence per patient; exceeding it triggers a handle vibration ("rushing").
- A sustained pace drop over several days creates a regression alert for the physio.

## DESIGN: MUST FEEL HUMAN-MADE, NOT AI-GENERATED
Point of view: a calm, competent physiotherapist sitting beside the patient. Think a well-made printed recovery booklet from a good clinic, not a tech startup. The patient app is warm and gentle. The physio dashboard is clean, dense and quietly professional, in the same visual family.

HARD BANS:
- Purple, blue or pink gradients; glow, neon, glassmorphism, blur panels
- Rows of three identical rounded cards with an icon-in-circle on top
- Emoji in the UI; mixed icon sets
- Heavy drop shadows. Use at most two elevation levels, mostly flat with 1px warm-grey borders
- Hero or marketing copy like "Empower your journey", "Seamless", "Revolutionary", "Unlock your potential"
- "Welcome back!", "Great job!", "Keep crushing it", decorative exclamation marks
- Fake stats, fake testimonials, lorem ipsum
- Centered-everything, perfectly symmetrical layouts
- Gradient pill buttons, hover glows, bouncing or staggered animations

Palette (design tokens only, nothing outside them): background #FAF6F0, surface #FFFFFF with 1px #E8E0D4 border, primary deep teal #1F5F5B, accent marigold #D9822B (sparingly, one accent moment per screen), text #2B2B2B, muted text #6B645B, soft alert #C8503E.

Typography: Fraunces for headings (sentence case, never ALL CAPS), Nunito Sans for body. Body at least 17sp in the patient app, with a text-size setting that scales to 200%. Big numbers (steps, pace) are set in Fraunces like printed figures. Tabular figures in tables and charts.

Layout: an uneven, editorial rhythm with one dominant element per screen and smaller supporting items. Left-aligned text. Prefer lists with thin dividers over grids of cards; use cards only for truly separate objects (a walk summary, a medication). Touch targets at least 56px. One primary action per screen. Bottom navigation with text labels. Physio dashboard: table-first, patient list on the left, calm detail view on the right, inline sparkline charts, alerts as a plain list with a small colored marker, not big red banners.

Illustrations and icons: one consistent hand-drawn-feeling line style (2px stroke, slightly rounded ends) drawn as SVG/CustomPainter: cane, sunrise, walking figure, food bowl, pill, clip-on module. Illustrations only where they carry meaning (empty states, onboarding, pairing). One outline icon set for functional icons only.

Charts: thin lines, only a few light horizontal gridlines, direct labels instead of legends, a soft shaded band for the physio's target range, a dot only on the latest point, plain-language annotations ("Surgery week", "Physio visit"). Teal for the main series, marigold to highlight one thing.

Motion: only the ring filling once on load, soft 200-250ms fades and slides, and a gentle pulse while searching for the cane. Respect reduced-motion.

Copy: write like a kind nurse, short, concrete, sentence case, no hype. Say specific things ("You walked 14 minutes today, 3 more than yesterday"). Never shame the patient; bad days read "Today was slower. That happens in recovery. Rest well." with no red failure states. Buttons use verbs ("Add a contact", "See this week", "Send to my physio"). Errors say what happened and what to do ("The tip sensor isn't reading. Check the module is clipped on firmly."). Dates read naturally ("Tuesday, 3 days after your surgery"). Empty states explain in one honest line what will appear.

Localization: all strings in ARB files with natural Hindi and Punjabi (not word-for-word machine translation). Flag strings that need review by a native speaker.

Accessibility: AA contrast minimum, screen reader labels on every control, color is never the only signal.

## SCREENS AND FEATURES
1. ONBOARDING (one question per screen, in this order): language, name, height and age, injury type (hip/knee/ankle fracture, joint surgery, stroke), surgery date, affected side, EMERGENCY CONTACT 1 (name, phone, relationship), EMERGENCY CONTACT 2 (same fields), physio code (optional). Both emergency contacts are REQUIRED and validated (valid phone numbers, two different numbers). Explain why: "If you fall and can't answer, we'll message these two people." Contacts are editable in Settings. Send each contact a consent message when added.
2. HOME "Today": time-based greeting with first name, daily ring (steps + walking time), recovery score as word + number ("Steady, 72"), today's estimated pace line, one human insight line computed from data, today's tasks (walk, yoga, meal), device status chip. No walk button.
3. LIVE WALK (auto-triggered only): elapsed time, steps, current pace in words, one status color. Vibration on overload or rushing. Post-walk summary: time, steps, estimated distance, average pace, cane load trend, one human sentence.
4. PROGRESS: weekly charts for cane load trend, walking pace (average and peak), cadence, stride length, gait regularity, activity. Milestone stamps ("First 1,000-step day", "Ready to discuss walking without the cane") as small stamp-like marks, no confetti. Label load as "cane load trend", never "weight on leg".
5. WELLNESS > FOOD: stage-based daily suggestions rich in calcium, vitamin D, protein, vitamin K; local veg and non-veg Punjabi/North Indian options; simple recipes; food-log check-in. Supplements: general info only, with "Ask your doctor whether vitamin D or calcium suits you". No doses ever.
6. WELLNESS > MOVE: yoga and mobility routines (seated, supported, breathing, ankle/hip mobility) unlocked by recovery stage; gentler if load rises or gait becomes irregular. Physio approval required: locked state "Waiting for your physio's approval". Filter content by injury type so patients never see unsuitable poses.
7. HABITS: MEDICATION ONLY. Medicine name, time, taken/not taken, gentle streak, reminder notifications. Do NOT include water, sleep or sunlight anywhere (UI, data model, notifications).
8. SAFETY: fall detected -> 30-second "Are you okay?" countdown -> SMS + call intent to Emergency Contact 1 with time and map link -> if not acknowledged within about 2 minutes, escalate to Emergency Contact 2. Fall alerts are idempotent. Family view shows only activity, pace summary and alerts.
9. WEEKLY REPORT: shareable PDF for the physio with steps, walking time, load trend, pace and cadence trends, falls, medication adherence.
10. SETTINGS: language, text size, emergency contacts, device, privacy, data export.
11. Persistent disclaimer on wellness screens: "Confirm with your doctor or physio."

## DEVICE PAIRING FLOW (build against MockCaneService)
5 screens: permission explanation -> attach the module (illustrated steps) -> searching (list "StrideCare-XXXX") -> calibration (stand still 5s for load-cell zero; take 5 steps for motion test; optional "walk 10 steps in a straight line" for stride calibration) -> connected (battery, firmware, "Test the buzz"). Home shows a connection chip: Connected / Syncing / Asleep / Disconnected. Handle out-of-range buffering and later sync, low battery at 20%, human-readable sensor errors, and a "Having trouble?" re-pair screen.

## DATA MODEL
User (with height, age), InjuryProfile, EmergencyContact (exactly two, ordered), WalkSession (auto-detected, with avgSpeed, peakSpeed, cadence, strideLength, distance), DailyMetrics (steps, walkMinutes, avgLoad, peakLoad, avgSpeed, peakSpeed, cadence, gaitRegularity), RecoveryScore, Milestone, FoodItem, Recipe, YogaRoutine (stage, injury tags, physioApproved), MedicationLog, FallEvent, DeviceInfo. No hydration, sleep or sunlight models.
Recovery score: one documented, commented file with a weighted formula combining cane load trend, walking pace trend, gait regularity and activity, easy to tune.

## PHASES
Phase 1: project setup, design tokens file, DESIGN.md (visual language plus the do/don't list above), navigation, localization, database, README.
Phase 2: onboarding (with two emergency contacts), Home, automatic Live Walk with WalkSessionDetector, Progress (including pace), all using MockCaneService.
Phase 3: Wellness (food, yoga), medication habit, Safety with two-contact escalation, Weekly report.
Phase 4: pairing flow, BleCaneService scaffold, connection states.
Phase 5: Firebase auth/sync and a minimal Flutter-web physio dashboard: weekly graphs, regression alerts (sudden load rise, 2-day activity drop, sustained pace drop), per-patient targets (including max pace) and yoga approval.

## QUALITY
Unit tests: recovery score, insight generator, fall countdown and escalation, WalkSessionDetector (start, end, pauses, false starts), speed estimation. Widget tests: onboarding (including required two contacts) and Home. README with run instructions and a "How to connect real hardware" section. Never hardcode colors, sizes or strings; use the tokens file and ARB files.
