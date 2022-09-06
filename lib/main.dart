
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:statuses/AppCubit/appCubit.dart';
import 'package:statuses/AppCubit/appCubitStates.dart';
import 'package:statuses/SplashScreen/SplashScreen.dart';
import 'package:statuses/onBoarding/onBoardingScreen.dart';
import 'package:statuses/shared/local/cashe_helper.dart';

 main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CasheHelper.init();
  await MobileAds.instance.initialize();
  await translator.init(
    localeType: LocalizationDefaultType.device,
    languagesList: <String>['ar', 'en'],
    assetsDirectory: 'Assets/lang/',
  );

  bool dark;
  bool onBoarding ;
  String value;
  CasheHelper.getData(key:'isDark')==null?dark =false:dark=CasheHelper.getData(key:'isDark');
  CasheHelper.getData(key: 'onBoarding')==null?onBoarding=false:onBoarding=true;
  CasheHelper.getData(key:'language')==null?value='English':value=CasheHelper.getData(key:'language');
  dark ? SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      systemNavigationBarDividerColor: Colors.black,
    systemNavigationBarIconBrightness:Brightness.light,
  )):SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
    systemNavigationBarDividerColor: Colors.white,
    systemNavigationBarIconBrightness:Brightness.dark,
  ));
  //Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId("ea603d8e-4080-4d25-a3e5-f745e6a53b75");
// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
   OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
     print("Accepted permission: $accepted");
   });
   OneSignal.shared.setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent event) {
     // Will be called whenever a notification is received in foreground
     // Display Notification, pass null param for not displaying the notification
     event.complete(event.notification);
   });

   OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
     // Will be called whenever a notification is opened/button pressed.
   });

   OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
     // Will be called whenever the permission changes
     // (ie. user taps Allow on the permission prompt in iOS)
   });

   OneSignal.shared.setSubscriptionObserver((OSSubscriptionStateChanges changes) {
     // Will be called whenever the subscription changes
     // (ie. user gets registered with OneSignal and gets a user ID)
   });

   OneSignal.shared.setEmailSubscriptionObserver((OSEmailSubscriptionStateChanges emailChanges) {
     // Will be called whenever then user's email subscription changes
     // (ie. OneSignal.setEmail(email) is called and the user gets registered
   });
  runApp(LocalizedApp(child:MyApp(dark: dark,onBoarding:onBoarding,value: value,)));
}

class MyApp extends StatelessWidget {
  bool dark;
  bool onBoarding;
  String value;
   MyApp({required this.dark, required this.onBoarding,required this.value,Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>AppCubit(InitialAppCubitState())..MakeItDark(fromShared: dark)..createDatabaseForImages()..createDatabaseForvideos()..createDatabaseForQuotes()..AddPhotoesToList()
      ..createDatabaseForArabicQuotes()..createDatabaseForArabicImages()..createDatabaseForArabicvideos(),
      child:BlocConsumer<AppCubit,AppCubitStates>(
            listener: (BuildContext context, state) {  },
            builder: (BuildContext context, Object? state) {
              AppCubit.get(context).value=value;
              return Sizer(
                builder: (BuildContext context, Orientation orientation, deviceType) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Status Lite',
                    theme: ThemeData(
                      checkboxTheme: CheckboxThemeData(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.white,
                        selectedItemColor: HexColor('#7a0000'),
                        unselectedItemColor: Colors.grey,
                        unselectedLabelStyle: const TextStyle(color: Colors.grey),
                        selectedLabelStyle:TextStyle(color: HexColor('#184a2c')),
                        showUnselectedLabels: true,
                        type: BottomNavigationBarType.fixed,
                        showSelectedLabels: true,
                        enableFeedback: false,
                        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,

                      ),
                      primarySwatch: Colors.green,
                      scaffoldBackgroundColor: Colors.white,
                      appBarTheme: const AppBarTheme(
                        color: Colors.green,
                        elevation: 0.0,
                        iconTheme: IconThemeData(
                          color: Colors.black,
                        ),
                        titleTextStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        systemOverlayStyle: const SystemUiOverlayStyle(
                          statusBarColor: Colors.green,
                          statusBarIconBrightness: Brightness.light,
                          systemNavigationBarColor: Colors.white,
                        ),
                      ),
                      bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.black,modalBackgroundColor: Colors.white,),
                    ),
                    darkTheme: ThemeData(
                      progressIndicatorTheme:const ProgressIndicatorThemeData(
                        color: Colors.green,
                      ),
                      textTheme:const TextTheme(
                        bodyText1:const  TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        subtitle1: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      primarySwatch: Colors.green,
                      scaffoldBackgroundColor: Colors.black,
                      appBarTheme: AppBarTheme(
                        actionsIconTheme: const IconThemeData(
                          color: Colors.white,
                        ),
                        titleTextStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                        ),
                        systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: HexColor('0D0D0D'),
                          statusBarIconBrightness: Brightness.light,
                          systemNavigationBarColor: Colors.black,
                        ),
                        backgroundColor: HexColor('0D0D0D'),
                        elevation: 0.0,
                      ),
                      bottomNavigationBarTheme: BottomNavigationBarThemeData(
                        type: BottomNavigationBarType.fixed,
                        selectedItemColor: Colors.green,
                        backgroundColor: HexColor('0D0D0D'),
                        unselectedItemColor: Colors.grey,
                      ),
                      drawerTheme:const DrawerThemeData(
                        backgroundColor: Colors.black,
                      ),
                      backgroundColor: Colors.black,
                      unselectedWidgetColor: Colors.grey,
                      iconTheme:const IconThemeData(color: Colors.black,),
                      indicatorColor: Colors.white,
                      bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.white,modalBackgroundColor: Colors.black,),
                    ),
                    themeMode:AppCubit.get(context).isDark==false? ThemeMode.light : ThemeMode.dark,
                    home: SplashScreen(onBoarding,value),
                    localizationsDelegates: translator.delegates, // Android + iOS Delegates
                    locale: translator.activeLocale, // Active locale
                    supportedLocales: translator.locals(), // Locals list
                  );
                },
              );
            },
          ),
    );
  }
}

