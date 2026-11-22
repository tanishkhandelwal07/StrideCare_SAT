// ignore_for_file: deprecated_member_use
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_pa.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
    Locale('pa'),
  ];

  /// No description provided for @exampleReport.
  ///
  /// In en, this message translates to:
  /// **'Sample weekly report'**
  String get exampleReport;

  /// No description provided for @northIndian.
  ///
  /// In en, this message translates to:
  /// **'North Indian'**
  String get northIndian;

  /// No description provided for @southIndian.
  ///
  /// In en, this message translates to:
  /// **'South Indian'**
  String get southIndian;

  /// No description provided for @mediterranean.
  ///
  /// In en, this message translates to:
  /// **'Mediterranean'**
  String get mediterranean;

  /// No description provided for @eastAsian.
  ///
  /// In en, this message translates to:
  /// **'East Asian'**
  String get eastAsian;

  /// No description provided for @idli.
  ///
  /// In en, this message translates to:
  /// **'Idli with vegetable sambar'**
  String get idli;

  /// No description provided for @idliMethod.
  ///
  /// In en, this message translates to:
  /// **'Steam the idlis. Simmer cooked toor dal with pumpkin, tomato and sambar spices. Spoon the warm sambar over the idlis.'**
  String get idliMethod;

  /// No description provided for @fish.
  ///
  /// In en, this message translates to:
  /// **'Coconut fish curry with rice'**
  String get fish;

  /// No description provided for @fishMethod.
  ///
  /// In en, this message translates to:
  /// **'Simmer tomato, ginger and coconut milk. Add boneless fish and cook through. Serve with rice.'**
  String get fishMethod;

  /// No description provided for @beans.
  ///
  /// In en, this message translates to:
  /// **'White bean and spinach stew'**
  String get beans;

  /// No description provided for @beansMethod.
  ///
  /// In en, this message translates to:
  /// **'Soften garlic in olive oil. Add cooked white beans, chopped tomatoes and water. Simmer until soft and stir in spinach.'**
  String get beansMethod;

  /// No description provided for @chicken.
  ///
  /// In en, this message translates to:
  /// **'Lemon chicken with couscous'**
  String get chicken;

  /// No description provided for @chickenMethod.
  ///
  /// In en, this message translates to:
  /// **'Pan-cook chicken strips with olive oil and oregano until cooked through. Add lemon juice and serve with cooked couscous.'**
  String get chickenMethod;

  /// No description provided for @tofu.
  ///
  /// In en, this message translates to:
  /// **'Ginger tofu and greens'**
  String get tofu;

  /// No description provided for @tofuMethod.
  ///
  /// In en, this message translates to:
  /// **'Pan-fry tofu cubes with grated ginger. Add chopped greens and a splash of water. Cover until tender and serve over rice.'**
  String get tofuMethod;

  /// No description provided for @salmon.
  ///
  /// In en, this message translates to:
  /// **'Steamed salmon with ginger rice'**
  String get salmon;

  /// No description provided for @salmonMethod.
  ///
  /// In en, this message translates to:
  /// **'Steam a boneless salmon fillet until cooked through. Stir grated ginger and spring onion into hot rice. Serve together.'**
  String get salmonMethod;

  /// No description provided for @sampleWeek.
  ///
  /// In en, this message translates to:
  /// **'Explore a sample week'**
  String get sampleWeek;

  /// No description provided for @sampleSource.
  ///
  /// In en, this message translates to:
  /// **'Seven days of simulated cane readings for one fictional patient.'**
  String get sampleSource;

  /// No description provided for @samplePdf.
  ///
  /// In en, this message translates to:
  /// **'Download sample weekly PDF'**
  String get samplePdf;

  /// No description provided for @walkingMinutesSample.
  ///
  /// In en, this message translates to:
  /// **'Walking minutes'**
  String get walkingMinutesSample;

  /// Patient app label.
  ///
  /// In en, this message translates to:
  /// **'StrideCare'**
  String get appName;

  /// Patient app label.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// Patient app label.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progress;

  /// Patient app label.
  ///
  /// In en, this message translates to:
  /// **'Wellness'**
  String get wellness;

  /// Patient app label.
  ///
  /// In en, this message translates to:
  /// **'Medicine'**
  String get medicine;

  /// Patient app label.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Patient app placeholder.
  ///
  /// In en, this message translates to:
  /// **'See the steps from your practice cane.'**
  String get todayHint;

  /// Patient app placeholder.
  ///
  /// In en, this message translates to:
  /// **'Follow the step counter as the practice cane moves.'**
  String get progressHint;

  /// Patient app placeholder.
  ///
  /// In en, this message translates to:
  /// **'Open a meal idea and record your check-in.'**
  String get wellnessHint;

  /// Patient app placeholder.
  ///
  /// In en, this message translates to:
  /// **'Add a medicine, then tick it when taken.'**
  String get medicineHint;

  /// Patient app placeholder.
  ///
  /// In en, this message translates to:
  /// **'Connect the simulated cane to try its readings.'**
  String get settingsHint;

  /// Persistent wellness footer.
  ///
  /// In en, this message translates to:
  /// **'Confirm with your doctor or physio.'**
  String get wellnessAdvice;

  /// Patient interface label.
  ///
  /// In en, this message translates to:
  /// **'Practice cane'**
  String get demo;

  /// Patient interface label.
  ///
  /// In en, this message translates to:
  /// **'Connect practice cane'**
  String get connect;

  /// Patient interface label.
  ///
  /// In en, this message translates to:
  /// **'Disconnect cane'**
  String get disconnect;

  /// Patient interface label.
  ///
  /// In en, this message translates to:
  /// **'Steps this visit'**
  String get stepsLabel;

  /// Patient interface label.
  ///
  /// In en, this message translates to:
  /// **'Estimated pace (m/s)'**
  String get pace;

  /// Patient interface label.
  ///
  /// In en, this message translates to:
  /// **'Meal idea'**
  String get meal;

  /// Patient interface label.
  ///
  /// In en, this message translates to:
  /// **'Dal with curd and roti'**
  String get recipe;

  /// Patient interface label.
  ///
  /// In en, this message translates to:
  /// **'I had this meal'**
  String get logged;

  /// Patient interface label.
  ///
  /// In en, this message translates to:
  /// **'Medicine name'**
  String get medicineName;

  /// Patient interface label.
  ///
  /// In en, this message translates to:
  /// **'Add medicine'**
  String get addMed;

  /// Patient interface label.
  ///
  /// In en, this message translates to:
  /// **'Practice readings and check-ins last for this visit.'**
  String get visit;

  /// Patient interface label.
  ///
  /// In en, this message translates to:
  /// **'Recent step readings'**
  String get readings;

  /// Patient interface label.
  ///
  /// In en, this message translates to:
  /// **'Connect the practice cane in Settings to see readings.'**
  String get noRead;

  /// Patient interface label.
  ///
  /// In en, this message translates to:
  /// **'Taken'**
  String get taken;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get nextStep;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Save profile'**
  String get finishSetup;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Choose your language'**
  String get language;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'What should we call you?'**
  String get personName;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameLabel;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Your height and age'**
  String get measurements;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Height (cm)'**
  String get heightLabel;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Age in years'**
  String get ageLabel;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'What are you recovering from?'**
  String get injury;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Hip fracture'**
  String get hip;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Knee fracture'**
  String get knee;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Ankle fracture'**
  String get ankle;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Joint surgery'**
  String get joint;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Stroke'**
  String get stroke;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Date of injury or surgery'**
  String get dateLabel;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Which side is affected?'**
  String get side;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Left'**
  String get leftSide;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Right'**
  String get rightSide;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Both'**
  String get bothSides;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'First emergency contact'**
  String get firstContact;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Second emergency contact'**
  String get secondContact;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Choose two people to contact after a fall. Practice mode saves their details on this device. Messages and calls are off.'**
  String get contactNote;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Phone with country code'**
  String get phone;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Relationship'**
  String get relationship;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Physio code (optional)'**
  String get codeLabel;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Please fill in this field.'**
  String get requiredField;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Check this number and try again.'**
  String get invalidNumber;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Use a different number for the second person.'**
  String get differentPhone;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t save on this device. Please try again.'**
  String get saveError;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Walk started. Take your time.'**
  String get liveWalk;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Your walk'**
  String get walkSummary;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Steps'**
  String get stepsWord;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Walking time'**
  String get walkTime;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Estimated distance (m)'**
  String get distance;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Cane load trend (N)'**
  String get loadTrend;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Slow'**
  String get slow;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Comfortable'**
  String get comfortable;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Brisk'**
  String get brisk;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Cane not connected. Fix this'**
  String get fixCane;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get connectedLabel;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Pair your practice cane'**
  String get pairTitle;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'This simulated module lets you try a walk without hardware. It begins sending practice readings when connected.'**
  String get pairHint;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Steps today'**
  String get todaySteps;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'See today'**
  String get returnToday;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Walks this week'**
  String get weeklyWalks;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Your walks will appear here as the cane records them.'**
  String get emptyWalks;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Waiting for your physio’s approval'**
  String get approvalLock;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get morning;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get afternoon;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get evening;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Test the buzz'**
  String get testBuzz;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Practice buzz received.'**
  String get buzzOk;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Text size'**
  String get textSize;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Share weekly report'**
  String get report;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Peak estimated pace (m/s)'**
  String get peakPace;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Cadence (steps/min)'**
  String get cadenceLabel;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Estimated stride length (m per step)'**
  String get stepLength;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Gait regularity (%)'**
  String get gaitLabel;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Recorded falls'**
  String get fallsLabel;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Medication entries marked taken'**
  String get dosesLogged;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Recovery score'**
  String get recoveryLabel;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Steady'**
  String get steady;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Picking up'**
  String get improving;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'A slower day'**
  String get slower;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Your recovery trend will appear after walks on two different days.'**
  String get noBaseline;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Today was slower. That happens in recovery. Rest well.'**
  String get lowerDay;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Daily practice goal'**
  String get goal;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Walking minutes'**
  String get minuteGoal;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Your routine'**
  String get tasks;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Practice fall detected. Are you okay?'**
  String get simFall;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'I’m okay'**
  String get okay;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Practice alert for contact one'**
  String get firstStage;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Practice alert for contact two'**
  String get secondStage;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get currentDate;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'First 1,000-step day'**
  String get milestone;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Pausing'**
  String get pausedWalk;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Edit emergency contacts'**
  String get contactEdit;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Clip the module firmly onto the cane.'**
  String get deviceAttach;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Find a practice cane'**
  String get searchDevice;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Practice calibration'**
  String get calibrate;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Stand still for five seconds.'**
  String get still;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Checking five simulated steps'**
  String get motionCheck;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Profile and practice walks are stored on this device.'**
  String get privacy;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Ask your doctor whether vitamin D or calcium suits you.'**
  String get supplement;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Physio dashboard'**
  String get clinic;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Practice workspace on this device'**
  String get localClinic;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Set up a patient profile in the patient app first.'**
  String get noProfile;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Changes to review'**
  String get alerts;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'No changes flagged in the recorded days.'**
  String get noAlerts;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Cane load rose since the previous recorded day.'**
  String get riseLoad;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Steps dropped two days in a row.'**
  String get dropActivity;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Estimated pace fell across three recorded days.'**
  String get dropPace;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Practice targets'**
  String get targets;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Maximum estimated pace (m/s)'**
  String get maxSpeed;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Maximum cadence (steps/min)'**
  String get maxCadence;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Maximum cane load (N)'**
  String get maxLoad;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Save targets'**
  String get saveTargets;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Seated breathing'**
  String get breathing;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Physio approval'**
  String get approved;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Saved on this device.'**
  String get saved;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Above your practice target. Take your time.'**
  String get feedback;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Family activity summary'**
  String get family;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Cook the dal until soft. Serve with plain curd and roti.'**
  String get recipeSteps;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Egg bhurji with spinach and roti'**
  String get eggMeal;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Cook chopped spinach, add beaten egg and stir until fully cooked. Serve with roti.'**
  String get eggSteps;

  /// Patient interface.
  ///
  /// In en, this message translates to:
  /// **'Saved to your log. Notifications are off on this device.'**
  String get reminderOff;

  /// Connected care workspace
  ///
  /// In en, this message translates to:
  /// **'Your changes are synced.'**
  String get planSaved;

  /// Connected care workspace
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// Connected care workspace
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// Connected care workspace
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailAddress;

  /// Connected care workspace
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// Connected care workspace
  ///
  /// In en, this message translates to:
  /// **'Connected care'**
  String get cloudWorkspace;

  /// Connected care workspace
  ///
  /// In en, this message translates to:
  /// **'Check your email, password and connection, then try again.'**
  String get signInError;

  /// Connected care workspace
  ///
  /// In en, this message translates to:
  /// **'Ask your clinic to link this account.'**
  String get noRole;

  /// Connected care workspace
  ///
  /// In en, this message translates to:
  /// **'Assigned patients will appear here.'**
  String get noAssignments;

  /// Connected care workspace
  ///
  /// In en, this message translates to:
  /// **'Recent walks'**
  String get recentWalks;

  /// Connected care workspace
  ///
  /// In en, this message translates to:
  /// **'Couldn’t load shared data. Check your connection and account access.'**
  String get cloudError;

  /// Connected care workspace
  ///
  /// In en, this message translates to:
  /// **'Sync interrupted. Your walks stay on this device. Check your connection.'**
  String get syncProblem;

  /// Patient data sharing.
  ///
  /// In en, this message translates to:
  /// **'Your assigned physio can see synced walks and set targets. Contacts and medicines stay on this device.'**
  String get sharedPrivacy;

  /// Label for illustrative walk totals.
  ///
  /// In en, this message translates to:
  /// **'Sample activity · Practice cane'**
  String get sampleActivity;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi', 'pa'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'pa':
      return AppLocalizationsPa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
