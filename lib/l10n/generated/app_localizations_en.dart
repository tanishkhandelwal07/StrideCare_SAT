// ignore_for_file: deprecated_member_use

// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'StrideCare';

  @override
  String get today => 'Today';

  @override
  String get progress => 'Progress';

  @override
  String get wellness => 'Wellness';

  @override
  String get medicine => 'Medicine';

  @override
  String get settings => 'Settings';

  @override
  String get todayHint => 'See the steps from your practice cane.';

  @override
  String get progressHint =>
      'Follow the step counter as the practice cane moves.';

  @override
  String get wellnessHint => 'Open a meal idea and record your check-in.';

  @override
  String get medicineHint => 'Add a medicine, then tick it when taken.';

  @override
  String get settingsHint => 'Connect the simulated cane to try its readings.';

  @override
  String get wellnessAdvice => 'Confirm with your doctor or physio.';

  @override
  String get demo => 'Practice cane';

  @override
  String get connect => 'Connect practice cane';

  @override
  String get disconnect => 'Disconnect cane';

  @override
  String get stepsLabel => 'Steps this visit';

  @override
  String get pace => 'Estimated pace (m/s)';

  @override
  String get meal => 'Meal idea';

  @override
  String get recipe => 'Dal with curd and roti';

  @override
  String get logged => 'I had this meal';

  @override
  String get medicineName => 'Medicine name';

  @override
  String get addMed => 'Add medicine';

  @override
  String get visit => 'Practice readings and check-ins last for this visit.';

  @override
  String get readings => 'Recent step readings';

  @override
  String get noRead => 'Connect the practice cane in Settings to see readings.';

  @override
  String get taken => 'Taken';

  @override
  String get nextStep => 'Continue';

  @override
  String get finishSetup => 'Save profile';

  @override
  String get language => 'Choose your language';

  @override
  String get personName => 'What should we call you?';

  @override
  String get nameLabel => 'Name';

  @override
  String get measurements => 'Your height and age';

  @override
  String get heightLabel => 'Height (cm)';

  @override
  String get ageLabel => 'Age in years';

  @override
  String get injury => 'What are you recovering from?';

  @override
  String get hip => 'Hip fracture';

  @override
  String get knee => 'Knee fracture';

  @override
  String get ankle => 'Ankle fracture';

  @override
  String get joint => 'Joint surgery';

  @override
  String get stroke => 'Stroke';

  @override
  String get dateLabel => 'Date of injury or surgery';

  @override
  String get side => 'Which side is affected?';

  @override
  String get leftSide => 'Left';

  @override
  String get rightSide => 'Right';

  @override
  String get bothSides => 'Both';

  @override
  String get firstContact => 'First emergency contact';

  @override
  String get secondContact => 'Second emergency contact';

  @override
  String get contactNote =>
      'Choose two people to contact after a fall. Practice mode saves their details on this device. Messages and calls are off.';

  @override
  String get phone => 'Phone with country code';

  @override
  String get relationship => 'Relationship';

  @override
  String get codeLabel => 'Physio code (optional)';

  @override
  String get requiredField => 'Please fill in this field.';

  @override
  String get invalidNumber => 'Check this number and try again.';

  @override
  String get differentPhone => 'Use a different number for the second person.';

  @override
  String get saveError => 'Couldn’t save on this device. Please try again.';

  @override
  String get liveWalk => 'Walk started. Take your time.';

  @override
  String get walkSummary => 'Your walk';

  @override
  String get stepsWord => 'Steps';

  @override
  String get walkTime => 'Walking time';

  @override
  String get distance => 'Estimated distance (m)';

  @override
  String get loadTrend => 'Cane load trend (N)';

  @override
  String get slow => 'Slow';

  @override
  String get comfortable => 'Comfortable';

  @override
  String get brisk => 'Brisk';

  @override
  String get fixCane => 'Cane not connected. Fix this';

  @override
  String get connectedLabel => 'Connected';

  @override
  String get pairTitle => 'Pair your practice cane';

  @override
  String get pairHint =>
      'This simulated module lets you try a walk without hardware. It begins sending practice readings when connected.';

  @override
  String get todaySteps => 'Steps today';

  @override
  String get returnToday => 'See today';

  @override
  String get weeklyWalks => 'Walks this week';

  @override
  String get emptyWalks =>
      'Your walks will appear here as the cane records them.';

  @override
  String get approvalLock => 'Waiting for your physio’s approval';

  @override
  String get morning => 'Good morning';

  @override
  String get afternoon => 'Good afternoon';

  @override
  String get evening => 'Good evening';

  @override
  String get testBuzz => 'Test the buzz';

  @override
  String get buzzOk => 'Practice buzz received.';

  @override
  String get textSize => 'Text size';

  @override
  String get report => 'Share weekly report';

  @override
  String get peakPace => 'Peak estimated pace (m/s)';

  @override
  String get cadenceLabel => 'Cadence (steps/min)';

  @override
  String get stepLength => 'Estimated stride length (m per step)';

  @override
  String get gaitLabel => 'Gait regularity (%)';

  @override
  String get fallsLabel => 'Recorded falls';

  @override
  String get dosesLogged => 'Medication entries marked taken';

  @override
  String get recoveryLabel => 'Recovery score';

  @override
  String get steady => 'Steady';

  @override
  String get improving => 'Picking up';

  @override
  String get slower => 'A slower day';

  @override
  String get noBaseline =>
      'Your recovery trend will appear after walks on two different days.';

  @override
  String get lowerDay =>
      'Today was slower. That happens in recovery. Rest well.';

  @override
  String get goal => 'Daily practice goal';

  @override
  String get minuteGoal => 'Walking minutes';

  @override
  String get tasks => 'Your routine';

  @override
  String get simFall => 'Practice fall detected. Are you okay?';

  @override
  String get okay => 'I’m okay';

  @override
  String get firstStage => 'Practice alert for contact one';

  @override
  String get secondStage => 'Practice alert for contact two';

  @override
  String get currentDate => 'Day';

  @override
  String get milestone => 'First 1,000-step day';

  @override
  String get pausedWalk => 'Pausing';

  @override
  String get contactEdit => 'Edit emergency contacts';

  @override
  String get deviceAttach => 'Clip the module firmly onto the cane.';

  @override
  String get searchDevice => 'Find a practice cane';

  @override
  String get calibrate => 'Practice calibration';

  @override
  String get still => 'Stand still for five seconds.';

  @override
  String get motionCheck => 'Checking five simulated steps';

  @override
  String get privacy => 'Profile and practice walks are stored on this device.';

  @override
  String get supplement =>
      'Ask your doctor whether vitamin D or calcium suits you.';

  @override
  String get clinic => 'Physio dashboard';

  @override
  String get localClinic => 'Practice workspace on this device';

  @override
  String get noProfile => 'Set up a patient profile in the patient app first.';

  @override
  String get alerts => 'Changes to review';

  @override
  String get noAlerts => 'No changes flagged in the recorded days.';

  @override
  String get riseLoad => 'Cane load rose since the previous recorded day.';

  @override
  String get dropActivity => 'Steps dropped two days in a row.';

  @override
  String get dropPace => 'Estimated pace fell across three recorded days.';

  @override
  String get targets => 'Practice targets';

  @override
  String get maxSpeed => 'Maximum estimated pace (m/s)';

  @override
  String get maxCadence => 'Maximum cadence (steps/min)';

  @override
  String get maxLoad => 'Maximum cane load (N)';

  @override
  String get saveTargets => 'Save targets';

  @override
  String get breathing => 'Seated breathing';

  @override
  String get approved => 'Physio approval';

  @override
  String get saved => 'Saved on this device.';

  @override
  String get feedback => 'Above your practice target. Take your time.';

  @override
  String get family => 'Family activity summary';

  @override
  String get recipeSteps =>
      'Cook the dal until soft. Serve with plain curd and roti.';

  @override
  String get eggMeal => 'Egg bhurji with spinach and roti';

  @override
  String get eggSteps =>
      'Cook chopped spinach, add beaten egg and stir until fully cooked. Serve with roti.';

  @override
  String get reminderOff =>
      'Saved to your log. Notifications are off on this device.';
}
