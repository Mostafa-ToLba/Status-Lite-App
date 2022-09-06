
 import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:like_button/like_button.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:statuses/AppCubit/appCubit.dart';
import 'package:statuses/AppCubit/appCubitStates.dart';
import 'package:statuses/shared/styles/icon_broken.dart';

class QuoteStyleFromFav extends StatefulWidget {
  var favoriteQuotesList;

    QuoteStyleFromFav(this.favoriteQuotesList, {Key? key}) : super(key: key);


   @override
   _QuoteStyleFromFavState createState() => _QuoteStyleFromFavState();
 }

 class _QuoteStyleFromFavState extends State<QuoteStyleFromFav> {
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
   bool isLiked =false;
   Future<bool> onLikeButtonTapped(bool isLiked,) async{

     if(AppCubit.get(context).IsFavoriteQuotesList.containsValue(widget.favoriteQuotesList))
     {
       AppCubit.get(context).deleteeData(quote:widget.favoriteQuotesList).then((value)
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
       AppCubit.get(context).insertToDatabaseForQuotes(quote: widget.favoriteQuotesList).then((value){
         AppCubit.get(context).getDataFromQuotesStyleDatabase(AppCubit.get(context).databaseForQuotes);
       });
     }

     return !isLiked;
   }
   bool isLikedForArabic =false;
   Future<bool> onLikeButtonTappedForArabic(bool isLiked,) async{

     if(AppCubit.get(context).IsFavoriteArabicQuotesList.containsValue(widget.favoriteQuotesList))
     {
       AppCubit.get(context).deleteeDataForArabic(quote:widget.favoriteQuotesList).then((value)
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
       AppCubit.get(context).insertToDatabaseForArabicQuotes(quote: widget.favoriteQuotesList).then((value){
         AppCubit.get(context).getDataFromArabicQuotesStyleDatabase(AppCubit.get(context).databaseForArabicQuotes);
       });
     }

     return !isLiked;
   }
   @override
  void initState() {
     _createBottomBannerAd();
    AppCubit.get(context).change=0;
    AppCubit.get(context).changeArabicText=0;
    AppCubit.get(context).changeText=0;
    super.initState();
  }
   @override
   Widget build(BuildContext context) {
     return BlocConsumer<AppCubit,AppCubitStates>(listener: (BuildContext context, state) {  },
       builder: (BuildContext context, Object? state) {
         return AnnotatedRegion<SystemUiOverlayStyle>(
             value: AppCubit.get(context).isDark?SystemUiOverlayStyle(
               statusBarColor: Colors.transparent,
               statusBarIconBrightness: Brightness.light,
             ):SystemUiOverlayStyle(
               statusBarColor: Colors.transparent,
               statusBarIconBrightness: Brightness.dark,
             ),
           child: Scaffold(
             body: Stack(
               alignment: AlignmentDirectional.topStart,
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
                         //          height: 78.h,
                                   child: Padding(
                                     padding:  EdgeInsets.only(right: 4.w,left: 4.w,top: 0.h ),
                                     child: Center(
                                       child: Text(
                                         widget.favoriteQuotesList,
                                         textAlign: TextAlign.center,
                                         style: TextStyle(
                                             height: AppCubit.get(context).GetDeviceTypeOfStyleScreen(),
                                             color: Colors.white,
                                             fontFamily:translator.isDirectionRTL(context)?AppCubit.get(context).arabicTexts[AppCubit.get(context).changeArabicText]:AppCubit.get(context).Texts[AppCubit.get(context).changeText],
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
                                   flex: 1,
                                   child: Container(
                                     padding: EdgeInsetsDirectional.zero,
                              //     height: 8.h,
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
                                                 final data = ClipboardData(text: widget.favoriteQuotesList);
                                                 Clipboard.setData(data);
                                                 Fluttertoast.showToast(msg:'Copy'.tr(),gravity: ToastGravity.CENTER,fontSize: 12.sp);
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
                                                 Share.share('${widget.favoriteQuotesList}');

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
                                                   translator.isDirectionRTL(context)?
                                                   AppCubit.get(context).ChangeTextForArabic():AppCubit.get(context).ChangeText();
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
                                           child: IconButton(padding: EdgeInsetsDirectional.zero,
                                             onPressed: () {  },
                                             icon: LikeButton(
                                               padding: EdgeInsets.only(right:translator.isDirectionRTL(context)?2.sp:0.sp),
                                               size: 20.sp,
                                               circleColor:
                                               const CircleColor(start: Colors.white, end: Colors.white),
                                               bubblesColor: const BubblesColor(
                                                 dotPrimaryColor: Colors.white,
                                                 dotSecondaryColor: Colors.white,
                                                 dotLastColor: Colors.white,
                                                 dotThirdColor: Colors.white,
                                               ),
                                               onTap:translator.isDirectionRTL(context)?onLikeButtonTappedForArabic:onLikeButtonTapped,
                                               isLiked: isLiked,
                                               likeBuilder: ( isLiked) {
                                                 return Padding(
                                                   padding:  EdgeInsets.only(top: .5.sp),
                                                   child:translator.isDirectionRTL(context)? Icon(
                                                     AppCubit.get(context).functionForArabic(widget.favoriteQuotesList)? Icons.favorite_outline:Icons.favorite,
                                                     color: isLiked ? Colors.white : Colors.white,
                                                     size: 20.sp,
                                                   ):Icon(
                                                     AppCubit.get(context).function(widget.favoriteQuotesList)? Icons.favorite_outline:Icons.favorite,
                                                     color: isLiked ? Colors.white : Colors.white,
                                                     size: 21.sp,
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
                                               final data = ClipboardData(text: widget.favoriteQuotesList);
                                               Clipboard.setData(data);
                                               Fluttertoast.showToast(msg: 'Copy'.tr(),gravity: ToastGravity.CENTER,fontSize:SizerUtil.deviceType == DeviceType.mobile?12.sp:5.sp);
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
                                               Share.share('${widget.favoriteQuotesList}');
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
                                             onPressed: () {
                                               setState(() {
                                                 translator.isDirectionRTL(context)?
                                                 AppCubit.get(context).ChangeTextForArabic():AppCubit.get(context).ChangeText();
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
                                             padding: EdgeInsets.only(right: translator.isDirectionRTL(context)?1.sp:0,left:translator.isDirectionRTL(context)==false? 1.sp:0),
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
                                                 child: translator.isDirectionRTL(context)? Icon(
                                                   AppCubit.get(context).functionForArabic(widget.favoriteQuotesList)? Icons.favorite_outline:Icons.favorite,
                                                   color: isLiked ? Colors.white : Colors.white,
                                                   size: 18.sp,
                                                 ):Icon(
                                                   AppCubit.get(context).function(widget.favoriteQuotesList)? Icons.favorite_outline:Icons.favorite,
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
                       }, icon: Icon(translator.isDirectionRTL(context)?IconBroken.Arrow___Right:IconBroken.Arrow___Left,size:18.sp),
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
                       }, icon: Icon(translator.isDirectionRTL(context)?IconBroken.Arrow___Right:IconBroken.Arrow___Left,size:18.sp),
                         splashColor: Colors.transparent,color: Colors.white,
                         highlightColor: Colors.transparent,

                       ),
                       height: 10.h,
                       width: 10.w,
                     ),
                   ),
               ],
             ),
             bottomNavigationBar: _isBottomBannerAdLoaded
                 ? Container(
               color: AppCubit.get(context).isDark?Colors.black:Colors.white,
               height: _bottomBannerAd.size.height.toDouble(),
               width: _bottomBannerAd.size.width.toDouble(),
               child: AdWidget(ad: _bottomBannerAd),
             ) : null,
           ),
         );
       },
     );
   }
 }


