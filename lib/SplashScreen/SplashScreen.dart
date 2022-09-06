import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:statuses/AppCubit/appCubit.dart';
import 'package:statuses/HomeScreen/homeScreen.dart';
import 'package:statuses/onBoarding/onBoardingScreen.dart';



class SplashScreen extends StatefulWidget {
  bool onBoarding;

  String value;

   SplashScreen( this.onBoarding, this.value, {Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

  void initState() {
    super.initState();
    AppCubit.get(context).value=widget.value;

    Timer(Duration(seconds: 4),()
    {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder:(context) => widget.onBoarding||translator.isDirectionRTL(context)? HomeScreen():OnboardingScreen(),
      ), (route) => false);
    });



  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppCubit.get(context).isDark?SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarDividerColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ):SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarDividerColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Container(
          child: ClipRRect(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
            decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
              HexColor('#34ba30'),
              Colors.teal],)),
           //       color: Colors.green,
                    height: double.infinity,
                     width:double.infinity ,
                ),
                Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 100.h,width: double.infinity,
                      child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 16.h),
                    //      Image(image: AssetImage('Assets/images/logo el 7alat h.png',),height: 58.h,width: 58.w,),
                          Image(image: AssetImage('Assets/images/logoResized.png',),height: 58.h,width: 58.w,),
                          SizedBox(height: 8.h),
                          Lottie.asset('Assets/animation/indecator.json',height: 8.h,width: 45.w),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}

