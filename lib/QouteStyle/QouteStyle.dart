

import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:like_button/like_button.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:statuses/AppCubit/appCubitStates.dart';
import 'package:statuses/Models/Qoute%20Model/qouteModel.dart';
import 'package:statuses/Models/typeOfQoutes/typeOfQoutes.dart';
import 'package:statuses/shared/styles/icon_broken.dart';
import '../AppCubit/appCubit.dart';

 class QouteStyle extends StatefulWidget {
   String qoute;
  int index;

   QouteStyle(this.qoute, this.index, {Key? key}) : super(key: key);

  @override
  State<QouteStyle> createState() => _QouteStyleState();
}

class _QouteStyleState extends State<QouteStyle> {
  PageController? contoller;
  late BannerAd _bottomBannerAd;
  bool _isBottomBannerAdLoaded = false;
  void _createBottomBannerAd() {
    _bottomBannerAd = BannerAd(
      adUnitId: Platform.isAndroid?'ca-app-pub-3940256099942544/6300978111':'ca-app-pub-3940256099942544/2934735716',
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBottomBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    _bottomBannerAd.load();
  }
  @override
  void initState() {
    contoller = PageController(initialPage: widget.index, keepPage: true,);
    _createBottomBannerAd();
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    _bottomBannerAd.dispose();
  }

   ScreenshotController screenshotController = ScreenshotController();
   /*
   Future<bool> onLikeButtonTapped(bool isLiked) async{
     if(AppCubit.get(context).IsFavoriteList.containsValue(widget.qoute))
     {
       AppCubit.get(context).deleteeDataForQuoteStylePage(qoute: widget.qoute);
     }
     else
     {
       AppCubit.get(context).insertToDatabaseForQuoteStyle(qoute: widget.qoute);

     }

     return !isLiked;
   }
   bool isLiked =false;


    */
/*
   late final AudioCache _audioCache;

   @override
   initState()   {
     super.initState();
     _audioCache = AudioCache(
       prefix: 'audio/',
       fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP),
     );
     AudioPlayer audioPlayer = AudioPlayer();
      audioPlayer = AudioPlayer(playerId: 'my_unique_playerId');
   }


 */

   @override
   Widget build(BuildContext context) {

     return BlocConsumer<AppCubit,AppCubitStates>(
       listener: (BuildContext context, state) {  },
       builder: (BuildContext context, Object? state) {
         return ConditionalBuilder(
             condition: AppCubit.get(context).Photoess!=null,
             builder: (context)=>AnnotatedRegion<SystemUiOverlayStyle>(
               child: Scaffold(
                 body: translator.isDirectionRTL(context)?PageView.builder(
                   scrollDirection: Axis.horizontal,
                   onPageChanged: (page)
                   {
                     if(AppCubit.get(context).interstialadCountForQuoteStyle==3)
                     {
                       AppCubit.get(context).showInterstialAd();
                     }
                     else if(AppCubit.get(context).interstialadCountForQuoteStyle==0) {
                       AppCubit.get(context).loadInterstialAd();
                     }
                     AppCubit.get(context).adCountForQouteStyle();
                     print('quote == ${AppCubit.get(context).interstialadCountForQuoteStyle}');
                   },
                   itemCount: AppCubit.get(context).ArabicTypeOfQuotesList.length,
                   /*
              List.generate(AppCubit.get(context).videoList.length, (index) => pageView(AppCubit.get(context).videoList[index]),),

               */
                   controller: contoller, itemBuilder: (BuildContext context, int index)=>pageViewForArabic(AppCubit.get(context).ArabicTypeOfQuotesList[index]),
                 ):PageView.builder(
                   scrollDirection: Axis.horizontal,
                   onPageChanged: (page)
                   {
                     if(AppCubit.get(context).interstialadCountForQuoteStyle==3)
                     {
                       AppCubit.get(context).showInterstialAd();
                     }
                     else if(AppCubit.get(context).interstialadCountForQuoteStyle==0) {
                       AppCubit.get(context).loadInterstialAd();
                     }
                     AppCubit.get(context).adCountForQouteStyle();
                     print('quote == ${AppCubit.get(context).interstialadCountForQuoteStyle}');
                   },
                   itemCount: AppCubit.get(context).Quotes.length,
                   /*
              List.generate(AppCubit.get(context).videoList.length, (index) => pageView(AppCubit.get(context).videoList[index]),),

               */
                   controller: contoller, itemBuilder: (BuildContext context, int index)=>pageView(AppCubit.get(context).Quotes[index]),
                 ),
                 /*
                 Stack(
                   children: [
                     Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Container(
                           height: 100.h,
                           decoration:  BoxDecoration(image:  DecorationImage(fit: BoxFit.cover,image: AppCubit.get(context).Photoess[AppCubit.get(context).change])),
                           child: InkWell(
                             splashColor: Colors.transparent,
                             highlightColor: Colors.transparent,
                             onTap: ()
                             async {
                               setState(() {
                                 AppCubit.get(context).ChangePhoto();
                               });
                             },
                             child: Column(
                               mainAxisSize: MainAxisSize.max,
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Container(height: 10.h,padding: EdgeInsetsDirectional.zero),
                                 Container(
                                   padding: EdgeInsetsDirectional.zero,
                                   height: 78.h,
                                   child: Padding(
                                     padding:  EdgeInsets.only(right: 5.w,left: 5.w,top: 0.h ),
                                     child: Center(
                                       child: Text(
                                         widget.qoute,
                                         textAlign: TextAlign.center,
                                         style: TextStyle(
                                             height: AppCubit.get(context).GetDeviceTypeOfStyleScreen(),
                                             color: Colors.white,
                                             fontFamily: AppCubit.get(context).Texts[AppCubit.get(context).changeText],
                                             fontSize: AppCubit.get(context).forChangeFontSize(context),
                                             fontWeight: FontWeight.w600),
                                            overflow:TextOverflow.visible,
                                       ),
                                     ),
                                   ),
                                 ),
                                 const Spacer(),
                                 if(SizerUtil.deviceType==DeviceType.mobile)
                                 Container(
                                   padding: EdgeInsetsDirectional.zero,
                                   height: 9.h,
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     children: [
                                       Container(
                                         decoration: const BoxDecoration(shape: BoxShape.circle,backgroundBlendMode: BlendMode.softLight,color: Colors.white),
                                         child: IconButton(
                                             splashColor: Colors.transparent,
                                             highlightColor: Colors.transparent,
                                             iconSize: 20.sp,
                                             splashRadius: 26.sp,
                                             onPressed: () async{
                                               final data = ClipboardData(text: widget.qoute);
                                               Clipboard.setData(data);
                                               Fluttertoast.showToast(msg: 'copied to clipboard',gravity: ToastGravity.CENTER);
                                             },
                                             padding: EdgeInsets.zero,
                                             icon: const Icon(
                                               MdiIcons.contentCopy,
                                               color: Colors.white,
                                             )),
                                       ),
                                       SizedBox(width: 6.w,),
                                       Container(
                                         decoration: const BoxDecoration(shape: BoxShape.circle,backgroundBlendMode: BlendMode.softLight,color: Colors.white),
                                         child: IconButton(

                                             splashColor: Colors.transparent,
                                             highlightColor: Colors.transparent,
                                             iconSize: 20.sp,
                                             splashRadius: 26.sp,
                                             onPressed: ()
                                              async {
                                               /*
                                               if(AppCubit.get(context).music==true)
                                               {
                                                 final file = await AudioCache().loadAsFile('mixin.wav');
                                                 final bytes = await file.readAsBytes();
                                                 AudioCache().playBytes(bytes);
                                               }

                                               ShareFilesAndScreenshotWidgets().shareScreenshot(
                                                 AppCubit.get(context).previewContainer,
                                                 1000,
                                                 "Title",
                                                 "Name.png",
                                                 "image/png",
                                               );

                                                */
                                               Clipboard.setData(const ClipboardData());
                                               Share.share('${widget.qoute}');

                                             },
                                             padding: EdgeInsets.zero,
                                             icon: const Icon(
                                               MdiIcons.shareVariant,
                                               color: Colors.white,
                                             )),
                                       ),
                                       SizedBox(width: 6.w,),
                                       Container(
                                         decoration: const BoxDecoration(shape: BoxShape.circle,backgroundBlendMode: BlendMode.softLight,color: Colors.white),
                                         child: IconButton(
                                             splashColor: Colors.transparent,
                                             highlightColor: Colors.transparent,
                                             alignment: AlignmentDirectional.center,
                                             iconSize: 20.sp,
                                             splashRadius: 26.sp,
                                             onPressed: () async{
                                               setState(() {
                                                 AppCubit.get(context).ChangeText();
                                               });
                                             },
                                             padding: EdgeInsets.zero,
                                             icon: Image(fit: BoxFit.cover,color: Colors.white,
                                               alignment: AlignmentDirectional.center,
                                               height: 17.5.sp,
                                               image: const AssetImage('Assets/images/type.png'),
                                             )),
                                       ),
                                       SizedBox(width: 6.w,),
                                       /*
                           IconButton(
                               iconSize: 20.sp,
                               splashRadius: 26.sp,
                               splashColor: Colors.grey,
                               onPressed: ()
                               {
                                   AppCubit.get(context).insertToDatabase(qoute: widget.qoute);
                                   Fluttertoast.showToast(msg: 'Added Successfully to favorites',gravity: ToastGravity.CENTER);
                               },
                               padding: EdgeInsets.zero,
                               icon: Icon(
                                   Icons.favorite,
                                   color: Colors.blue,
                               )),

                            */
                                       Container(
                                         decoration: const BoxDecoration(shape: BoxShape.circle,backgroundBlendMode: BlendMode.softLight,color: Colors.white),
                                         child: IconButton(
                                           onPressed: () {  },
                                           icon: LikeButton(
                                             padding: EdgeInsets.zero,
                                             size: 20.sp,
                                             circleColor:
                                             const CircleColor(start: Colors.white, end: Colors.white),
                                             bubblesColor: const BubblesColor(
                                               dotPrimaryColor: Colors.white,
                                               dotSecondaryColor: Colors.white,
                                               dotLastColor: Colors.white,
                                               dotThirdColor: Colors.white,
                                             ),
                                               onTap: onLikeButtonTapped,
                                               isLiked: isLiked,
                                             likeBuilder: ( isLiked) {
                                               return Padding(
                                                 padding:  EdgeInsets.only(top: .5.sp),
                                                 child: Icon(
                                                   AppCubit.get(context).function(widget.qoute)? Icons.favorite_outline:Icons.favorite,
                                                   color: isLiked ? Colors.white : Colors.white,
                                                   size: 20.sp,
                                                 ),
                                               );
                                             },
                                           ),
                                         ),
                                       ),
                                       SizedBox(width: 6.w,),
                                       Container(
                                         decoration: const BoxDecoration(shape: BoxShape.circle,backgroundBlendMode: BlendMode.softLight,color: Colors.white),
                                         child: IconButton(
                                             splashColor: Colors.transparent,
                                             highlightColor: Colors.transparent,
                                             alignment: AlignmentDirectional.center,
                                             iconSize: 20.sp,
                                             splashRadius: 26.sp,
                                             onPressed: () async{
                                               setState(() {
                                                 AppCubit.get(context).ChangePhoto();
                                               });
                                             },
                                             padding: EdgeInsets.zero,
                                             icon: Padding(
                                               padding:  EdgeInsets.only(top: .0.sp,left: 3.sp),
                                               child: Image(fit: BoxFit.cover,color: Colors.white,
                                                 alignment: AlignmentDirectional.center,
                                                 height: 20.5.sp,
                                                 image:  const AssetImage('Assets/images/paint.png'),
                                               ),
                                             )),
                                       ),
                                     ],
                                   ),

                                 ),
                                 if(SizerUtil.deviceType==DeviceType.tablet)
                                   Expanded(flex: 1,
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       crossAxisAlignment: CrossAxisAlignment.center,
                                       children: [
                                         Container(
                                           decoration: const BoxDecoration(shape: BoxShape.circle,backgroundBlendMode: BlendMode.softLight,color: Colors.white),
                                           child: IconButton(
                                               splashColor: Colors.transparent,
                                               highlightColor: Colors.transparent,
                                               iconSize: 17.sp,
                                               splashRadius: 26.sp,
                                               onPressed: () async{
                                                 final data = ClipboardData(text: widget.qoute);
                                                 Clipboard.setData(data);
                                                 Fluttertoast.showToast(msg: 'copied to clipboard',gravity: ToastGravity.CENTER);
                                               },
                                               padding: EdgeInsets.zero,
                                               icon: const Icon(
                                                 MdiIcons.contentCopy,
                                                 color: Colors.white,
                                               )),
                                           height: 10.h,
                                           width: 10.w,
                                         ),
                                         SizedBox(width: 6.w,),
                                         Container(
                                           height: 10.h,
                                           width: 10.w,
                                           decoration: const BoxDecoration(shape: BoxShape.circle,backgroundBlendMode: BlendMode.softLight,color: Colors.white),
                                           child: IconButton(

                                               splashColor: Colors.transparent,
                                               highlightColor: Colors.transparent,
                                               iconSize: 17.sp,
                                               splashRadius: 26.sp,
                                               onPressed: ()
                                               async {
                                                 /*
                                                 if(AppCubit.get(context).music==true)
                                                 {
                                                   final file = await AudioCache().loadAsFile('mixin.wav');
                                                   final bytes = await file.readAsBytes();
                                                   AudioCache().playBytes(bytes);
                                                 }
                                                 /*
                                               ShareFilesAndScreenshotWidgets().shareScreenshot(
                                                 previewContainer,
                                                 1000,
                                                 "Title",
                                                 "Name.png",
                                                 "image/png",
                                               );

                                                */

                                                 Clipboard.setData(ClipboardData());
                                                 HapticFeedback.heavyImpact();
                                                 Share.share('${widget.qoute}');

                                                  */
                                                 Clipboard.setData(const ClipboardData());
                                                 Share.share('${widget.qoute}');
                                               },
                                               padding: EdgeInsets.zero,
                                               icon: const Icon(
                                                 MdiIcons.shareVariant,
                                                 color: Colors.white,
                                               )),
                                         ),
                                         SizedBox(width: 6.w,),
                                         Container(
                                           height: 10.h,
                                           width: 10.w,
                                           decoration: const BoxDecoration(shape: BoxShape.circle,backgroundBlendMode: BlendMode.softLight,color: Colors.white),
                                           child: IconButton(
                                               splashColor: Colors.transparent,
                                               highlightColor: Colors.transparent,
                                               alignment: AlignmentDirectional.center,
                                               iconSize: 17.sp,
                                               splashRadius: 26.sp,
                                               onPressed: () async{
                                                 setState(() {
                                                   AppCubit.get(context).ChangeText();
                                                 });
                                               },
                                               padding: EdgeInsets.zero,
                                               icon: Image(fit: BoxFit.cover,color: Colors.white,
                                                 alignment: AlignmentDirectional.center,
                                                 height: 15.sp,
                                                 image: const AssetImage('Assets/images/type.png'),
                                               )),
                                         ),
                                         SizedBox(width: 6.w,),
                                         /*
                           IconButton(
                               iconSize: 20.sp,
                               splashRadius: 26.sp,
                               splashColor: Colors.grey,
                               onPressed: ()
                               {
                                   AppCubit.get(context).insertToDatabase(qoute: widget.qoute);
                                   Fluttertoast.showToast(msg: 'Added Successfully to favorites',gravity: ToastGravity.CENTER);
                               },
                               padding: EdgeInsets.zero,
                               icon: Icon(
                                   Icons.favorite,
                                   color: Colors.blue,
                               )),

                            */
                                         Container(
                                           height: 10.h,
                                           width: 10.w,
                                           decoration: const BoxDecoration(shape: BoxShape.circle,backgroundBlendMode: BlendMode.softLight,color: Colors.white),
                                           child: IconButton(
                                             onPressed: () {  },
                                             icon: LikeButton(
                                               padding: EdgeInsets.zero,
                                               size: 20.sp,
                                               circleColor:
                                               const CircleColor(start: Colors.white, end: Colors.white),
                                               bubblesColor: const BubblesColor(
                                                 dotPrimaryColor: Colors.white,
                                                 dotSecondaryColor: Colors.white,
                                                 dotLastColor: Colors.white,
                                                 dotThirdColor: Colors.white,
                                               ),
                                               onTap: onLikeButtonTapped,
                                               isLiked: isLiked,
                                               likeBuilder: ( isLiked) {
                                                 return Padding(
                                                   padding:  EdgeInsets.only(top: .5.sp),
                                                   child: Icon(
                                                     AppCubit.get(context).function(widget.qoute)? Icons.favorite_outline:Icons.favorite,
                                                     color: isLiked ? Colors.green : Colors.green,
                                                     size: 20.sp,
                                                   ),
                                                 );
                                               },
                                             ),
                                           ),
                                         ),
                                         SizedBox(width: 6.w,),
                                         Container(
                                           height: 10.h,
                                           width: 10.w,
                                           decoration: const BoxDecoration(shape: BoxShape.circle,backgroundBlendMode: BlendMode.softLight,color: Colors.white),
                                           child: IconButton(
                                               splashColor: Colors.transparent,
                                               highlightColor: Colors.transparent,
                                               alignment: AlignmentDirectional.center,
                                               iconSize: 17.sp,
                                               splashRadius: 26.sp,
                                               onPressed: () async{
                                                 setState(() {
                                                   AppCubit.get(context).ChangePhoto();
                                                 });
                                               },
                                               padding: EdgeInsets.zero,
                                               icon: Padding(
                                                 padding:  EdgeInsets.only(top: .0.sp,left: 3.sp),
                                                 child: Image(fit: BoxFit.cover,color: Colors.white,
                                                   alignment: AlignmentDirectional.center,
                                                   height: 18.sp,
                                                   image:  const AssetImage('Assets/images/paint.png'),
                                                 ),
                                               )),
                                         ),
                                       ],
                                     ),
                                   ),
                                 SizedBox(height: 2.h),
                               ],
                             ),
                           ),
                         ),
                         /*
                         Container(
                           padding: EdgeInsets.zero,
                           //  height: 7.h,
                           width: double.infinity,
                           /*
                           decoration:  BoxDecoration(
                             color: Colors.grey[300],
                           ),

                            */

                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                               IconButton(
                                   splashColor: Colors.transparent,
                                   highlightColor: Colors.transparent,
                                   iconSize: 20.sp,
                                   splashRadius: 26.sp,
                                   onPressed: () async{
                                     final data = ClipboardData(text: widget.qoute);
                                     Clipboard.setData(data);
                                     Fluttertoast.showToast(msg: 'copied to clipboard',gravity: ToastGravity.CENTER);
                                     final file = await AudioCache().loadAsFile('mixin.wav');
                                     final bytes = await file.readAsBytes();
                                     AudioCache().playBytes(bytes);
                                   },
                                   padding: EdgeInsets.zero,
                                   icon: const Icon(
                                     MdiIcons.contentCopy,
                                     color: Colors.blue,
                                   )),
                               SizedBox(width: 6.w,),
                               IconButton(

                                   splashColor: Colors.transparent,
                                   highlightColor: Colors.transparent,
                                   iconSize: 20.sp,
                                   splashRadius: 26.sp,
                                   onPressed: ()
                                   async{
                                     final file = await AudioCache().loadAsFile('mixin.wav');
                                     final bytes = await file.readAsBytes();
                                     AudioCache().playBytes(bytes);
                                     ShareFilesAndScreenshotWidgets().shareScreenshot(
                                       previewContainer,
                                       1000,
                                       "Title",
                                       "Name.png",
                                       "image/png",
                                     );
                                   },
                                   padding: EdgeInsets.zero,
                                   icon: const Icon(
                                     MdiIcons.shareVariant,
                                     color: Colors.blue,
                                   )),
                               SizedBox(width: 6.w,),
                               IconButton(
                                   splashColor: Colors.transparent,
                                   highlightColor: Colors.transparent,
                                   alignment: AlignmentDirectional.center,
                                   iconSize: 20.sp,
                                   splashRadius: 26.sp,
                                   onPressed: () async{
                                     final file = await AudioCache().loadAsFile('mixin.wav');
                                     final bytes = await file.readAsBytes();
                                     AudioCache().playBytes(bytes);
                                     AppCubit.get(context).ChangeText();
                                   },
                                   padding: EdgeInsets.zero,
                                   icon: Padding(
                                     padding:  EdgeInsets.only(top: .8.sp),
                                     child: Image(fit: BoxFit.cover,color: Colors.blue,
                                       alignment: AlignmentDirectional.center,
                                       height: 18.sp,
                                       image: const AssetImage('assets/images/change.png'),
                                     ),
                                   )),
                               SizedBox(width: 6.w,),
                               /*
                               IconButton(
                                   iconSize: 20.sp,
                                   splashRadius: 26.sp,
                                   splashColor: Colors.grey,
                                   onPressed: ()
                                   {
                                     AppCubit.get(context).insertToDatabase(qoute: widget.qoute);
                                     Fluttertoast.showToast(msg: 'Added Successfully to favorites',gravity: ToastGravity.CENTER);
                                   },
                                   padding: EdgeInsets.zero,
                                   icon: Icon(
                                     Icons.favorite,
                                     color: Colors.blue,
                                   )),

                                */
                               LikeButton(
                                 padding: EdgeInsets.zero,
                                 size: 20.sp,
                                 circleColor:
                                 const CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
                                 bubblesColor: const BubblesColor(
                                   dotPrimaryColor: Colors.red,
                                   dotSecondaryColor: Colors.orange,
                                   dotLastColor: Colors.purple,
                                   dotThirdColor: Colors.pink,
                                 ),
                                 onTap: onLikeButtonTapped,
                                 isLiked: isLiked,
                                 likeBuilder: ( isLiked) {
                                   return Padding(
                                     padding:  EdgeInsets.only(top: .5.sp),
                                     child: Icon(
                                       AppCubit.get(context).function(widget.qoute)? Icons.favorite_outline:Icons.favorite,
                                       color: isLiked ? Colors.red : Colors.blue,
                                       size: 21.sp,
                                     ),
                                   );
                                 },
                               ),
                               SizedBox(width: 6.w,),
                               IconButton(
                                   splashColor: Colors.transparent,
                                   highlightColor: Colors.transparent,
                                   alignment: AlignmentDirectional.center,
                                   iconSize: 20.sp,
                                   splashRadius: 26.sp,
                                   onPressed: () async{
                                     final file = await AudioCache().loadAsFile('mixin.wav');
                                     final bytes = await file.readAsBytes();
                                     AudioCache().playBytes(bytes);
                                     AppCubit.get(context).ChangePhoto();
                                   },
                                   padding: EdgeInsets.zero,
                                   icon: Padding(
                                     padding:  EdgeInsets.only(top: .8.sp),
                                     child: Image(fit: BoxFit.cover,color: Colors.blue,
                                       alignment: AlignmentDirectional.center,
                                       height: 20.sp,
                                       image: const AssetImage('assets/images/paint.png'),
                                     ),
                                   )),
                             ],
                           ),
                         ),

                          */
                       ],
                     ),
                    if(SizerUtil.deviceType==DeviceType.mobile)
                     Padding(
                       padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
                       child: Container(
                         decoration: const BoxDecoration(shape: BoxShape.circle,backgroundBlendMode: BlendMode.softLight,color: Colors.white),
                         child: IconButton(onPressed: () async {
                           Navigator.pop(context);
                         }, icon: Icon(IconBroken.Arrow___Left,size:18.sp),
                           splashColor: Colors.transparent,color: Colors.white,
                           highlightColor: Colors.transparent,

                         ),
                       ),
                     ),
                     if(SizerUtil.deviceType==DeviceType.tablet)
                       Padding(
                         padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
                         child: Container(
                           decoration: const BoxDecoration(shape: BoxShape.circle,backgroundBlendMode: BlendMode.softLight,color: Colors.white),
                           child: IconButton(onPressed: () async {
                             Navigator.pop(context);
                           }, icon: Icon(IconBroken.Arrow___Left,size:18.sp),
                             splashColor: Colors.transparent,color: Colors.white,
                             highlightColor: Colors.transparent,

                           ),
                           height: 10.h,
                           width: 10.w,
                         ),
                       ),
                   ],
                 ),

                  */
                 bottomNavigationBar:_isBottomBannerAdLoaded
                     ? Container(
                   color: AppCubit.get(context).isDark
                       ? Colors.black
                       : Colors.white,
                   height: _bottomBannerAd.size.height.toDouble(),
                   width: _bottomBannerAd.size.width.toDouble(),
                   child: AdWidget(ad: _bottomBannerAd),
                 )
                     : null,
               ),
               value: const SystemUiOverlayStyle(
                 statusBarColor: Colors.transparent,
                 statusBarIconBrightness:  Brightness.light,
               ),
             ),
             fallback: (context)=>const Center(child: CircularProgressIndicator()));
       },
     );
   }
}

 class pageView extends StatefulWidget {
  TypeOfQoutesModel quote;
    pageView( this.quote,{Key? key}) : super(key: key);

   @override
   _pageViewState createState() => _pageViewState();
 }

 class _pageViewState extends State<pageView> {
   bool isLiked =false;
   Future<bool> onLikeButtonTapped(bool isLiked,) async{

     if(AppCubit.get(context).IsFavoriteQuotesList.containsValue(widget.quote.Qoute))
     {
       AppCubit.get(context).deleteeData(quote:widget.quote.Qoute).then((value)
       {
           AppCubit.get(context).getDataFromQuotesStyleDatabase(AppCubit.get(context).databaseForQuotes);
       });
       /*
                 .then((value)
             {

               Fluttertoast.showToast(msg: 'Deleted from favorites',gravity: ToastGravity.CENTER,backgroundColor: Colors.red);
             });

              */
     }
     else
     {
       AppCubit.get(context).insertToDatabaseForQuotes(quote: widget.quote.Qoute).then((value){
           AppCubit.get(context).getDataFromQuotesStyleDatabase(AppCubit.get(context).databaseForQuotes);
       });
     }

     return !isLiked;
   }
   @override
   Widget build(BuildContext context) {
     return BlocConsumer<AppCubit,AppCubitStates>(listener: (BuildContext context, state) {  },
     builder: (BuildContext context, Object? state) {
       return Scaffold(
         body: Stack(
           children: [
             Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Expanded(
                   child: Container(
                     decoration:  BoxDecoration(image:  DecorationImage(fit: BoxFit.cover,image: AppCubit.get(context).Photoess[AppCubit.get(context).change])),
                     child: InkWell(
                       splashColor: Colors.transparent,
                       highlightColor: Colors.transparent,
                       onTap: ()
                       async {
                         setState(() {
                           AppCubit.get(context).ChangePhoto();
                         });
                       },
                       child: Column(
                         mainAxisSize: MainAxisSize.max,
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Expanded(flex: 2,
                               child: Container(height: 30.h,)),
                           Expanded(
                             flex: 10,
                             child: Container(
                               padding: EdgeInsetsDirectional.zero,
                       //      height: 79.5.h,
                               child: Padding(
                                 padding:  EdgeInsets.only(right: 4.w,left: 4.w,top: 0.h ),
                                 child: Center(
                                   child: Text(
                                     widget.quote.Qoute!,
                                     textAlign: TextAlign.center,
                                     style: TextStyle(
                                         height: AppCubit.get(context).GetDeviceTypeOfStyleScreen(),
                                         color: Colors.white,
                                         fontFamily: AppCubit.get(context).Texts[AppCubit.get(context).changeText],
                                         fontSize: AppCubit.get(context).forChangeFontSize(context),
                                         fontWeight: FontWeight.bold),
                                     overflow:TextOverflow.visible,
                                   ),
                                 ),
                               ),
                             ),
                           ),
                            Spacer(),
                           if(SizerUtil.deviceType==DeviceType.mobile)
                             Expanded(
                               flex: 1,
                               child: Container(
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                     Container(
                                       decoration: const BoxDecoration(shape: BoxShape.circle,backgroundBlendMode: BlendMode.softLight,color: Colors.white),
                                       child: IconButton(
                                           splashColor: Colors.transparent,
                                           highlightColor: Colors.transparent,
                                           iconSize: 20.sp,
                                           splashRadius: 26.sp,
                                           onPressed: () async{
                                             final data = ClipboardData(text: widget.quote.Qoute);
                                             Clipboard.setData(data);
                                             Fluttertoast.showToast(msg: 'Copy'.tr(),gravity: ToastGravity.CENTER,fontSize: 12.sp);
                                           },
                                           padding: EdgeInsets.zero,
                                           icon: const Icon(
                                             MdiIcons.contentCopy,
                                             color: Colors.white,
                                           )),
                                     ),
                                     SizedBox(width: 6.w,),
                                     Container(
                                       decoration: const BoxDecoration(shape: BoxShape.circle,backgroundBlendMode: BlendMode.softLight,color: Colors.white),
                                       child: IconButton(

                                           splashColor: Colors.transparent,
                                           highlightColor: Colors.transparent,
                                           iconSize: 20.sp,
                                           splashRadius: 26.sp,
                                           onPressed: ()
                                           async {
                                             /*
                                                   if(AppCubit.get(context).music==true)
                                                   {
                                                     final file = await AudioCache().loadAsFile('mixin.wav');
                                                     final bytes = await file.readAsBytes();
                                                     AudioCache().playBytes(bytes);
                                                   }

                                                   ShareFilesAndScreenshotWidgets().shareScreenshot(
                                                     AppCubit.get(context).previewContainer,
                                                     1000,
                                                     "Title",
                                                     "Name.png",
                                                     "image/png",
                                                   );

                                                    */
                                             Clipboard.setData(const ClipboardData());
                                             Share.share('${widget.quote.Qoute}');

                                           },
                                           padding: EdgeInsets.zero,
                                           icon: const Icon(
                                             MdiIcons.shareVariant,
                                             color: Colors.white,
                                           )),
                                     ),
                                     SizedBox(width: 6.w,),
                                     Container(
                                       decoration: const BoxDecoration(shape: BoxShape.circle,backgroundBlendMode: BlendMode.softLight,color: Colors.white),
                                       child: IconButton(
                                           splashColor: Colors.transparent,
                                           highlightColor: Colors.transparent,
                                           alignment: AlignmentDirectional.center,
                                           iconSize: 20.sp,
                                           splashRadius: 26.sp,
                                           onPressed: () async{
                                             setState(() {
                                               AppCubit.get(context).ChangeText();
                                             });
                                           },
                                           padding: EdgeInsets.zero,
                                           icon: Image(fit: BoxFit.cover,color: Colors.white,
                                             alignment: AlignmentDirectional.center,
                                             height: 17.5.sp,
                                             image: const AssetImage('Assets/images/type.png'),
                                           )),
                                     ),
                                     SizedBox(width: 6.w,),
                                     /*
                               IconButton(
                                   iconSize: 20.sp,
                                   splashRadius: 26.sp,
                                   splashColor: Colors.grey,
                                   onPressed: ()
                                   {
                                       AppCubit.get(context).insertToDatabase(qoute: widget.qoute);
                                       Fluttertoast.showToast(msg: 'Added Successfully to favorites',gravity: ToastGravity.CENTER);
                                   },
                                   padding: EdgeInsets.zero,
                                   icon: Icon(
                                       Icons.favorite,
                                       color: Colors.blue,
                                   )),

                                */
                                     Container(
                                       decoration: const BoxDecoration(shape: BoxShape.circle,backgroundBlendMode: BlendMode.softLight,color: Colors.white),
                                       child: IconButton(
                                         onPressed: () {  },
                                         icon: LikeButton(
                                           padding: EdgeInsets.only(right: 0),
                                           size: 18.sp,
                                           circleColor:
                                           const CircleColor(start: Colors.white, end: Colors.white),
                                           bubblesColor: const BubblesColor(
                                             dotPrimaryColor: Colors.white,
                                             dotSecondaryColor: Colors.white,
                                             dotLastColor: Colors.white,
                                             dotThirdColor: Colors.white,
                                           ),
                                           onTap: onLikeButtonTapped,
                                           isLiked: isLiked,
                                           likeBuilder: ( isLiked) {
                                             return Center(
                                               child: Icon(
                                                 AppCubit.get(context).function(widget.quote.Qoute)? Icons.favorite_outline:Icons.favorite,
                                                 color: isLiked ? Colors.white : Colors.white,
                                                 size: 20.sp,
                                               ),
                                             );
                                           },
                                         ),
                                       ),
                                     ),
                                     SizedBox(width: 6.w,),
                                     Container(
                                       decoration: const BoxDecoration(shape: BoxShape.circle,backgroundBlendMode: BlendMode.softLight,color: Colors.white),
                                       child: IconButton(
                                           splashColor: Colors.transparent,
                                           highlightColor: Colors.transparent,
                                           alignment: AlignmentDirectional.center,
                                           iconSize: 20.sp,
                                           splashRadius: 26.sp,
                                           onPressed: () async{
                                             setState(() {
                                               AppCubit.get(context).ChangePhoto();
                                             });
                                           },
                                           padding: EdgeInsets.zero,
                                           icon: Padding(
                                             padding:  EdgeInsets.only(top: .0.sp,left: 3.sp),
                                             child: Image(fit: BoxFit.cover,color: Colors.white,
                                               alignment: AlignmentDirectional.center,
                                               height: 20.5.sp,
                                               image:  const AssetImage('Assets/images/paint.png'),
                                             ),
                                           )),
                                     ),
                                   ],
                                 ),

                               ),
                             ),
                           if(SizerUtil.deviceType==DeviceType.tablet)
                             Expanded(flex:1,
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 children: [
                                   Container(
                                     decoration: const BoxDecoration(shape: BoxShape.circle,backgroundBlendMode: BlendMode.softLight,color: Colors.white),
                                     child: IconButton(
                                         splashColor: Colors.transparent,
                                         highlightColor: Colors.transparent,
                                         iconSize: 17.sp,
                                         splashRadius: 26.sp,
                                         onPressed: () async{
                                           final data = ClipboardData(text: widget.quote.Qoute);
                                           Clipboard.setData(data);
                                           Fluttertoast.showToast(msg: 'Copy'.tr(),gravity: ToastGravity.CENTER,fontSize: 5.sp);
                                         },
                                         padding: EdgeInsets.zero,
                                         icon: const Icon(
                                           MdiIcons.contentCopy,
                                           color: Colors.white,
                                         )),
                                     height: 10.h,
                                     width: 10.w,
                                   ),
                                   SizedBox(width: 6.w,),
                                   Container(
                                     height: 10.h,
                                     width: 10.w,
                                     decoration: const BoxDecoration(shape: BoxShape.circle,backgroundBlendMode: BlendMode.softLight,color: Colors.white),
                                     child: IconButton(

                                         splashColor: Colors.transparent,
                                         highlightColor: Colors.transparent,
                                         iconSize: 17.sp,
                                         splashRadius: 26.sp,
                                         onPressed: ()
                                         async {
                                           /*
                                                   if(AppCubit.get(context).music==true)
                                                   {
                                                     final file = await AudioCache().loadAsFile('mixin.wav');
                                                     final bytes = await file.readAsBytes();
                                                     AudioCache().playBytes(bytes);
                                                   }
                                                   /*
                                                 ShareFilesAndScreenshotWidgets().shareScreenshot(
                                                   previewContainer,
                                                   1000,
                                                   "Title",
                                                   "Name.png",
                                                   "image/png",
                                                 );

                                                  */

                                                   Clipboard.setData(ClipboardData());
                                                   HapticFeedback.heavyImpact();
                                                   Share.share('${widget.qoute}');

                                                    */
                                           Clipboard.setData(const ClipboardData());
                                           Share.share('${widget.quote.Qoute}');
                                         },
                                         padding: EdgeInsets.zero,
                                         icon: const Icon(
                                           MdiIcons.shareVariant,
                                           color: Colors.white,
                                         )),
                                   ),
                                   SizedBox(width: 6.w,),
                                   Container(
                                     height: 10.h,
                                     width: 10.w,
                                     decoration: const BoxDecoration(shape: BoxShape.circle,backgroundBlendMode: BlendMode.softLight,color: Colors.white),
                                     child: IconButton(
                                         splashColor: Colors.transparent,
                                         highlightColor: Colors.transparent,
                                         alignment: AlignmentDirectional.center,
                                         iconSize: 17.sp,
                                         splashRadius: 26.sp,
                                         onPressed: () async{
                                           setState(() {
                                             AppCubit.get(context).ChangeText();
                                           });
                                         },
                                         padding: EdgeInsets.zero,
                                         icon: Image(fit: BoxFit.cover,color: Colors.white,
                                           alignment: AlignmentDirectional.center,
                                           height: 15.sp,
                                           image: const AssetImage('Assets/images/type.png'),
                                         )),
                                   ),
                                   SizedBox(width: 6.w,),
                                   /*
                             IconButton(
                                 iconSize: 20.sp,
                                 splashRadius: 26.sp,
                                 splashColor: Colors.grey,
                                 onPressed: ()
                                 {
                                     AppCubit.get(context).insertToDatabase(qoute: widget.qoute);
                                     Fluttertoast.showToast(msg: 'Added Successfully to favorites',gravity: ToastGravity.CENTER);
                                 },
                                 padding: EdgeInsets.zero,
                                 icon: Icon(
                                     Icons.favorite,
                                     color: Colors.blue,
                                 )),

                              */
                                   Container(
                                     height: 10.h,
                                     width: 10.w,
                                     decoration: const BoxDecoration(shape: BoxShape.circle,backgroundBlendMode: BlendMode.softLight,color: Colors.white),
                                     child: IconButton(
                                       onPressed: () {  },
                                       icon: LikeButton(
                                         padding: EdgeInsets.zero,
                                         size: 18.sp,
                                         circleColor:
                                         const CircleColor(start: Colors.white, end: Colors.white),
                                         bubblesColor: const BubblesColor(
                                           dotPrimaryColor: Colors.white,
                                           dotSecondaryColor: Colors.white,
                                           dotLastColor: Colors.white,
                                           dotThirdColor: Colors.white,
                                         ),
                                         onTap: onLikeButtonTapped,
                                         isLiked: isLiked,
                                         likeBuilder: ( isLiked) {
                                           return Center(
                                             child: Icon(
                                               AppCubit.get(context).function(widget.quote.Qoute)? Icons.favorite_outline:Icons.favorite,
                                               color: isLiked ? Colors.white : Colors.white,
                                               size: 19.sp,
                                             ),
                                           );
                                         },
                                       ),
                                     ),
                                   ),
                                   SizedBox(width: 6.w,),
                                   Container(
                                     height: 10.h,
                                     width: 10.w,
                                     decoration: const BoxDecoration(shape: BoxShape.circle,backgroundBlendMode: BlendMode.softLight,color: Colors.white),
                                     child: IconButton(
                                         splashColor: Colors.transparent,
                                         highlightColor: Colors.transparent,
                                         alignment: AlignmentDirectional.center,
                                         iconSize: 17.sp,
                                         splashRadius: 26.sp,
                                         onPressed: () async{
                                           setState(() {
                                             AppCubit.get(context).ChangePhoto();
                                           });
                                         },
                                         padding: EdgeInsets.zero,
                                         icon: Padding(
                                           padding:  EdgeInsets.only(top: .0.sp,left: 3.sp),
                                           child: Image(fit: BoxFit.cover,color: Colors.white,
                                             alignment: AlignmentDirectional.center,
                                             height: 18.sp,
                                             image:  const AssetImage('Assets/images/paint.png'),
                                           ),
                                         )),
                                   ),
                                 ],
                               ),
                             ),
                           SizedBox(height: 2.h),
                         ],
                       ),
                     ),
                   ),
                 ),
                 /*
                         Container(
                           padding: EdgeInsets.zero,
                           //  height: 7.h,
                           width: double.infinity,
                           /*
                           decoration:  BoxDecoration(
                             color: Colors.grey[300],
                           ),

                            */

                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                               IconButton(
                                   splashColor: Colors.transparent,
                                   highlightColor: Colors.transparent,
                                   iconSize: 20.sp,
                                   splashRadius: 26.sp,
                                   onPressed: () async{
                                     final data = ClipboardData(text: widget.qoute);
                                     Clipboard.setData(data);
                                     Fluttertoast.showToast(msg: 'copied to clipboard',gravity: ToastGravity.CENTER);
                                     final file = await AudioCache().loadAsFile('mixin.wav');
                                     final bytes = await file.readAsBytes();
                                     AudioCache().playBytes(bytes);
                                   },
                                   padding: EdgeInsets.zero,
                                   icon: const Icon(
                                     MdiIcons.contentCopy,
                                     color: Colors.blue,
                                   )),
                               SizedBox(width: 6.w,),
                               IconButton(

                                   splashColor: Colors.transparent,
                                   highlightColor: Colors.transparent,
                                   iconSize: 20.sp,
                                   splashRadius: 26.sp,
                                   onPressed: ()
                                   async{
                                     final file = await AudioCache().loadAsFile('mixin.wav');
                                     final bytes = await file.readAsBytes();
                                     AudioCache().playBytes(bytes);
                                     ShareFilesAndScreenshotWidgets().shareScreenshot(
                                       previewContainer,
                                       1000,
                                       "Title",
                                       "Name.png",
                                       "image/png",
                                     );
                                   },
                                   padding: EdgeInsets.zero,
                                   icon: const Icon(
                                     MdiIcons.shareVariant,
                                     color: Colors.blue,
                                   )),
                               SizedBox(width: 6.w,),
                               IconButton(
                                   splashColor: Colors.transparent,
                                   highlightColor: Colors.transparent,
                                   alignment: AlignmentDirectional.center,
                                   iconSize: 20.sp,
                                   splashRadius: 26.sp,
                                   onPressed: () async{
                                     final file = await AudioCache().loadAsFile('mixin.wav');
                                     final bytes = await file.readAsBytes();
                                     AudioCache().playBytes(bytes);
                                     AppCubit.get(context).ChangeText();
                                   },
                                   padding: EdgeInsets.zero,
                                   icon: Padding(
                                     padding:  EdgeInsets.only(top: .8.sp),
                                     child: Image(fit: BoxFit.cover,color: Colors.blue,
                                       alignment: AlignmentDirectional.center,
                                       height: 18.sp,
                                       image: const AssetImage('assets/images/change.png'),
                                     ),
                                   )),
                               SizedBox(width: 6.w,),
                               /*
                               IconButton(
                                   iconSize: 20.sp,
                                   splashRadius: 26.sp,
                                   splashColor: Colors.grey,
                                   onPressed: ()
                                   {
                                     AppCubit.get(context).insertToDatabase(qoute: widget.qoute);
                                     Fluttertoast.showToast(msg: 'Added Successfully to favorites',gravity: ToastGravity.CENTER);
                                   },
                                   padding: EdgeInsets.zero,
                                   icon: Icon(
                                     Icons.favorite,
                                     color: Colors.blue,
                                   )),

                                */
                               LikeButton(
                                 padding: EdgeInsets.zero,
                                 size: 20.sp,
                                 circleColor:
                                 const CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
                                 bubblesColor: const BubblesColor(
                                   dotPrimaryColor: Colors.red,
                                   dotSecondaryColor: Colors.orange,
                                   dotLastColor: Colors.purple,
                                   dotThirdColor: Colors.pink,
                                 ),
                                 onTap: onLikeButtonTapped,
                                 isLiked: isLiked,
                                 likeBuilder: ( isLiked) {
                                   return Padding(
                                     padding:  EdgeInsets.only(top: .5.sp),
                                     child: Icon(
                                       AppCubit.get(context).function(widget.qoute)? Icons.favorite_outline:Icons.favorite,
                                       color: isLiked ? Colors.red : Colors.blue,
                                       size: 21.sp,
                                     ),
                                   );
                                 },
                               ),
                               SizedBox(width: 6.w,),
                               IconButton(
                                   splashColor: Colors.transparent,
                                   highlightColor: Colors.transparent,
                                   alignment: AlignmentDirectional.center,
                                   iconSize: 20.sp,
                                   splashRadius: 26.sp,
                                   onPressed: () async{
                                     final file = await AudioCache().loadAsFile('mixin.wav');
                                     final bytes = await file.readAsBytes();
                                     AudioCache().playBytes(bytes);
                                     AppCubit.get(context).ChangePhoto();
                                   },
                                   padding: EdgeInsets.zero,
                                   icon: Padding(
                                     padding:  EdgeInsets.only(top: .8.sp),
                                     child: Image(fit: BoxFit.cover,color: Colors.blue,
                                       alignment: AlignmentDirectional.center,
                                       height: 20.sp,
                                       image: const AssetImage('assets/images/paint.png'),
                                     ),
                                   )),
                             ],
                           ),
                         ),

                          */
               ],
             ),
             if(SizerUtil.deviceType==DeviceType.mobile)
               Padding(
                 padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
                 child: Container(
                   decoration: const BoxDecoration(shape: BoxShape.circle,backgroundBlendMode: BlendMode.softLight,color: Colors.white),
                   child: IconButton(onPressed: () async {
                     Navigator.pop(context);
                   }, icon: Icon(IconBroken.Arrow___Left,size:18.sp),
                     splashColor: Colors.transparent,color: Colors.white,
                     highlightColor: Colors.transparent,

                   ),
                 ),
               ),
             if(SizerUtil.deviceType==DeviceType.tablet)
               Padding(
                 padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
                 child: Container(
                   decoration: const BoxDecoration(shape: BoxShape.circle,backgroundBlendMode: BlendMode.softLight,color: Colors.white),
                   child: IconButton(onPressed: () async {
                     Navigator.pop(context);
                   }, icon: Icon(IconBroken.Arrow___Left,size:18.sp),
                     splashColor: Colors.transparent,color: Colors.white,
                     highlightColor: Colors.transparent,

                   ),
                   height: 10.h,
                   width: 10.w,
                 ),
               ),
           ],
         ),
       );
     },
     );
   }
 }


class pageViewForArabic extends StatefulWidget {
  TypeOfQoutesModel quote;



  pageViewForArabic( this.quote,{Key? key}) : super(key: key);

  @override
  _pageViewForArabicState createState() => _pageViewForArabicState();
}

class _pageViewForArabicState extends State<pageViewForArabic> {
  bool isLiked =false;
  Future<bool> onLikeButtonTapped(bool isLiked,) async{

    if(AppCubit.get(context).IsFavoriteArabicQuotesList.containsValue(widget.quote.Qoute))
    {
      AppCubit.get(context).deleteeDataForArabic(quote:widget.quote.Qoute).then((value)
      {
        AppCubit.get(context).getDataFromArabicQuotesStyleDatabase(AppCubit.get(context).databaseForArabicQuotes);
      });
      /*
                 .then((value)
             {

               Fluttertoast.showToast(msg: 'Deleted from favorites',gravity: ToastGravity.CENTER,backgroundColor: Colors.red);
             });

              */
    }
    else
    {
      AppCubit.get(context).insertToDatabaseForArabicQuotes(quote: widget.quote.Qoute).then((value){
        AppCubit.get(context).getDataFromArabicQuotesStyleDatabase(AppCubit.get(context).databaseForArabicQuotes);
      });
    }

    return !isLiked;
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppCubitStates>(listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {

        return Scaffold(
          body: Stack(
            alignment: AlignmentDirectional.topStart,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 100.h,
                      decoration:  BoxDecoration(image:  DecorationImage(fit: BoxFit.cover,image: AppCubit.get(context).Photoess[AppCubit.get(context).change])),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: ()
                        async {
                          setState(() {
                            AppCubit.get(context).ChangePhoto();
                          });
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(flex: 2,
                                child: Container(height: 30.h,)),
                            Expanded(
                              flex: 10,
                              child: Container(
                                padding: EdgeInsetsDirectional.zero,
                                height: 78.h,
                                child: Padding(
                                  padding:  EdgeInsets.only(right: 5.w,left: 5.w,top: 0.h ),
                                  child: Center(
                                    child: Text(
                                      widget.quote.Qoute!,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          height: AppCubit.get(context).GetDeviceTypeOfStyleScreen(),
                                          color: Colors.white,
                                          fontFamily:AppCubit.get(context).arabicTexts[AppCubit.get(context).changeArabicText],
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w600),
                                      overflow:TextOverflow.visible,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            if(SizerUtil.deviceType==DeviceType.mobile)
                              Expanded(
                                flex:1,
                                child: Container(
                                  padding: EdgeInsetsDirectional.zero,
                                  height: 8.h,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(shape: BoxShape.circle,backgroundBlendMode: BlendMode.softLight,color: Colors.white),
                                        child: IconButton(
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            iconSize: 20.sp,
                                            splashRadius: 26.sp,
                                            onPressed: () async{
                                              final data = ClipboardData(text: widget.quote.Qoute);
                                              Clipboard.setData(data);
                                              Fluttertoast.showToast(msg: 'Copy'.tr(),gravity: ToastGravity.CENTER,fontSize: 12.sp);
                                            },
                                            padding: EdgeInsets.zero,
                                            icon: const Icon(
                                              MdiIcons.contentCopy,
                                              color: Colors.white,
                                            )),
                                      ),
                                      SizedBox(width: 6.w,),
                                      Container(
                                        decoration: const BoxDecoration(shape: BoxShape.circle,backgroundBlendMode: BlendMode.softLight,color: Colors.white),
                                        child: IconButton(

                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            iconSize: 20.sp,
                                            splashRadius: 26.sp,
                                            onPressed: ()
                                            async {
                                              /*
                                                   if(AppCubit.get(context).music==true)
                                                   {
                                                     final file = await AudioCache().loadAsFile('mixin.wav');
                                                     final bytes = await file.readAsBytes();
                                                     AudioCache().playBytes(bytes);
                                                   }

                                                   ShareFilesAndScreenshotWidgets().shareScreenshot(
                                                     AppCubit.get(context).previewContainer,
                                                     1000,
                                                     "Title",
                                                     "Name.png",
                                                     "image/png",
                                                   );

                                                    */
                                              Clipboard.setData(const ClipboardData());
                                              Share.share('${widget.quote.Qoute}');

                                            },
                                            padding: EdgeInsets.zero,
                                            icon: const Icon(
                                              MdiIcons.shareVariant,
                                              color: Colors.white,
                                            )),
                                      ),
                                      SizedBox(width: 6.w,),
                                      Container(
                                        decoration: const BoxDecoration(shape: BoxShape.circle,backgroundBlendMode: BlendMode.softLight,color: Colors.white),
                                        child: IconButton(
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            alignment: AlignmentDirectional.center,
                                            iconSize: 20.sp,
                                            splashRadius: 26.sp,
                                            onPressed: () async{
                                              setState(() {
                                                AppCubit.get(context).ChangeTextForArabic();
                                              });
                                            },
                                            padding: EdgeInsets.zero,
                                            icon: Image(fit: BoxFit.cover,color: Colors.white,
                                              alignment: AlignmentDirectional.center,
                                              height: 17.5.sp,
                                              image: const AssetImage('Assets/images/type.png'),
                                            )),
                                      ),
                                      SizedBox(width: 6.w,),
                                      /*
                             IconButton(
                                   iconSize: 20.sp,
                                   splashRadius: 26.sp,
                                   splashColor: Colors.grey,
                                   onPressed: ()
                                   {
                                       AppCubit.get(context).insertToDatabase(qoute: widget.qoute);
                                       Fluttertoast.showToast(msg: 'Added Successfully to favorites',gravity: ToastGravity.CENTER);
                                   },
                                   padding: EdgeInsets.zero,
                                   icon: Icon(
                                       Icons.favorite,
                                       color: Colors.blue,
                                   )),

                                */
                                      Container(
                                        decoration: const BoxDecoration(shape: BoxShape.circle,backgroundBlendMode: BlendMode.softLight,color: Colors.white),
                                        child: IconButton(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          alignment: AlignmentDirectional.center,
                                          iconSize: 20.sp,
                                          padding: EdgeInsets.zero,
                                          splashRadius: 26.sp,
                                          onPressed: () {  },
                                          icon: LikeButton(
                                          padding: EdgeInsets.only(right:1.5.sp,top: 1.sp ),
                                            circleColor:
                                            const CircleColor(start: Colors.white, end: Colors.white),
                                            bubblesColor: const BubblesColor(
                                              dotPrimaryColor: Colors.white,
                                              dotSecondaryColor: Colors.white,
                                              dotLastColor: Colors.white,
                                              dotThirdColor: Colors.white,
                                            ),
                                            onTap: onLikeButtonTapped,
                                            isLiked: isLiked,
                                            likeBuilder: ( isLiked) {
                                              return Center(
                                                child: Icon(
                                                  AppCubit.get(context).functionForArabic(widget.quote.Qoute)? Icons.favorite_outline:Icons.favorite,
                                                  color: isLiked ? Colors.white : Colors.white,
                                                  size: 20.sp,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 6.w,),
                                      Container(
                                        decoration: const BoxDecoration(shape: BoxShape.circle,backgroundBlendMode: BlendMode.softLight,color: Colors.white),
                                        child: IconButton(
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            alignment: AlignmentDirectional.center,
                                            iconSize: 20.sp,
                                            splashRadius: 26.sp,
                                            onPressed: () async{
                                              setState(() {
                                                AppCubit.get(context).ChangePhoto();
                                              });
                                            },
                                            padding: EdgeInsets.zero,
                                            icon: Padding(
                                              padding:  EdgeInsets.only(top: .0.sp,left: 3.sp),
                                              child: Image(fit: BoxFit.cover,color: Colors.white,
                                                alignment: AlignmentDirectional.center,
                                                height: 20.5.sp,
                                                image:  const AssetImage('Assets/images/paint.png'),
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),

                                ),
                              ),
                            if(SizerUtil.deviceType==DeviceType.tablet)
                              Expanded(flex: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(shape: BoxShape.circle,backgroundBlendMode: BlendMode.softLight,color: Colors.white),
                                      child: IconButton(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          iconSize: 17.sp,
                                          splashRadius: 26.sp,
                                          onPressed: () async{
                                            final data = ClipboardData(text: widget.quote.Qoute);
                                            Clipboard.setData(data);
                                            Fluttertoast.showToast(msg: 'Copy'.tr(),gravity: ToastGravity.CENTER,fontSize:SizerUtil.deviceType==DeviceType.mobile?12.sp:6.sp);
                                          },
                                          padding: EdgeInsets.zero,
                                          icon: const Icon(
                                            MdiIcons.contentCopy,
                                            color: Colors.white,
                                          )),
                                      height: 10.h,
                                      width: 10.w,
                                    ),
                                    SizedBox(width: 6.w,),
                                    Container(
                                      height: 10.h,
                                      width: 10.w,
                                      decoration: const BoxDecoration(shape: BoxShape.circle,backgroundBlendMode: BlendMode.softLight,color: Colors.white),
                                      child: IconButton(

                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          iconSize: 17.sp,
                                          splashRadius: 26.sp,
                                          onPressed: ()
                                          async {
                                            /*
                                                   if(AppCubit.get(context).music==true)
                                                   {
                                                     final file = await AudioCache().loadAsFile('mixin.wav');
                                                     final bytes = await file.readAsBytes();
                                                     AudioCache().playBytes(bytes);
                                                   }
                                                   /*
                                                 ShareFilesAndScreenshotWidgets().shareScreenshot(
                                                   previewContainer,
                                                   1000,
                                                   "Title",
                                                   "Name.png",
                                                   "image/png",
                                                 );

                                                  */

                                                   Clipboard.setData(ClipboardData());
                                                   HapticFeedback.heavyImpact();
                                                   Share.share('${widget.qoute}');

                                                    */
                                            Clipboard.setData(const ClipboardData());
                                            Share.share('${widget.quote.Qoute}');
                                          },
                                          padding: EdgeInsets.zero,
                                          icon: const Icon(
                                            MdiIcons.shareVariant,
                                            color: Colors.white,
                                          )),
                                    ),
                                    SizedBox(width: 6.w,),
                                    Container(
                                      height: 10.h,
                                      width: 10.w,
                                      decoration: const BoxDecoration(shape: BoxShape.circle,backgroundBlendMode: BlendMode.softLight,color: Colors.white),
                                      child: IconButton(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          alignment: AlignmentDirectional.center,
                                          iconSize: 17.sp,
                                          splashRadius: 26.sp,
                                          onPressed: () async{
                                            setState(() {
                                              AppCubit.get(context).ChangeTextForArabic();
                                            });
                                          },
                                          padding: EdgeInsets.zero,
                                          icon: Image(fit: BoxFit.cover,color: Colors.white,
                                            alignment: AlignmentDirectional.center,
                                            height: 15.sp,
                                            image: const AssetImage('Assets/images/type.png'),
                                          )),
                                    ),
                                    SizedBox(width: 6.w,),
                                    /*
                             IconButton(
                                 iconSize: 20.sp,
                                 splashRadius: 26.sp,
                                 splashColor: Colors.grey,
                                 onPressed: ()
                                 {
                                     AppCubit.get(context).insertToDatabase(qoute: widget.qoute);
                                     Fluttertoast.showToast(msg: 'Added Successfully to favorites',gravity: ToastGravity.CENTER);
                                 },
                                 padding: EdgeInsets.zero,
                                 icon: Icon(
                                     Icons.favorite,
                                     color: Colors.blue,
                                 )),

                              */
                                    Container(
                                      height: 10.h,
                                      width: 10.w,
                                      decoration: const BoxDecoration(shape: BoxShape.circle,backgroundBlendMode: BlendMode.softLight,color: Colors.white),
                                      child: IconButton(
                                        onPressed: () {  },
                                        icon: LikeButton(
                                          padding: EdgeInsets.zero,
                                          size: 20.sp,
                                          circleColor:
                                          const CircleColor(start: Colors.white, end: Colors.white),
                                          bubblesColor: const BubblesColor(
                                            dotPrimaryColor: Colors.white,
                                            dotSecondaryColor: Colors.white,
                                            dotLastColor: Colors.white,
                                            dotThirdColor: Colors.white,
                                          ),
                                          onTap: onLikeButtonTapped,
                                          isLiked: isLiked,
                                          likeBuilder: ( isLiked) {
                                            return Padding(
                                              padding:  EdgeInsets.only(top: .5.sp),
                                              child: Icon(
                                                AppCubit.get(context).functionForArabic(widget.quote.Qoute)? Icons.favorite_outline:Icons.favorite,
                                                color: isLiked ? Colors.white : Colors.white,
                                                size: 18.sp,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 6.w,),
                                    Container(
                                      height: 10.h,
                                      width: 10.w,
                                      decoration: const BoxDecoration(shape: BoxShape.circle,backgroundBlendMode: BlendMode.softLight,color: Colors.white),
                                      child: IconButton(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          alignment: AlignmentDirectional.center,
                                          iconSize: 17.sp,
                                          splashRadius: 26.sp,
                                          onPressed: () async{
                                            setState(() {
                                              AppCubit.get(context).ChangePhoto();
                                            });
                                          },
                                          padding: EdgeInsets.zero,
                                          icon: Padding(
                                            padding:  EdgeInsets.only(top: .0.sp,left: 3.sp),
                                            child: Image(fit: BoxFit.cover,color: Colors.white,
                                              alignment: AlignmentDirectional.center,
                                              height: 18.sp,
                                              image:  const AssetImage('Assets/images/paint.png'),
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            SizedBox(height: 2.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                  /*
                         Container(
                           padding: EdgeInsets.zero,
                           //  height: 7.h,
                           width: double.infinity,
                           /*
                           decoration:  BoxDecoration(
                             color: Colors.grey[300],
                           ),

                            */

                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                               IconButton(
                                   splashColor: Colors.transparent,
                                   highlightColor: Colors.transparent,
                                   iconSize: 20.sp,
                                   splashRadius: 26.sp,
                                   onPressed: () async{
                                     final data = ClipboardData(text: widget.qoute);
                                     Clipboard.setData(data);
                                     Fluttertoast.showToast(msg: 'copied to clipboard',gravity: ToastGravity.CENTER);
                                     final file = await AudioCache().loadAsFile('mixin.wav');
                                     final bytes = await file.readAsBytes();
                                     AudioCache().playBytes(bytes);
                                   },
                                   padding: EdgeInsets.zero,
                                   icon: const Icon(
                                     MdiIcons.contentCopy,
                                     color: Colors.blue,
                                   )),
                               SizedBox(width: 6.w,),
                               IconButton(

                                   splashColor: Colors.transparent,
                                   highlightColor: Colors.transparent,
                                   iconSize: 20.sp,
                                   splashRadius: 26.sp,
                                   onPressed: ()
                                   async{
                                     final file = await AudioCache().loadAsFile('mixin.wav');
                                     final bytes = await file.readAsBytes();
                                     AudioCache().playBytes(bytes);
                                     ShareFilesAndScreenshotWidgets().shareScreenshot(
                                       previewContainer,
                                       1000,
                                       "Title",
                                       "Name.png",
                                       "image/png",
                                     );
                                   },
                                   padding: EdgeInsets.zero,
                                   icon: const Icon(
                                     MdiIcons.shareVariant,
                                     color: Colors.blue,
                                   )),
                               SizedBox(width: 6.w,),
                               IconButton(
                                   splashColor: Colors.transparent,
                                   highlightColor: Colors.transparent,
                                   alignment: AlignmentDirectional.center,
                                   iconSize: 20.sp,
                                   splashRadius: 26.sp,
                                   onPressed: () async{
                                     final file = await AudioCache().loadAsFile('mixin.wav');
                                     final bytes = await file.readAsBytes();
                                     AudioCache().playBytes(bytes);
                                     AppCubit.get(context).ChangeText();
                                   },
                                   padding: EdgeInsets.zero,
                                   icon: Padding(
                                     padding:  EdgeInsets.only(top: .8.sp),
                                     child: Image(fit: BoxFit.cover,color: Colors.blue,
                                       alignment: AlignmentDirectional.center,
                                       height: 18.sp,
                                       image: const AssetImage('assets/images/change.png'),
                                     ),
                                   )),
                               SizedBox(width: 6.w,),
                               /*
                               IconButton(
                                   iconSize: 20.sp,
                                   splashRadius: 26.sp,
                                   splashColor: Colors.grey,
                                   onPressed: ()
                                   {
                                     AppCubit.get(context).insertToDatabase(qoute: widget.qoute);
                                     Fluttertoast.showToast(msg: 'Added Successfully to favorites',gravity: ToastGravity.CENTER);
                                   },
                                   padding: EdgeInsets.zero,
                                   icon: Icon(
                                     Icons.favorite,
                                     color: Colors.blue,
                                   )),

                                */
                               LikeButton(
                                 padding: EdgeInsets.zero,
                                 size: 20.sp,
                                 circleColor:
                                 const CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
                                 bubblesColor: const BubblesColor(
                                   dotPrimaryColor: Colors.red,
                                   dotSecondaryColor: Colors.orange,
                                   dotLastColor: Colors.purple,
                                   dotThirdColor: Colors.pink,
                                 ),
                                 onTap: onLikeButtonTapped,
                                 isLiked: isLiked,
                                 likeBuilder: ( isLiked) {
                                   return Padding(
                                     padding:  EdgeInsets.only(top: .5.sp),
                                     child: Icon(
                                       AppCubit.get(context).function(widget.qoute)? Icons.favorite_outline:Icons.favorite,
                                       color: isLiked ? Colors.red : Colors.blue,
                                       size: 21.sp,
                                     ),
                                   );
                                 },
                               ),
                               SizedBox(width: 6.w,),
                               IconButton(
                                   splashColor: Colors.transparent,
                                   highlightColor: Colors.transparent,
                                   alignment: AlignmentDirectional.center,
                                   iconSize: 20.sp,
                                   splashRadius: 26.sp,
                                   onPressed: () async{
                                     final file = await AudioCache().loadAsFile('mixin.wav');
                                     final bytes = await file.readAsBytes();
                                     AudioCache().playBytes(bytes);
                                     AppCubit.get(context).ChangePhoto();
                                   },
                                   padding: EdgeInsets.zero,
                                   icon: Padding(
                                     padding:  EdgeInsets.only(top: .8.sp),
                                     child: Image(fit: BoxFit.cover,color: Colors.blue,
                                       alignment: AlignmentDirectional.center,
                                       height: 20.sp,
                                       image: const AssetImage('assets/images/paint.png'),
                                     ),
                                   )),
                             ],
                           ),
                         ),

                          */
                ],
              ),
              if(SizerUtil.deviceType==DeviceType.mobile)
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
                  child: Container(
                    decoration: const BoxDecoration(shape: BoxShape.circle,backgroundBlendMode: BlendMode.softLight,color: Colors.white),
                    child: IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(IconBroken.Arrow___Right,size:18.sp),
                      splashColor: Colors.transparent,color: Colors.white,
                      highlightColor: Colors.transparent,

                    ),
                  ),
                ),
              if(SizerUtil.deviceType==DeviceType.tablet)
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
                  child: Container(
                    decoration: const BoxDecoration(shape: BoxShape.circle,backgroundBlendMode: BlendMode.softLight,color: Colors.white),
                    child: IconButton(onPressed: () async {
                      Navigator.pop(context);
                    }, icon: Icon(IconBroken.Arrow___Right,size:18.sp),
                      splashColor: Colors.transparent,color: Colors.white,
                      highlightColor: Colors.transparent,

                    ),
                    height: 10.h,
                    width: 10.w,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}


