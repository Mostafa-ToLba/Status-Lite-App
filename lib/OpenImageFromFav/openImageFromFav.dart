
 import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';
import 'package:statuses/AppCubit/appCubit.dart';
import 'package:statuses/shared/styles/icon_broken.dart';

class OpenImageFromFav extends StatefulWidget {
  var favoriteImageList;

    OpenImageFromFav(this.favoriteImageList, {Key? key}) : super(key: key);

  @override
  State<OpenImageFromFav> createState() => _OpenImageFromFavState();
}

class _OpenImageFromFavState extends State<OpenImageFromFav> {
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
    _createBottomBannerAd();
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    _bottomBannerAd.dispose();
  }
   @override
   Widget build(BuildContext context) {
     return AnnotatedRegion<SystemUiOverlayStyle>(
       value: SystemUiOverlayStyle(
         statusBarColor: Colors.transparent,
         statusBarIconBrightness:  Brightness.light,
       ),
       child: Scaffold(
         body: Stack(
           children: [
             Container(
               height: double.infinity,
               width: double.infinity,
               decoration: BoxDecoration(
                 color:AppCubit.get(context).isDark==false?Colors.white:Colors.black,
                 shape: BoxShape.rectangle,
               ),
               child: CachedNetworkImage(imageUrl: '${widget.favoriteImageList}',imageBuilder:(context, imageProvider) => Container(clipBehavior: Clip.antiAliasWithSaveLayer,decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(0),),image:DecorationImage(
                   image: imageProvider, fit: BoxFit.cover) )),
                 placeholder: (context, url) => const Center(child: CupertinoActivityIndicator(color: Colors.black,radius: 30),),
               ),
             ),
             Padding(
               padding:  EdgeInsets.symmetric(horizontal: 2.w,vertical: 6.h),
               child: Container(
                 child: IconButton(
                   iconSize: 5.h,
                   onPressed: () async {
                   Navigator.pop(context);
                 }, icon: Icon(translator.isDirectionRTL(context)?IconBroken.Arrow___Right:IconBroken.Arrow___Left,size:23.sp),
                   splashColor: Colors.transparent,color: Colors.white,
                   highlightColor: Colors.transparent,

                 ),
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
   }
}
