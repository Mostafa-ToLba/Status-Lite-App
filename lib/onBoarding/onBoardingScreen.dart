import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:statuses/AppCubit/appCubit.dart';
import 'package:statuses/HomeScreen/homeScreen.dart';
import 'package:statuses/shared/local/cashe_helper.dart';
import 'package:statuses/shared/styles/icon_broken.dart';

var boardingController = PageController();

class BoardingModel {
//  final String? Image;
  final String? Title;
  final String? Body;
  String? image2;

  BoardingModel({
    this.Title,
    required this.Body,
    this.image2,
  });
}
bool isLast=false;
class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<BoardingModel> Boarding = [
    BoardingModel(
      image2: 'Assets/images/sent.svg',
      Body: 'Media messages',
      Title: 'send and receiver photos and videos with same quality ',
    ),
    BoardingModel(
      image2: 'Assets/images/Journey-amico.svg',
      Body: 'Explore Places',
      Title: 'Discover & Select amazing places and arrive safely to your destination is our first priority',
    ),
    BoardingModel(
      image2: 'Assets/images/Private-data.svg',
      Body: 'Privacy Protection',
      Title: 'All your data and messages are encrypted and safe',
    ),
  ];

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
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness:Brightness.dark ,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarDividerColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 80.h,
              child: PageView.builder(
                itemBuilder: (context, index) =>
                    BoardingItem(context, Boarding[index]),
                itemCount: Boarding.length,
                controller: boardingController,
                physics: BouncingScrollPhysics(),
                onPageChanged: (index)
                {
                  if(index==Boarding.length-1)
                  {
                    setState(() {
                      isLast=true;
                      CasheHelper.putBoolean(key: 'onBoarding', value: true);
                    });

                  }else
                    setState(() {
                      isLast=false;
                    });
                },
              ),
            ),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20,),
                    child: TextButton(
                        onPressed: ()
                        {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                            builder:(context) => HomeScreen(),
                          ), (route) => false);
                          CasheHelper.putBoolean(key: 'onBoarding', value: true);
                        },
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontFamily: 'VarelaRound',
                            fontWeight: FontWeight.w500,
                            color:AppCubit.get(context).isDark?Colors.white: Colors.black,
                          ),
                          textAlign: TextAlign.left,
                        )),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: SmoothPageIndicator(
                      controller: boardingController, // PageController
                      count: 3,
                      textDirection: translator.isDirectionRTL(context)?TextDirection.rtl:TextDirection.ltr,
                      //  effect:  WormEffect(activeDotColor: HexColor('#7a0000'),dotColor: Colors.grey[300]!,dotHeight: .5.h,dotWidth: 6.w
                      effect: ExpandingDotsEffect(
                        dotColor:  Colors.grey,
                        activeDotColor: AppCubit.get(context).isDark==false?Colors.green:Colors.grey,
                        expansionFactor: 2,
                        dotHeight: 7,
                        dotWidth: 7,
                      ),
                    ),
                  ),
                ),
                Expanded(child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: TextButton(onPressed: ()
                  {
                    isLast? Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      builder:(context) => HomeScreen(),
                    ), (route) => false):boardingController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.decelerate);
                  },child:isLast?Text('Done',style: TextStyle(color: AppCubit.get(context).isDark?Colors.white:Colors.black,fontSize: 15.sp,fontFamily: 'VarelaRound',fontWeight: FontWeight.w300),):Icon(translator.isDirectionRTL(context)?IconBroken.Arrow___Left :IconBroken.Arrow___Right,color: AppCubit.get(context).isDark?Colors.white:Colors.black,size: 27,), ),
                ))
              ],
            ),
            SizedBox(
              height: 4.h,
            ),


          ],
        ),
      ),
    );
  }
}

Widget BoardingItem(context, BoardingModel boarding) => Container(
      height: 100.h,
      child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.only(top: 30.h),
            child: Container(
                child: SvgPicture.asset(
              '${boarding.image2}',
              height: 30.h,
              width: double.infinity,
              allowDrawingOutsideViewBox: true,
            )),
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            '${boarding.Body}',
            maxLines: 3,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20.sp,
                fontFamily: 'VarelaRound',
                fontWeight: FontWeight.w600,
                color: AppCubit.get(context).isDark?Colors.white:Colors.black87),
          ),
          SizedBox(
            height: 2.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.h),
            child: Text(
              ' ${boarding.Title}',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'VarelaRound',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppCubit.get(context).isDark?Colors.white:Colors.black),
            ),
          ),
        ],
      ),
    );
