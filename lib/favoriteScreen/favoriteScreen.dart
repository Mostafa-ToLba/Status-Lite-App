import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scale_button/scale_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:statuses/AppCubit/appCubit.dart';
import 'package:statuses/AppCubit/appCubitStates.dart';
import 'package:statuses/OpenImageFromFav/openImageFromFav.dart';
import 'package:statuses/QouteStyle/QouteStyle.dart';
import 'package:statuses/QuoteStyleForFav/QuoteStyleForFav.dart';
import 'package:statuses/VideoOpenFromFavoriteScreen/videoOpenFromFavorite.dart';
import 'package:statuses/shared/componenet/component.dart';
import 'package:statuses/shared/styles/icon_broken.dart';
import 'package:http/http.dart' as http;

class FavoriteScreen extends StatefulWidget {
  FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
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
  AppCubit.get(context).getDataFromImageDatabasee(AppCubit.get(context).databaseForImages);
  AppCubit.get(context).getDataFromArabicImageDatabasee(AppCubit.get(context).databaseForArabicImages);
  AppCubit.get(context).getDataFromVideoDatabase(AppCubit.get(context).databaseForVideos);
  AppCubit.get(context).getDataFromArabicVideoDatabase(AppCubit.get(context).databaseForArabicVideos);
  AppCubit.get(context).getDataFromQuotesStyleDatabase(AppCubit.get(context).databaseForQuotes);
  AppCubit.get(context).getDataFromArabicQuotesStyleDatabase(AppCubit.get(context).databaseForArabicQuotes);
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    _bottomBannerAd.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppCubitStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              //       toolbarHeight: 7.6.h,
              //       leadingWidth: 14.2.w,
              leadingWidth: 14.5.w,
              toolbarHeight: 8.h,
              titleSpacing: 0,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: AppCubit.get(context).isDark==false?<Color>[HexColor('#34ba30'), Colors.teal]:<Color>[Colors.black, Colors.black]),
                ),
              ),
              leading: IconButton(
                padding: EdgeInsetsDirectional.zero,
                onPressed: () async {
                  Navigator.pop(context);
                },
                icon: Icon(
                  translator.isDirectionRTL(context)?IconBroken.Arrow___Right:IconBroken.Arrow___Left,
                  size: 18.sp,
                  color: Colors.white,
                ),
              ),
              title: SizerUtil.deviceType == DeviceType.mobile
                  ? Text('Favorites'.tr(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize:translator.isDirectionRTL(context)?18.sp :16.sp,
                          fontWeight: FontWeight.w600,
                        fontFamily: translator.isDirectionRTL(context)?'ElMessiri':'VarelaRound',))
                  : Text('Favorites'.tr(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        fontFamily: translator.isDirectionRTL(context)?'ElMessiri':'VarelaRound',)),
              bottom:  TabBar(
                labelColor: Colors.white,
                indicatorColor: Colors.white,
                labelStyle: TextStyle(fontFamily: 'Scada',fontSize: 11.sp,height: .7.sp),
                tabs: [
                  Tab(
                    //  text: 'tabBar1'.tr(),
                    icon: Icon(IconBroken.Image,size: 18.sp),height: SizerUtil.deviceType==DeviceType.mobile?10.h:15.h,child: Text('tabBar1'.tr(),style: TextStyle(fontSize: 14.sp,fontFamily: translator.isDirectionRTL(context)?'ElMessiri':'Scada',fontWeight: FontWeight.w600,height:SizerUtil.deviceType==DeviceType.mobile? .7.sp:.4.sp)),
                  ),
                  Tab(
                    //    text: 'tabBar2'.tr(),
                      child: Text('tabBar2'.tr(),style: TextStyle(fontSize: 14.sp,fontFamily: translator.isDirectionRTL(context)?'ElMessiri':'Scada',fontWeight: FontWeight.w600,height:SizerUtil.deviceType==DeviceType.mobile? .7.sp:.4.sp)),
                      icon: Icon(IconBroken.Video,size: 21.sp),height: SizerUtil.deviceType==DeviceType.mobile?10.h:15.h
                  ),
                  Tab(
                    //      text: 'tabBar3'.tr(),
                      child: Text('tabBar3'.tr(),style: TextStyle(fontSize: 14.sp,fontFamily: translator.isDirectionRTL(context)?'ElMessiri':'Scada',fontWeight: FontWeight.w600,height:SizerUtil.deviceType==DeviceType.mobile? .7.sp:.4.sp)),
                      icon: Icon(IconBroken.Edit,size: 21.sp),height: SizerUtil.deviceType==DeviceType.mobile?10.h:15.h
                  ),
                ],
              ),
            ),
            body: TabBarView(children: [
              /*
              if(translator.isDirectionRTL(context)==false)
              ConditionalBuilder(
                  condition: AppCubit.get(context).FavoriteImageList.isNotEmpty,
                  builder: (BuildContext context) => ListView.separated(
                      itemBuilder: (context, index) => BuilViewForPhotoes(
                          AppCubit.get(context).FavoriteImageList[index],
                          context),
                      separatorBuilder: (context, index) => Container(),
                      itemCount:
                          AppCubit.get(context).FavoriteImageList.length),
                  fallback: (BuildContext context) =>BuildNoFavoriteForPhotoes(context)),

               */
              if(translator.isDirectionRTL(context)==false)
                ConditionalBuilder(
                  condition: AppCubit.get(context).FavoriteImageList.isNotEmpty,
                  builder: (BuildContext context) => GridView.count(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    childAspectRatio: 1 / 1.8,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    padding: EdgeInsetsDirectional.only(
                        start: 7.sp, end: 7.sp, top: 7.sp, bottom: 7.sp),
                    physics: const ScrollPhysics(),
                    children: List.generate(AppCubit.get(context).FavoriteImageList.length, (index) => BuilViewForPhotoes(AppCubit.get(context).FavoriteImageList[index],context),),
                ),
            fallback: (BuildContext context) =>BuildNoFavoriteForPhotoes(context)),
              if(translator.isDirectionRTL(context))
                ConditionalBuilder(
                    condition: AppCubit.get(context).FavoriteArabicImageList.isNotEmpty,
                    builder: (BuildContext context) => GridView.count(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      childAspectRatio: 1 / 1.8,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      padding: EdgeInsetsDirectional.only(
                          start: 7.sp, end: 7.sp, top: 7.sp, bottom: 7.sp),
                      physics: const ScrollPhysics(),
                      children: List.generate(AppCubit.get(context).FavoriteArabicImageList.length, (index) => BuilViewForArabicPhotoes(AppCubit.get(context).FavoriteArabicImageList[index],context),),),
                    fallback:(BuildContext context) =>BuildNoFavoriteForPhotoes(context)),
                /*
              ConditionalBuilder(
                  condition: AppCubit.get(context).FavoriteArabicImageList.isNotEmpty,
                  builder: (BuildContext context) => ListView.separated(
                      itemBuilder: (context, index) => BuilViewForArabicPhotoes(
                          AppCubit.get(context).FavoriteArabicImageList[index],
                          context),
                      separatorBuilder: (context, index) => Container(),
                      itemCount: AppCubit.get(context).FavoriteArabicImageList.length),
                  fallback: (BuildContext context) =>
                      BuildNoFavoriteForPhotoes(context)),

                 */
              if(translator.isDirectionRTL(context)==false)
                ConditionalBuilder(
                    condition: AppCubit.get(context).FavoriteVideoList.isNotEmpty,
                    builder: (BuildContext context) => GridView.count(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      childAspectRatio: 1 / 1.8,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      padding: EdgeInsetsDirectional.only(
                          start: 7.sp, end: 7.sp, top: 7.sp, bottom: 7.sp),
                      physics: const ScrollPhysics(),
                      children: List.generate(AppCubit.get(context).FavoriteVideoList.length, (index) => BuilViewForVideos(AppCubit.get(context).FavoriteVideoList[index], context,index),),),
                    fallback:(BuildContext context) =>BuildNoFavoriteForPhotoes(context)),
                /*
              ConditionalBuilder(
                  condition: AppCubit.get(context).FavoriteVideoList.isNotEmpty,
                  builder: (BuildContext context) => ListView.separated(
                      itemBuilder: (context, index)=>BuilViewForVideos(AppCubit.get(context).FavoriteVideoList[index], context,index),
                      separatorBuilder: (context, index) => Container(),
                      itemCount: AppCubit.get(context).FavoriteVideoList.length),
                  fallback: (BuildContext context) =>
                      BuildNoFavoriteForVideos(context)),

                 */
              if(translator.isDirectionRTL(context))
                ConditionalBuilder(
                    condition: AppCubit.get(context).FavoriteArabicVideoList.isNotEmpty,
                    builder: (BuildContext context) => GridView.count(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      childAspectRatio: 1 / 1.8,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      padding: EdgeInsetsDirectional.only(
                          start: 7.sp, end: 7.sp, top: 7.sp, bottom: 7.sp),
                      physics: const ScrollPhysics(),
                      children: List.generate(AppCubit.get(context).FavoriteArabicVideoList.length, (index) => BuilViewForArabicVideos(AppCubit.get(context).FavoriteArabicVideoList[index], context,index),),),
                    fallback:(BuildContext context) =>BuildNoFavoriteForPhotoes(context)),
                /*
                ConditionalBuilder(
                    condition: AppCubit.get(context).FavoriteArabicVideoList.isNotEmpty,
                    builder: (BuildContext context) => ListView.separated(
                        itemBuilder: (context, index)=>BuilViewForArabicVideos(AppCubit.get(context).FavoriteArabicVideoList[index], context,index),
                        separatorBuilder: (context, index) => Container(),
                        itemCount: AppCubit.get(context).FavoriteArabicVideoList.length),
                    fallback: (BuildContext context) =>
                        BuildNoFavoriteForVideos(context)),

                 */
              if(translator.isDirectionRTL(context)==false)
              ConditionalBuilder(
                  condition:
                      AppCubit.get(context).FavoriteQuotesList.isNotEmpty,
                  builder: (BuildContext context) => ListView.separated(
                      itemBuilder: (context, index) => BuilViewForQoute(context,
                          AppCubit.get(context).FavoriteQuotesList[index],index),
                      separatorBuilder: (context, index) => Container(),
                      itemCount: AppCubit.get(context).FavoriteQuotesList.length),
                  fallback: (BuildContext context) =>
                      BuildNoFavoriteForQuotes(context)),
              if(translator.isDirectionRTL(context))
                ConditionalBuilder(
                    condition:
                    AppCubit.get(context).FavoriteArabicQuotesList.isNotEmpty,
                    builder: (BuildContext context) => ListView.separated(
                        itemBuilder: (context, index) => BuilViewForArabicQoute(context,
                            AppCubit.get(context).FavoriteArabicQuotesList[index],index),
                        separatorBuilder: (context, index) => Container(),
                        itemCount: AppCubit.get(context).FavoriteArabicQuotesList.length),
                    fallback: (BuildContext context) =>
                        BuildNoFavoriteForQuotes(context)),
            ]),
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

Widget BuilViewForPhotoes(Map<String, dynamic> favoriteImageList, context) =>ScaleButton(
  bound: .1,
  reverse: false,
  child: Padding(
    padding:  EdgeInsets.only(top: 1.sp,right: 3.sp,left: 3.sp,bottom: 8.sp),
    child: Column(
      children: [
        Expanded(
          flex: 3,
          child: InkWell(
            child: Container(
                height: 20.h,
                width: double.infinity,
                child: CachedNetworkImage(
                  //            height: 28.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  imageUrl: '${favoriteImageList['image']}',
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0.sp),
                          bottomRight: Radius.circular(0.sp),
                          topLeft: Radius.circular(8.sp),
                          topRight: Radius.circular(8.sp)),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.error),
                )),
            onTap: () {
              /*
              final imageProvider =
                  Image.network(favoriteImageList['image']).image;
              showImageViewer(context, imageProvider, onViewerDismissed: () {
                print("dismissed");
              });

               */
              NavigateTo(context, OpenImageFromFav(favoriteImageList['image']));
            },

          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.zero,
            height: 6.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppCubit.get(context).isDark==false?Colors.grey[300]:Colors.grey[900],
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 1),
                  blurRadius: 5,
                  color: Colors.black.withOpacity(0.3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      iconSize: 18.sp,
                      onPressed: () async {
                        final temp = await getTemporaryDirectory();
                        final path = '${temp.path}.jpg';
                        await Dio().download(favoriteImageList['image'], path);
                        await GallerySaver.saveImage(path);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.green,content: Text('Downloaded To Gallery',style: TextStyle(fontSize: 12.sp),)));
                      },
                      padding: EdgeInsets.only(top: 2.5.sp),
                      icon:  Icon(
                        Icons.download,
                        color:AppCubit.get(context).isDark?Colors.grey:Colors.green,
                      )),
                ),
                if (SizerUtil.deviceType == DeviceType.mobile)
                  SizedBox(
                    width: 0.w,
                  ),
                if (SizerUtil.deviceType == DeviceType.tablet)
                  SizedBox(
                    width: 0.w,
                  ),
                Expanded(
                  child: IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      iconSize: 15.sp,
                      onPressed: () async {
                        final urlImage =
                        favoriteImageList['image'].toString();
                        final url = Uri.parse(urlImage);
                        final response = await http.get(url);
                        final bytes = response.bodyBytes;
                        final temp = await getTemporaryDirectory();
                        final path = '${temp.path}/image.jpg';
                        File(path).writeAsBytesSync(bytes);
                        await Share.shareFiles([path]);
                      },
                      padding: EdgeInsets.zero,
                      icon:  Icon(
                        MdiIcons.shareVariant,
                        color: AppCubit.get(context).isDark?Colors.grey:Colors.green,
                      )),
                ),
                if (SizerUtil.deviceType == DeviceType.mobile)
                  SizedBox(
                    width: 0.w,
                  ),
                if (SizerUtil.deviceType == DeviceType.tablet)
                  SizedBox(
                    width: 0.w,
                  ),
                Expanded(
                  child: IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      iconSize: 15.sp,
                      onPressed: () async {

                        AppCubit.get(context).deleteData(id: favoriteImageList['id']);
                      },
                      padding: EdgeInsets.zero,
                      icon:  Icon(
                        Icons.delete,
                        color: AppCubit.get(context).isDark?Colors.grey:Colors.green,
                      )),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);
///ArabicPhotoes
Widget BuilViewForArabicPhotoes(Map<String, dynamic> favoriteImageList, context) =>ScaleButton(
  bound: .1,
  reverse: false,
  child: Padding(
    padding: EdgeInsets.only(top: 1.sp,right: 3.sp,left: 3.sp,bottom: 8.sp),
    child: Column(
      children: [
        Expanded(
          flex: 3,
          child: InkWell(
            child: Container(
                height: 20.h,
                width: double.infinity,
                child: CachedNetworkImage(
                  //            height: 28.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  imageUrl: '${favoriteImageList['image']}',
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0.sp),
                          bottomRight: Radius.circular(0.sp),
                          topLeft: Radius.circular(8.sp),
                          topRight: Radius.circular(8.sp)),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.error),
                )),
            onTap: () {
              /*
              final imageProvider =
                  Image.network(favoriteImageList['image']).image;
              showImageViewer(context, imageProvider, onViewerDismissed: () {
                print("dismissed");
              });

               */
              NavigateTo(context, OpenImageFromFav(favoriteImageList['image']));
            },

          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.zero,
            height: 6.h,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppCubit.get(context).isDark==false?Colors.grey[300]:Colors.grey[900],
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 1),
                  blurRadius: 5,
                  color: Colors.black.withOpacity(0.3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      iconSize: 18.sp,
                      splashRadius: 20.sp,
                      onPressed: () async {
                        final temp = await getTemporaryDirectory();
                        final path = '${temp.path}.jpg';
                        await Dio()
                            .download(favoriteImageList['image'], path);
                        await GallerySaver.saveImage(path);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.green,content: Text('تم التحميل بنجاح',style: TextStyle(fontSize: 12.sp),)));
                      },
                      padding: EdgeInsets.only(top: 2.5.sp),
                      icon:  Icon(
                        Icons.download,
                        color:AppCubit.get(context).isDark?Colors.grey:Colors.green,
                      )),
                ),
                if (SizerUtil.deviceType == DeviceType.mobile)
                  SizedBox(
                    width: 0.w,
                  ),
                if (SizerUtil.deviceType == DeviceType.tablet)
                  SizedBox(
                    width: 4.w,
                  ),
                Expanded(
                  child: IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      iconSize: 15.sp,
                      splashRadius: 15.sp,
                      onPressed: () async {
                        final urlImage =
                        favoriteImageList['image'].toString();
                        final url = Uri.parse(urlImage);
                        final response = await http.get(url);
                        final bytes = response.bodyBytes;
                        final temp = await getTemporaryDirectory();
                        final path = '${temp.path}/image.jpg';
                        File(path).writeAsBytesSync(bytes);
                        await Share.shareFiles([path]);
                      },
                      padding: EdgeInsets.zero,
                      icon:  Icon(
                        MdiIcons.shareVariant,
                        color: AppCubit.get(context).isDark?Colors.grey:Colors.green,
                      )),
                ),
                if (SizerUtil.deviceType == DeviceType.mobile)
                  SizedBox(
                    width:0.w,
                  ),
                if (SizerUtil.deviceType == DeviceType.tablet)
                  SizedBox(
                    width: 3.2.w,
                  ),
                Expanded(
                  child: IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      iconSize: 15.sp,
                      splashRadius:15.sp,
                      onPressed: () async {

                        AppCubit.get(context).deleteDataForArabicImages(id: favoriteImageList['id']);
                      },
                      padding: EdgeInsets.zero,
                      icon:  Icon(
                        Icons.delete,
                        color: AppCubit.get(context).isDark?Colors.grey:Colors.green,
                      )),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);

class BuilViewForVideos extends StatefulWidget {
  Map<String, dynamic> favoriteVideoList;

  int index;

  BuilViewForVideos(Map<String, dynamic> this.favoriteVideoList, context,  this.index,
      {Key? key})
      : super(key: key);

  @override
  _BuilViewForVideosState createState() => _BuilViewForVideosState();
}

class _BuilViewForVideosState extends State<BuilViewForVideos> {

 /*
  Future startDownload() async {
    final request =
        Request('GET', Uri.parse(widget.favoriteVideoList['video']));
    final response = await Client().send(request);
    final contentLength = response.contentLength;
    final file = await getFile('file.mp4');
    final bytes = <int>[];
    response.stream.listen(
      (newBytes) {
        bytes.addAll(newBytes);

        setState(() {
          AppCubit.get(context).progresss = bytes.length / contentLength!;
        });
      },
      onDone: () async {
        setState(() {
          AppCubit.get(context).progresss = 1;
          AppCubit.get(context).progresss = 0;
        });
        await file.writeAsBytes(bytes);
      },
      onError: print,
      cancelOnError: false,
    );
    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/myfile.video.mp4';
    await Dio()
        .download(widget.favoriteVideoList['video'], path)
        .then((value) async {
      await GallerySaver.saveVideo(path).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Downladed To Gallery')));
      });
    });
  }

  Future starttDownload() async {
    final url = '${widget.favoriteVideoList['video']}';

    final request = Request('GET', Uri.parse(url));
    final response = await Client().send(request);
    final contentLength = response.contentLength;

    final file = await getFile('file.mp4');
    final bytes = <int>[];
    response.stream.listen(
      (newBytes) {
        bytes.addAll(newBytes);
        setState(() {
          AppCubit.get(context).progresss = bytes.length / contentLength!;
        });
      },
      onDone: () async {
        setState(() {
          AppCubit.get(context).progresss = 1;
        });

        await file.writeAsBytes(bytes);
      },
      onError: print,
      cancelOnError: true,
    );
  }

  Future<File> getFile(String filename) async {
/*
    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/myfile.video.mp4';
    await Dio().download(widget.video, path).then((value)
    async {
      await GallerySaver.saveVideo(path).then((value)
      {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Downladed To Gallery')));
      });
    });
 */

    final dir = await getApplicationDocumentsDirectory();

    return File('${dir.path}/$filename');
  }

  Widget buildProgress() {
    if (AppCubit.get(context).progresss == 1) {
      return  Icon(
        Icons.done,
        color: Colors.green,
        size: 20.sp,
      );
    } else {
      return Text(
        '${(AppCubit.get(context).progresss * 100).toStringAsFixed(1)}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppCubit.get(context).isDark?Colors.white:Colors.black,
          fontSize: 10.sp,
        ),
      );
    }
  }

  Future startShare() async {
    final url = widget.favoriteVideoList['video'];
    final request = Request('GET', Uri.parse(url));
    final response = await Client().send(request);
    final contentLength = response.contentLength;

    final file = await getFile('file.mp4');
    final bytes = <int>[];
    response.stream.listen(
      (newBytes) {
        bytes.addAll(newBytes);

        setState(() {
          AppCubit.get(context).progresss = bytes.length / contentLength!;
        });
      },
      onDone: () async {
        setState(() {
          AppCubit.get(context).progresss = 1;
          AppCubit.get(context).progresss = 0;
        });

        await file.writeAsBytes(bytes);

        //     final url =Uri.parse(widget.video);
        //     final response = await http.get(url);
        //    final bytes = response.bodyBytes;
        final temp = await getTemporaryDirectory();
        final path = '${temp.path}/video.mp4';
        File(path).writeAsBytesSync(bytes);
        await Share.shareFiles([path]);
      },
      onError: print,
      cancelOnError: true,
    );
  }

  */

  @override
  Widget build(BuildContext context) {
    return ScaleButton(
      bound: .1,
      reverse: false,
      child: Padding(
        padding:EdgeInsets.only(top: 1.sp,right: 3.sp,left: 3.sp,bottom: 8.sp),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: InkWell(
                child: Container(
                    height: 20.h,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      width: double.infinity,
                      fit: BoxFit.cover,
                      imageUrl: '${widget.favoriteVideoList['imageVideo']}',
                      imageBuilder: (context, imageProvider) => Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(0.sp),
                                  bottomRight: Radius.circular(0.sp),
                                  topLeft: Radius.circular(8.sp),
                                  topRight: Radius.circular(8.sp)),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          Center(child: Image.asset('Assets/images/play-button.png',height: 35.sp,color:Colors.white)),
                        ],
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    )),
                onTap: () {
                  NavigateTo(
                      context,
                      VideoOpenFromFavoriteScreen(
                          widget.favoriteVideoList['video']));
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.zero,
                height: 6.h,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppCubit.get(context).isDark==false?Colors.grey[300]:Colors.grey[900],
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 1),
                      blurRadius: 5,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
          //           if (AppCubit.get(context).ss != 0)
                    if(AppCubit.get(context).circle!=0&&AppCubit.get(context).index==widget.index)
                      Padding(
                        padding:  EdgeInsets.only(top:SizerUtil.deviceType==DeviceType.mobile?4.sp:2.sp),
                        child: SizedBox(
                          width: 18.sp,
                          height: 18.sp,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              CircularProgressIndicator(
                                valueColor:
                                     AlwaysStoppedAnimation(AppCubit.get(context).isDark?Colors.black:Colors.green),
                                strokeWidth: 4.sp,
                                value: AppCubit.get(context).circle,
                                backgroundColor: AppCubit.get(context).isDark?Colors.grey[300]:Colors.white,
                              ),
                              Center(
                                child: AppCubit.get(context).circle != 100
                                    ? Text(
                                        AppCubit.get(context).text,
                                        style: TextStyle(fontSize: 7.sp,color: AppCubit.get(context).isDark?Colors.white:Colors.black),
                                      )
                                    : const Icon(Icons.done,
                                        size: 50, color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (AppCubit.get(context).progresss!= 0&&AppCubit.get(context).index==widget.index)
                      Padding(
                        padding:  EdgeInsets.only(top: SizerUtil.deviceType==DeviceType.mobile?4.sp:2.sp),
                        child: SizedBox(
                          width: 18.sp,
                          height: 18.sp,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              CircularProgressIndicator(
                                valueColor:
                                     AlwaysStoppedAnimation(AppCubit.get(context).isDark?Colors.black:Colors.green),
                                strokeWidth: 4.sp,
                                value: AppCubit.get(context).progresss,
                                backgroundColor: AppCubit.get(context).isDark?Colors.grey[300]:Colors.white,
                              ),
                              Center(child: AppCubit.get(context).buildProgressForGridView()),
                            ],
                          ),
                        ),
                      ),
                    Expanded(
                      child: IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          iconSize: 18.sp,
                          splashRadius: 20.sp,
                          onPressed:() {
                              /*
                            //        check=1;
                                    final temp = await getTemporaryDirectory();
                                    final path = '${temp.path}/video.mp4';
                                    await Dio().download(
                                      widget.favoriteVideoList['video'],
                                      path,
                                      onReceiveProgress: (received, total) {
                                        if (total != -1) {
                                          print((received / total * 100)
                                              .toStringAsFixed(0) +
                                              "%");
                                          print(received / total);
                                          setState(() {
                                            AppCubit.get(context).prograss =
                                            ((received / total * 100)
                                                .toStringAsFixed(0) +
                                                "%");
                                            AppCubit.get(context).ss =
                                                received / total;
                                          });
                                        }
                                      },
                                      deleteOnError: true,
                                    ).then((value) async {
                                      await GallerySaver.saveVideo(path)
                                          .then((value) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                                content:
                                                Text('Downladed To Gallery')));
                                        setState(() {
                                          AppCubit.get(context).ss = 0;
                                          AppCubit.get(context).prograss=0;
                                        });
                               //         check==0;
                                      });
                                    });


                               */
                            if(AppCubit.get(context).circle==0&&AppCubit.get(context).progresss == 0) {
                              AppCubit.get(context).Download(video: widget.favoriteVideoList['video'],Index: widget.index);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar( SnackBar(backgroundColor: Colors.green,content: Text('please wait previous download is not finished yet',style: TextStyle(fontSize: 12.sp),)));
                            }
                          },
                          padding: EdgeInsets.only(top: 2.5.sp),
                          icon:  Icon(
                            Icons.download,
                            color: AppCubit.get(context).isDark?Colors.grey:Colors.green,
                          )),
                    ),
                    if (SizerUtil.deviceType == DeviceType.mobile)
                      SizedBox(
                        width: 0.w,
                      ),
                    if (SizerUtil.deviceType == DeviceType.tablet)
                      SizedBox(
                        width: 0.w,
                      ),
                    Expanded(
                      child: IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          iconSize: 15.sp,
                          splashRadius: 17.5.sp,
                          onPressed:
                              AppCubit.get(context).progresss == 0 && AppCubit.get(context).circle == 0
                                  ? ()  {
                                      AppCubit.get(context).startShare(Index: widget.index,video: widget.favoriteVideoList['video']);
                                    }
                                  : null,
                          padding: EdgeInsets.zero,
                          icon:  Icon(
                            MdiIcons.shareVariant,
                            color: AppCubit.get(context).isDark?Colors.grey:Colors.green,
                          )),
                    ),
                    if (SizerUtil.deviceType == DeviceType.mobile)
                      SizedBox(
                        width: 0.w,
                      ),
                    if (SizerUtil.deviceType == DeviceType.tablet)
                      SizedBox(
                        width: 0.w,
                      ),
                    Expanded(
                      child: IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          iconSize: 15.sp,
                          splashRadius: 17.5.sp,
                          onPressed: () async {
                            AppCubit.get(context).deleteDataForVideos(
                                id: widget.favoriteVideoList['id']);
                          },
                          padding: EdgeInsets.zero,
                          icon:  Icon(
                            Icons.delete,
                            color: AppCubit.get(context).isDark?Colors.grey:Colors.green,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///arabicVideos
class BuilViewForArabicVideos extends StatefulWidget {
  Map<String, dynamic> favoriteVideoList;

  int index;

  BuilViewForArabicVideos(Map<String, dynamic> this.favoriteVideoList, context,  this.index,
      {Key? key})
      : super(key: key);

  @override
  _BuilViewForArabicVideosState createState() => _BuilViewForArabicVideosState();
}

class _BuilViewForArabicVideosState extends State<BuilViewForArabicVideos> {

  /*
  Future startDownload() async {
    final request =
        Request('GET', Uri.parse(widget.favoriteVideoList['video']));
    final response = await Client().send(request);
    final contentLength = response.contentLength;
    final file = await getFile('file.mp4');
    final bytes = <int>[];
    response.stream.listen(
      (newBytes) {
        bytes.addAll(newBytes);

        setState(() {
          AppCubit.get(context).progresss = bytes.length / contentLength!;
        });
      },
      onDone: () async {
        setState(() {
          AppCubit.get(context).progresss = 1;
          AppCubit.get(context).progresss = 0;
        });
        await file.writeAsBytes(bytes);
      },
      onError: print,
      cancelOnError: false,
    );
    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/myfile.video.mp4';
    await Dio()
        .download(widget.favoriteVideoList['video'], path)
        .then((value) async {
      await GallerySaver.saveVideo(path).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Downladed To Gallery')));
      });
    });
  }

  Future starttDownload() async {
    final url = '${widget.favoriteVideoList['video']}';

    final request = Request('GET', Uri.parse(url));
    final response = await Client().send(request);
    final contentLength = response.contentLength;

    final file = await getFile('file.mp4');
    final bytes = <int>[];
    response.stream.listen(
      (newBytes) {
        bytes.addAll(newBytes);
        setState(() {
          AppCubit.get(context).progresss = bytes.length / contentLength!;
        });
      },
      onDone: () async {
        setState(() {
          AppCubit.get(context).progresss = 1;
        });

        await file.writeAsBytes(bytes);
      },
      onError: print,
      cancelOnError: true,
    );
  }

  Future<File> getFile(String filename) async {
/*
    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/myfile.video.mp4';
    await Dio().download(widget.video, path).then((value)
    async {
      await GallerySaver.saveVideo(path).then((value)
      {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Downladed To Gallery')));
      });
    });
 */

    final dir = await getApplicationDocumentsDirectory();

    return File('${dir.path}/$filename');
  }

  Widget buildProgress() {
    if (AppCubit.get(context).progresss == 1) {
      return  Icon(
        Icons.done,
        color: Colors.green,
        size: 20.sp,
      );
    } else {
      return Text(
        '${(AppCubit.get(context).progresss * 100).toStringAsFixed(1)}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppCubit.get(context).isDark?Colors.white:Colors.black,
          fontSize: 10.sp,
        ),
      );
    }
  }

  Future startShare() async {
    final url = widget.favoriteVideoList['video'];
    final request = Request('GET', Uri.parse(url));
    final response = await Client().send(request);
    final contentLength = response.contentLength;

    final file = await getFile('file.mp4');
    final bytes = <int>[];
    response.stream.listen(
      (newBytes) {
        bytes.addAll(newBytes);

        setState(() {
          AppCubit.get(context).progresss = bytes.length / contentLength!;
        });
      },
      onDone: () async {
        setState(() {
          AppCubit.get(context).progresss = 1;
          AppCubit.get(context).progresss = 0;
        });

        await file.writeAsBytes(bytes);

        //     final url =Uri.parse(widget.video);
        //     final response = await http.get(url);
        //    final bytes = response.bodyBytes;
        final temp = await getTemporaryDirectory();
        final path = '${temp.path}/video.mp4';
        File(path).writeAsBytesSync(bytes);
        await Share.shareFiles([path]);
      },
      onError: print,
      cancelOnError: true,
    );
  }

  */

  @override
  Widget build(BuildContext context) {
    return ScaleButton(
      bound: .1,
      reverse: false,
      child: Padding(
        padding: EdgeInsets.only(top: 1.sp,right: 3.sp,left: 3.sp,bottom: 8.sp),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: InkWell(
                child: Container(
                    height: 20.h,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      //            height: 28.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      imageUrl: '${widget.favoriteVideoList['imageVideo']}',
                      imageBuilder: (context, imageProvider) => Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(0.sp),
                                  bottomRight: Radius.circular(0.sp),
                                  topLeft: Radius.circular(8.sp),
                                  topRight: Radius.circular(8.sp)),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.fill),
                            ),
                          ),
                          Center(child: Image.asset('Assets/images/play-button.png',height: 50.sp,color:Colors.white,fit: BoxFit.cover,)),
                        ],
                      ),
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                    )),
                onTap: () {
                  NavigateTo(
                      context,
                      VideoOpenFromFavoriteScreen(
                          widget.favoriteVideoList['video']));
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.zero,
                height: 6.h,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppCubit.get(context).isDark==false?Colors.grey[300]:Colors.grey[900],
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 1),
                      blurRadius: 5,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //           if (AppCubit.get(context).ss != 0)
                    if(AppCubit.get(context).circle!=0&&AppCubit.get(context).index==widget.index)
                      Padding(
                        padding:  EdgeInsets.only(top: 11.sp),
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              CircularProgressIndicator(
                                valueColor:
                                AlwaysStoppedAnimation(AppCubit.get(context).isDark?Colors.black:Colors.green),
                                strokeWidth: 10,
                                value: AppCubit.get(context).circle,
                                backgroundColor: AppCubit.get(context).isDark?Colors.grey[300]:Colors.white,
                              ),
                              Center(
                                child: AppCubit.get(context).circle != 100
                                    ? Text(
                                  AppCubit.get(context).text,
                                  style: TextStyle(fontSize: 6.sp,color: AppCubit.get(context).isDark?Colors.white:Colors.black),
                                )
                                    : const Icon(Icons.done,
                                    size: 50, color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (AppCubit.get(context).progresss!= 0&&AppCubit.get(context).index==widget.index)
                      Padding(
                        padding:  EdgeInsets.only(top: 11.sp),
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              CircularProgressIndicator(
                                valueColor:
                                AlwaysStoppedAnimation(AppCubit.get(context).isDark?Colors.black:Colors.green),
                                strokeWidth: 10,
                                value: AppCubit.get(context).progresss,
                                backgroundColor: AppCubit.get(context).isDark?Colors.grey[300]:Colors.white,
                              ),
                              Center(child: AppCubit.get(context).buildProgress()),
                            ],
                          ),
                        ),
                      ),
                    Expanded(
                      child: IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          iconSize: 18.sp,
                          splashRadius: 20.sp,
                          onPressed:() {
                            /*
                            //        check=1;
                                    final temp = await getTemporaryDirectory();
                                    final path = '${temp.path}/video.mp4';
                                    await Dio().download(
                                      widget.favoriteVideoList['video'],
                                      path,
                                      onReceiveProgress: (received, total) {
                                        if (total != -1) {
                                          print((received / total * 100)
                                              .toStringAsFixed(0) +
                                              "%");
                                          print(received / total);
                                          setState(() {
                                            AppCubit.get(context).prograss =
                                            ((received / total * 100)
                                                .toStringAsFixed(0) +
                                                "%");
                                            AppCubit.get(context).ss =
                                                received / total;
                                          });
                                        }
                                      },
                                      deleteOnError: true,
                                    ).then((value) async {
                                      await GallerySaver.saveVideo(path)
                                          .then((value) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                                content:
                                                Text('Downladed To Gallery')));
                                        setState(() {
                                          AppCubit.get(context).ss = 0;
                                          AppCubit.get(context).prograss=0;
                                        });
                               //         check==0;
                                      });
                                    });


                               */
                            if(AppCubit.get(context).circle==0&&AppCubit.get(context).progresss == 0) {
                              AppCubit.get(context).Download(video: widget.favoriteVideoList['video'],Index: widget.index);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar( SnackBar(backgroundColor:Colors.green,content: Text('من فضلك انتظر التحميل السابق لم ينته',style: TextStyle(fontSize: 12.sp),)));
                            }
                          },
                          padding: EdgeInsets.only(top: 2.5.sp),
                          icon:  Icon(
                            Icons.download,
                            color: AppCubit.get(context).isDark?Colors.grey:Colors.green,
                          )),
                    ),
                    if (SizerUtil.deviceType == DeviceType.mobile)
                      SizedBox(
                        width: 0.w,
                      ),
                    if (SizerUtil.deviceType == DeviceType.tablet)
                      SizedBox(
                        width: 4.w,
                      ),
                    Expanded(
                      child: IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          iconSize: 15.sp,
                          splashRadius: 17.sp,
                          onPressed:
                          AppCubit.get(context).progresss == 0 && AppCubit.get(context).circle == 0
                              ? ()  {
                            AppCubit.get(context).startShare(Index: widget.index,video: widget.favoriteVideoList['video']);
                          }
                              : null,
                          padding: EdgeInsets.zero,
                          icon:  Icon(
                            MdiIcons.shareVariant,
                            color: AppCubit.get(context).isDark?Colors.grey:Colors.green,
                          )),
                    ),
                    if (SizerUtil.deviceType == DeviceType.mobile)
                      SizedBox(
                        width: 0.w,
                      ),
                    if (SizerUtil.deviceType == DeviceType.tablet)
                      SizedBox(
                        width: 3.2.w,
                      ),
                    Expanded(
                      child: IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          iconSize: 15.sp,
                          splashRadius: 17.sp,
                          onPressed: () async {
                            AppCubit.get(context).deleteDataForArabicVideos(id: widget.favoriteVideoList['id']);
                          },
                          padding: EdgeInsets.zero,
                          icon:  Icon(
                            Icons.delete,
                            color: AppCubit.get(context).isDark?Colors.grey:Colors.green,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget BuilViewForQoute(context, Map<String, dynamic> favoriteQuotesList, int index) =>
    ScaleButton(
      bound: .1,
      reverse: false,
      child: Padding(
        padding: EdgeInsets.all(1.1.h),
        child: Container(
          decoration: BoxDecoration(
            color: AppCubit.get(context).isDark==false?Colors.white:Colors.black,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 1),
                blurRadius: 5,
                color: AppCubit.get(context).isDark==false?Colors.black.withOpacity(0.3):Colors.white,
              ),
            ],
            borderRadius: BorderRadius.circular(1.1.h),
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          QuoteStyleFromFav(favoriteQuotesList['quote']),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(4.h),
                  child: Text(
                    '${favoriteQuotesList['quote']}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        //     height: 1.2.sp,
                        height: AppCubit.get(context).GetDeviceType(),
                        fontSize: 15.sp,
                        fontFamily: translator.isDirectionRTL(context)?'ElMessiri':'VarelaRound',
                        color: AppCubit.get(context).isDark==false?Colors.grey[700]:Colors.white,
                        //     color: Colors.grey[700],
                        //       fontSize: 14.3.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.zero,
                height: 7.h,
                width: double.infinity,
                color: AppCubit.get(context).isDark==false?Colors.grey[300]:Colors.grey[900],
                alignment: Alignment.center,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          iconSize: 20.sp,
                          splashRadius: 26.sp,
                          onPressed: () async {
                            final data = ClipboardData(
                                text: '${favoriteQuotesList['quote']}');

                            Clipboard.setData(data);

                            Fluttertoast.showToast(
                                msg: 'Copy'.tr(),
                                gravity: ToastGravity.CENTER,fontSize:SizerUtil.deviceType == DeviceType.mobile?12.sp:5.sp);
                          },
                          padding: EdgeInsets.zero,
                          icon:  Icon(
                            MdiIcons.contentCopy,
                            color: AppCubit.get(context).isDark?Colors.grey:Colors.green,
                          )),
                      if (SizerUtil.deviceType == DeviceType.mobile)
                        SizedBox(
                          width: 1.w,
                        ),
                      if (SizerUtil.deviceType == DeviceType.tablet)
                        SizedBox(
                          width: 4.w,
                        ),
                      IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          iconSize: 20.sp,
                          splashRadius: 26.sp,
                          onPressed: () async {
                            Share.share('${favoriteQuotesList['quote']}');
                          },
                          padding: EdgeInsets.zero,
                          icon:  Icon(
                            MdiIcons.shareVariant,
                            color: AppCubit.get(context).isDark?Colors.grey:Colors.green,
                          )),
                      if (SizerUtil.deviceType == DeviceType.mobile)
                        SizedBox(
                          width: .7.w,
                        ),
                      if (SizerUtil.deviceType == DeviceType.tablet)
                        SizedBox(
                          width: 3.2.w,
                        ),
                      IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          iconSize: 20.sp,
                          splashRadius: 26.sp,
                          onPressed: () async {
                            AppCubit.get(context).deleteDataForQuotesWithEmit(
                                id: favoriteQuotesList['id']);
                          },
                          padding: EdgeInsets.zero,
                          icon:  Icon(
                            Icons.delete,
                            color: AppCubit.get(context).isDark?Colors.grey:Colors.green,
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

///Arabic
Widget BuilViewForArabicQoute(context, Map<String, dynamic> favoriteQuotesList, int index) =>
    ScaleButton(
      bound: .1,
      reverse: false,
      child: Padding(
        padding: EdgeInsets.all(1.1.h),
        child: Container(
          decoration: BoxDecoration(
            color: AppCubit.get(context).isDark==false?Colors.white:Colors.black,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 1),
                blurRadius: 5,
                color: AppCubit.get(context).isDark==false?Colors.black.withOpacity(0.3):Colors.white,
              ),
            ],
            borderRadius: BorderRadius.circular(1.1.h),
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          QuoteStyleFromFav(favoriteQuotesList['quote']),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(4.h),
                  child: Text(
                    '${favoriteQuotesList['quote']}',
                    textAlign: TextAlign.center,
                    style: TextStyle(

                      //     height: 1.2.sp,

                        height: AppCubit.get(context).GetDeviceType(),
                        fontSize: 15.sp,
                        fontFamily: translator.isDirectionRTL(context)?'ElMessiri':'VarelaRound',
                        color: AppCubit.get(context).isDark==false?Colors.grey[700]:Colors.white,
                        //     color: Colors.grey[700],
                        //       fontSize: 14.3.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.zero,
                height: 7.h,
                width: double.infinity,
                color: AppCubit.get(context).isDark==false?Colors.grey[300]:Colors.grey[900],
                alignment: Alignment.center,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          iconSize: 20.sp,
                          splashRadius: 26.sp,
                          onPressed: () async {
                            final data = ClipboardData(
                                text: '${favoriteQuotesList['quote']}');

                            Clipboard.setData(data);

                            Fluttertoast.showToast(
                                msg: 'Copy'.tr(),
                                gravity: ToastGravity.CENTER,fontSize:SizerUtil.deviceType==DeviceType.mobile? 12.sp:6.sp);
                          },
                          padding: EdgeInsets.zero,
                          icon:  Icon(
                            MdiIcons.contentCopy,
                            color: AppCubit.get(context).isDark?Colors.grey:Colors.green,
                          )),
                      if (SizerUtil.deviceType == DeviceType.mobile)
                        SizedBox(
                          width: 1.w,
                        ),
                      if (SizerUtil.deviceType == DeviceType.tablet)
                        SizedBox(
                          width: 4.w,
                        ),
                      IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          iconSize: 20.sp,
                          splashRadius: 26.sp,
                          onPressed: () async {
                            Share.share('${favoriteQuotesList['quote']}');
                          },
                          padding: EdgeInsets.zero,
                          icon:  Icon(
                            MdiIcons.shareVariant,
                            color: AppCubit.get(context).isDark?Colors.grey:Colors.green,
                          )),
                      if (SizerUtil.deviceType == DeviceType.mobile)
                        SizedBox(
                          width: .7.w,
                        ),
                      if (SizerUtil.deviceType == DeviceType.tablet)
                        SizedBox(
                          width: 3.2.w,
                        ),
                      IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          iconSize: 20.sp,
                          splashRadius: 26.sp,
                          onPressed: () async {
                            AppCubit.get(context).deleteDataForArabicQuotesWithEmit(
                                id: favoriteQuotesList['id']);
                          },
                          padding: EdgeInsets.zero,
                          icon:  Icon(
                            Icons.delete,
                            color: AppCubit.get(context).isDark?Colors.grey:Colors.green,
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

Widget BuildNoFavoriteForPhotoes(context) => Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.max,
    children: [
      Container(height: 20.h,child: Lottie.asset('Assets/animation/emptyFav.json',),),
      Text(
        'Wait'.tr(),
        style: TextStyle(
          color: AppCubit.get(context).isDark?Colors.white:Colors.black,
          fontSize: 37.sp,
          fontWeight: FontWeight.bold,
            height: translator.isDirectionRTL(context)? .7.sp:0,
            fontFamily: translator.isDirectionRTL(context)?'ElMessiri':'VarelaRound',
        ),
      ),
      Text(
        'noFavorites'.tr(),
        style: TextStyle(
            color: AppCubit.get(context).isDark?Colors.white:Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            fontFamily: translator.isDirectionRTL(context)?'ElMessiri':'VarelaRound',),
      ),
      //
      //  SizedBox(height: .5.h,),
      /*
          Text(
            'Please add your favorite photoes',
            style: TextStyle(
                color: Colors.grey,
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                fontFamily: 'MyriadPro'),
          ),
          Text(
            'to save them here',
            style: TextStyle(
                color: Colors.grey,
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                fontFamily: 'MyriadPro'),
          ),

           */
    ],
  ),
);
Widget BuildNoFavoriteForVideos(context) => Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.max,
    children: [
      Container(height: 20.h,child: Lottie.asset('Assets/animation/emptyFav.json',),),
      Text(
        'Wait'.tr(),
        style: TextStyle(
          color: AppCubit.get(context).isDark?Colors.white:Colors.black,
          fontSize: 37.sp,
          fontWeight: FontWeight.bold,
            fontFamily:  translator.isDirectionRTL(context)?'ElMessiri':'VarelaRound',
          height:translator.isDirectionRTL(context)? .7.sp:0,
        ),
      ),
      Text(
        'noFavorites'.tr(),
        style: TextStyle(
            color: AppCubit.get(context).isDark?Colors.white:Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            fontFamily:  translator.isDirectionRTL(context)?'ElMessiri':'VarelaRound',),
      ),
      //
      //  SizedBox(height: .5.h,),
      /*
          Text(
            'Please add your favorite photoes',
            style: TextStyle(
                color: Colors.grey,
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                fontFamily: 'MyriadPro'),
          ),
          Text(
            'to save them here',
            style: TextStyle(
                color: Colors.grey,
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                fontFamily: 'MyriadPro'),
          ),

           */
    ],
  ),
);
Widget BuildNoFavoriteForQuotes(context) => Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.max,
    children: [
      Container(height: 20.h,child: Lottie.asset('Assets/animation/emptyFav.json',),padding: EdgeInsets.zero,),
      Text(
        'Wait'.tr(),
        style: TextStyle(
          color: AppCubit.get(context).isDark?Colors.white:Colors.black,
          fontSize: 37.sp,
          fontWeight: FontWeight.bold,
            height: translator.isDirectionRTL(context)? .7.sp:0,
            fontFamily:  translator.isDirectionRTL(context)?'ElMessiri':'VarelaRound',
        ),
      ),
      Text(
          'noFavorites'.tr(),
        style: TextStyle(
            color: AppCubit.get(context).isDark?Colors.white:Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            fontFamily: translator.isDirectionRTL(context)?'ElMessiri':'VarelaRound',),
      ),
      //
      //  SizedBox(height: .5.h,),
      /*
          Text(
            'Please add your favorite photoes',
            style: TextStyle(
                color: Colors.grey,
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                fontFamily: 'MyriadPro'),
          ),
          Text(
            'to save them here',
            style: TextStyle(
                color: Colors.grey,
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                fontFamily: 'MyriadPro'),
          ),

           */
    ],
  ),
);
