import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:paginate_firestore/widgets/bottom_loader.dart';
import 'package:scale_button/scale_button.dart';
import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:statuses/AppCubit/appCubit.dart';
import 'package:statuses/AppCubit/appCubitStates.dart';
import 'package:statuses/Models/photoModel/photoModel.dart';
import 'package:statuses/Models/videoModel/videoModel.dart';
import 'package:statuses/QouteScreen/QouteScreen.dart';
import 'package:statuses/Qoutes/QoutesScreen.dart';
import 'package:statuses/VideoOpen/VideoOpen.dart';
import 'package:statuses/favoriteScreen/favoriteScreen.dart';

import 'package:statuses/photoOpen/photoOpen.dart';
import 'package:statuses/shared/componenet/component.dart';
import 'package:statuses/shared/local/cashe_helper.dart';
import 'package:statuses/shared/styles/icon_broken.dart';
import 'package:sizer/sizer.dart';
import 'package:switcher_button/switcher_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import '../Models/Qoute Model/qouteModel.dart';
import 'package:localize_and_translate/localize_and_translate.dart';


class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var scaffoldkey = GlobalKey<ScaffoldState>();
  late BannerAd _bottomBannerAd;
  bool _isBottomBannerAdLoaded = false;
  void _createBottomBannerAd() {
    _bottomBannerAd = BannerAd(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3940256099942544/2934735716',
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
  final Uri _urlll = Uri.parse(
      'mailto:Shakawapro@gmail.com?subject=${Uri.encodeFull('Statuses Contact')}&body=Send us a message we are happy to hear from you :)');
  void _launchUrlll() async {
    if (!await launchUrl(_urlll)) throw 'Could not launch $_urlll';
  }
  final Uri _url = Uri.parse(
      'https://sites.google.com/view/statuslite');

  void _launchUrlForPrivacy() async {
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }
  PaginateRefreshedChangeListener refreshChangeListener = PaginateRefreshedChangeListener();
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

  final Items = ['العربية', 'English'];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppCubitStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.green,
            statusBarIconBrightness: Brightness.light,
          ),
          child: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: (AppBar(
                leadingWidth: 14.5.w,
                toolbarHeight: 8.h,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: AppCubit.get(context).isDark == false
                            ? <Color>[HexColor('#34ba30'), Colors.teal]
                            : <Color>[Colors.black, Colors.black]),
                  ),
                ),
                shadowColor: Colors.grey,
                elevation: 0,
                leading: Padding(
                  padding: EdgeInsets.all(
                      translator.isDirectionRTL(context) ? 0 : 3.3.w),
                  child: IconButton(
                    iconSize: 5.h,
                    padding: EdgeInsets.zero,
                    icon: SvgPicture.asset(
                        'Assets/images/Icon ionic-ios-menu.svg',
                        color: Colors.white,
                        height:translator.isDirectionRTL(context)==false?SizerUtil.deviceType == DeviceType.tablet? 4.h:2.1.h:SizerUtil.deviceType == DeviceType.tablet? 3.h:2.2.h,
                        width: 1.w,
                        semanticsLabel: 'Label'),
                    onPressed: () {
                      scaffoldkey.currentState!.openDrawer();
                    },
                  ),
                ),
                titleSpacing: 0,
                title: Padding(
                  padding: translator.isDirectionRTL(context) ? EdgeInsets.only(left: 0.w, top: .5.h,)
                      : EdgeInsets.only(
                          left: 0.w,
                          top: 0.h,
                        ),
                  child: Text(
                    'AppName'.tr(),
                    style: TextStyle(
                        fontSize:
                            translator.isDirectionRTL(context) ? 24.sp : 23.sp,
                        color: Colors.white,
                        fontFamily: translator.isDirectionRTL(context)
                            ? 'ElMessiri'
                            : 'VarelaRound',
                        //    height: .8.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: translator.isDirectionRTL(context) ? 0 : 0.w,
                    ),
                    child: InkWell(
                      child: Image.asset(
                        'Assets/images/night-mode.png',
                        height: 1.h,
                        width: 5.5.w,
                        color: Colors.white,
                      ),
                      onTap: () {
                        AppCubit.get(context).MakeItDark();
                        if (AppCubit.get(context).isDark)
                          SystemChrome.setSystemUIOverlayStyle(
                              SystemUiOverlayStyle(
                            systemNavigationBarColor: Colors.black,
                            systemNavigationBarDividerColor: Colors.black,
                            systemNavigationBarIconBrightness: Brightness.light,
                          ));
                        else
                          SystemChrome.setSystemUIOverlayStyle(
                              SystemUiOverlayStyle(
                            systemNavigationBarColor: Colors.white,
                            systemNavigationBarDividerColor: Colors.white,
                            systemNavigationBarIconBrightness: Brightness.dark,
                          ));
                      },
                    ),
                  ),
                  if (SizerUtil.deviceType == DeviceType.mobile)
                    SizedBox(
                      width: translator.isDirectionRTL(context)? .6.w:1.w,
                    ),
                  if (SizerUtil.deviceType == DeviceType.tablet)
                    SizedBox(
                      width: 2.5.w,
                    ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: translator.isDirectionRTL(context) ? 1.w : 1.w,
                        left: translator.isDirectionRTL(context) ? 2.w : 0),
                    child: IconButton(
                      iconSize: 5.h,
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                      onPressed: () {
                        NavigateTo(context, FavoriteScreen());
                      },
                    ),
                  ),
                  if (SizerUtil.deviceType == DeviceType.tablet)
                    SizedBox(
                      width: 1.w,
                    ),
                ],
                backgroundColor: Colors.green,
                bottom: TabBar(
                  labelColor: Colors.white,
                  indicatorColor: Colors.white,
                  labelStyle: TextStyle(
                      fontFamily: 'Scada', fontSize: 11.sp, height: .7.sp),
                  tabs: [
                    Tab(
                      //  text: 'tabBar1'.tr(),
                      icon: Icon(IconBroken.Image, size: 18.sp),
                      height: SizerUtil.deviceType == DeviceType.mobile
                          ? 10.h
                          : 15.h,
                      child: Text('tabBar1'.tr(),
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: translator.isDirectionRTL(context)
                                  ? 'ElMessiri'
                                  : 'Scada',
                              fontWeight: FontWeight.w600,
                              height: SizerUtil.deviceType == DeviceType.mobile
                                  ? .7.sp
                                  : .4.sp)),
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
              )),
              drawer: Drawer(
                width: 78.w,
                child: Container(
                  height: 100.h,
                  //     color: Colors.white,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: AppCubit.get(context).isDark == false
                        ? [HexColor('#34ba30'), Colors.teal]
                        : [HexColor('#344524'), Colors.black],
                  )),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (SizerUtil.deviceType == DeviceType.mobile)
                          SizedBox(
                            height: 8.h,
                          ),
                        if (SizerUtil.deviceType == DeviceType.tablet)
                          SizedBox(
                            height: 1.h,
                          ),
                        Center(
                          child: Container(
                            height: 25.h,
                            child: Image.asset('Assets/images/logoResized.png'),
                          ),
                        ),
                        SizedBox(
                          height: SizerUtil.deviceType == DeviceType.mobile
                              ? 3.h
                              : 3.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 2.h, right: 1.5.h),
                          child: Row(
                            children: [
                              Icon(
                                  translator.isDirectionRTL(context)
                                      ? Icons.brightness_2
                                      : Icons.brightness_4,
                                  color: Colors.white,
                                  size: 25.sp),
                               SizedBox(
                                width: 8.sp,
                              ),
                              Text(
                                'DarkModeButton'.tr(),
                                style: TextStyle(
                                    fontFamily:
                                        translator.isDirectionRTL(context)
                                            ? 'ElMessiri'
                                            : 'Scada',
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              const Spacer(),
                              SwitcherButton(
                                size: 37.sp,
                                onColor: AppCubit.get(context).isDark == false
                                    ? Colors.green
                                    : Colors.white,
                                offColor: AppCubit.get(context).isDark == false
                                    ? Colors.white
                                    : Colors.black,
                                value: AppCubit.get(context).isDark,
                                onChange: (value) {
                                  AppCubit.get(context).MakeItDark();
                                  if (AppCubit.get(context).isDark)
                                    SystemChrome.setSystemUIOverlayStyle(
                                        SystemUiOverlayStyle(
                                      systemNavigationBarColor: Colors.black,
                                      systemNavigationBarDividerColor:
                                          Colors.black,
                                      systemNavigationBarIconBrightness:
                                          Brightness.light,
                                    ));
                                  else
                                    SystemChrome.setSystemUIOverlayStyle(
                                        SystemUiOverlayStyle(
                                      systemNavigationBarColor: Colors.white,
                                      systemNavigationBarDividerColor:
                                          Colors.white,
                                      systemNavigationBarIconBrightness:
                                          Brightness.dark,
                                    ));
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height:SizerUtil.deviceType == DeviceType.mobile? 2.2.h:1.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 2.h, right: 1.5.h),
                          child: Row(
                            children: [
                              Icon(Icons.language,
                                  color: Colors.white, size: 25.sp),
                               SizedBox(
                                width: 8.sp,
                              ),
                              Text(
                                'Language'.tr(),
                                style: TextStyle(
                                    fontFamily:
                                        translator.isDirectionRTL(context)
                                            ? 'ElMessiri'
                                            : 'Scada',
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              const Spacer(),
                              DropdownButton<String>(
                                style: TextStyle(
                                    fontFamily:
                                        translator.isDirectionRTL(context)
                                            ? 'ElMessiri'
                                            : 'Scada',
                                    fontSize: 15.sp),
                                borderRadius: BorderRadius.circular(15),
                                items: Items.map(BuildMenuItem).toList(),
                                onChanged: (value) {
                                  ///english
                                  if (value == 'English' &&
                                      translator.isDirectionRTL(context) ==
                                          true) {
                                    AppCubit.get(context).value = value;
                                    CasheHelper.SaveData(
                                            key: 'language', value: value)!
                                        .then((value) {
                                      translator
                                          .setNewLanguage(context,
                                              newLanguage: 'en',
                                              restart: true,
                                              remember: true)
                                          .then((value) {
                                        setState(() {});
                                      });
                                    });
                                  }
                                  if (value == 'English' &&
                                      translator.isDirectionRTL(context) ==
                                          false) {
                                    AppCubit.get(context).value = value;
                                    CasheHelper.SaveData(
                                            key: 'language', value: value)!
                                        .then((value) {
                                      setState(() {});
                                    });
                                  }

                                  ///Arabic
                                  if (value == 'العربية' &&
                                      translator.isDirectionRTL(context) ==
                                          false) {
                                    AppCubit.get(context).value = value;
                                    CasheHelper.SaveData(
                                            key: 'language', value: value)!
                                        .then((value) {
                                      translator
                                          .setNewLanguage(context,
                                              newLanguage: 'ar',
                                              restart: true,
                                              remember: true)
                                          .then((value) {
                                        setState(() {});
                                      });
                                    });
                                  }
                                  if (value == 'العربية' &&
                                      translator.isDirectionRTL(context) ==
                                          true) {
                                    AppCubit.get(context).value = value;
                                    CasheHelper.SaveData(
                                            key: 'language', value: value)!
                                        .then((value) {
                                      setState(() {});
                                    });
                                  }
                                },
                                dropdownColor: AppCubit.get(context).isDark
                                    ? HexColor('#344524')
                                    : Colors.green,
                                value: translator.isDirectionRTL(context)
                                    ? 'العربية'
                                    : 'English',
                                iconEnabledColor: Colors.white,
                                itemHeight: SizerUtil.deviceType == DeviceType.tablet ? 8.h : null,
                                onTap: () {
                                  print('${AppCubit.get(context).value}');
                                },
                              ),
                            ],
                          ),
                        ),
                        /*
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            onTap: () async{
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FavoriteScreen(),
                                ),
                              );
                              if(AppCubit.get(context).music==true)
                              {
                                final file = await AudioCache().loadAsFile('mixin.wav');
                                final bytes = await file.readAsBytes();
                                AudioCache().playBytes(bytes);
                              }
                            },
                            child: Row(
                              children: [
                                Icon(
                                  IconBroken.Heart,
                                  size: 25.sp,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Liked Quotes',
                                  style: TextStyle(
                                      fontFamily: 'Forum',
                                      fontSize: 17.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            )),
                      ),
                    ),

                     */
                        SizedBox(
                          height:SizerUtil.deviceType == DeviceType.mobile? 2.2.h:1.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 2.h, right: 1.5.h),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                                onTap: () {},
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 25.sp,
                                      color: Colors.white,
                                    ),
                                     SizedBox(
                                      width: 8.sp,
                                    ),
                                    Text(
                                      'RateUsButton'.tr(),
                                      style: TextStyle(
                                          fontFamily:
                                              translator.isDirectionRTL(context)
                                                  ? 'ElMessiri'
                                                  : 'Scada',
                                          fontSize: 16.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                )),
                          ),
                        ),
                        SizedBox(
                          height:SizerUtil.deviceType == DeviceType.mobile? 2.2.h:1.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 2.h, right: 1.5.h),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                                onTap: () async
                                {
                                  _launchUrlll();
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.call,
                                      size: 25.sp,
                                      color: Colors.white,
                                    ),
                                     SizedBox(
                                      width: 8.sp,
                                    ),
                                    Text(
                                      'ContactUsButton'.tr(),
                                      style: TextStyle(
                                          fontFamily:
                                              translator.isDirectionRTL(context)
                                                  ? 'ElMessiri'
                                                  : 'Scada',
                                          fontSize: 16.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                )),
                          ),
                        ),
                        SizedBox(
                          height:SizerUtil.deviceType == DeviceType.mobile? 2.2.h:1.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 2.h, right: 1.5.h),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                                onTap: () async {},
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.share,
                                      size: 25.sp,
                                      color: Colors.white,
                                    ),
                                     SizedBox(
                                      width: 8.sp,
                                    ),
                                    Text(
                                      'ShareAppButton'.tr(),
                                      style: TextStyle(
                                          fontFamily:
                                              translator.isDirectionRTL(context)
                                                  ? 'ElMessiri'
                                                  : 'Scada',
                                          fontSize: 16.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                )),
                          ),
                        ),
                        SizedBox(
                          height:SizerUtil.deviceType == DeviceType.mobile? 5.h:3.h,
                        ),
                        Container(
                          height: .1.h,
                          color: Colors.white38,
                        ),
                        if (translator.isDirectionRTL(context) == false)
                          SizedBox(
                            height: 2.5.h,
                          ),
                        if (translator.isDirectionRTL(context))
                          SizedBox(
                            height: 1.h,
                          ),
                        Padding(
                          padding: EdgeInsets.only(left: 1.3.h, right: 1.3.h),
                          child: Text(
                            'ApplicationInformation'.tr(),
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.white70,
                              fontFamily: translator.isDirectionRTL(context)
                                  ? 'ElMessiri'
                                  : 'Scada',
                            ),
                          ),
                        ),
                        if (translator.isDirectionRTL(context))
                          SizedBox(
                            height: 1.h,
                          ),
                        if (translator.isDirectionRTL(context) == false)
                          SizedBox(
                            height: 2.h,
                          ),
                        Padding(
                          padding: EdgeInsets.only(left: 2.5.h, right: 1.5.h),
                          child: Material(
                            color: Colors.transparent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'AppVersion'.tr(),
                                  style: TextStyle(
                                      fontFamily:
                                          translator.isDirectionRTL(context)
                                              ? 'ElMessiri'
                                              : 'Scada',
                                      fontSize: 15.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                Padding(
                                  padding: translator.isDirectionRTL(context)
                                      ? EdgeInsets.only()
                                      : EdgeInsets.all(.8.h),
                                  child: Text(
                                    'VerisonNumber'.tr(),
                                    style: TextStyle(
                                        fontFamily:
                                            translator.isDirectionRTL(context)
                                                ? 'ElMessiri'
                                                : 'Scada',
                                        fontSize:
                                            translator.isDirectionRTL(context)
                                                ? 13.sp
                                                : 10.sp,
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                if (translator.isDirectionRTL(context) == false)
                                  SizedBox(
                                    height: 1.5.h,
                                  ),
                                if (translator.isDirectionRTL(context))
                                  SizedBox(
                                    height: .5.h,
                                  ),
                                InkWell(
                                    onTap: () async
                                    {
                                      _launchUrlForPrivacy();
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'PrivacyPolicy'.tr(),
                                          style: TextStyle(
                                              fontFamily: translator
                                                      .isDirectionRTL(context)
                                                  ? 'ElMessiri'
                                                  : 'Scada',
                                              fontSize: 15.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Padding(
                                          padding:
                                              translator.isDirectionRTL(context)
                                                  ? EdgeInsets.only()
                                                  : EdgeInsets.all(.6.h),
                                          child: Text(
                                            'clickPrivacyPolicy'.tr(),
                                            style: TextStyle(
                                                fontFamily: translator
                                                        .isDirectionRTL(context)
                                                    ? 'ElMessiri'
                                                    : 'Scada',
                                                fontSize: 9.sp,
                                                color: Colors.white60,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              /*
              Drawer(
                child: Container(
                  //     color: Colors.white,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          HexColor('#34ba30'),
                          Colors.teal],)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 8.h,
                      ),
                      Container(
                          height: 25.h,
                          width: 25.h,
                          child: Image.asset('Assets/images/logo el 7alat h.png')),
                      SizedBox(
                        height: 3.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                              onTap: () {
                                print('tabed');
                              },
                              child: Row(
                                children: [
                                  const Icon(
                                    IconBroken.Heart,
                                    size: 35,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Favorite',
                                    style: TextStyle(
                                        fontFamily: 'MyriadPro',
                                        fontSize: 18.sp,
                                        color: Colors.white,fontWeight: FontWeight.w500
                                    ),
                                  )
                                ],
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                              onTap: () {},
                              child: Row(
                                children: [
                                  const Icon(
                                    MdiIcons.shareVariantOutline,
                                    size: 35,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Share',
                                    style: TextStyle(
                                        fontFamily: 'MyriadPro',
                                        fontSize: 18.sp,
                                        color: Colors.white,fontWeight: FontWeight.w500
                                    ),
                                  )
                                ],
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      /*
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Notification,
                              size: 35,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Notices',
                              style: TextStyle(
                                  fontFamily: 'PoiretOne',
                                  fontSize: 19.sp,
                                  color: Colors.white,fontWeight: FontWeight.w800
                              ),
                            )
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                   */
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                              onTap: () {},
                              child: Row(
                                children: [
                                  const Icon(
                                    IconBroken.Call,
                                    size: 35,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Call Us',
                                    style: TextStyle(
                                        fontFamily: 'MyriadPro',
                                        fontSize: 18.sp,
                                        color: Colors.white,fontWeight: FontWeight.w500
                                    ),
                                  )
                                ],
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                              onTap: () {},
                              child: Row(
                                children: [
                                  const Icon(
                                    IconBroken.Profile,
                                    size: 35,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'About Us',
                                    style: TextStyle(
                                        fontFamily: 'MyriadPro',
                                        fontSize: 18.sp,
                                        color: Colors.white,fontWeight: FontWeight.w500
                                    ),
                                  )
                                ],
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                              onTap: () {},
                              child: Row(
                                children: [
                                  const Icon(
                                    IconBroken.Shield_Done,
                                    size: 35,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Privacy & Security ',
                                    style: TextStyle(
                                        fontFamily: 'MyriadPro',
                                        fontSize: 18.sp,
                                        color: Colors.white,fontWeight: FontWeight.w500
                                    ),
                                  )
                                ],
                              )),
                        ),
                      ),

                    ],
                  ),
                ),
              ),

               */
              key: scaffoldkey,
              body: TabBarView(children: [
                /*
                if(translator.isDirectionRTL(context)==false)
                StreamBuilder<QuerySnapshot>(
                  stream: AppCubit.get(context).GetPhotoes(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                     AppCubit.get(context).photoList = [];
                      for (var doc in snapshot.data!.docs) {
                        AppCubit.get(context).photoList.add(PhotoModel(image: doc['image']));
                      }
                      return ConditionalBuilder(
                        condition: AppCubit.get(context).photoList.length > 0,
                        builder: (BuildContext context) => GridView.count(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          crossAxisCount: 3,
                          shrinkWrap: true,
                          childAspectRatio: 1 / 1.8,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          padding: EdgeInsetsDirectional.only(
                              start: 7.sp, end: 7.sp, top: 7.sp, bottom: 7.sp),
                          physics: const ScrollPhysics(),
                          children: List.generate(AppCubit.get(context).photoList.length, (index) => Builview(context, AppCubit.get(context).photoList[index],index)),
                        ),
                        fallback: (BuildContext context) => const Center(
                            child: const CircularProgressIndicator()),
                      );
                    }
                  },
                ),
                if(translator.isDirectionRTL(context)==true)
                  StreamBuilder<QuerySnapshot>(
                    stream: AppCubit.get(context).GetArabicPhotes(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        AppCubit.get(context).ArapicPhotoList = [];
                        for (var doc in snapshot.data!.docs) {
                          AppCubit.get(context).ArapicPhotoList.add(PhotoModel(image: doc['image']));
                        }
                        return ConditionalBuilder(
                          condition: AppCubit.get(context).ArapicPhotoList.length > 0,
                          builder: (BuildContext context) => GridView.count(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            crossAxisCount: 3,
                            shrinkWrap: true,
                            childAspectRatio: 1 / 1.8,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            padding: EdgeInsetsDirectional.only(
                                start: 7.sp, end: 7.sp, top: 7.sp, bottom: 7.sp),
                            physics: const ScrollPhysics(),
                            children: List.generate(AppCubit.get(context).ArapicPhotoList.length, (index) => buildViewForArabicPhotes(context, AppCubit.get(context).ArapicPhotoList[index],index)),
                          ),
                          fallback: (BuildContext context) => const Center(
                              child: const CircularProgressIndicator()),
                        );
                      }
                    },
                  ),
                if(translator.isDirectionRTL(context)==false)
                StreamBuilder<QuerySnapshot>(
                  stream: AppCubit.get(context).GetVideos(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      AppCubit.get(context).videoList = [];
                      for (var doc in snapshot.data!.docs) {
                        AppCubit.get(context).videoList.add(VideoModel(photo: doc['photo'], video: doc['video']));
                        //             AppCubit.get(context).videoController.add(VideoPlayerController.network(doc['video']));
                      }
                      return ConditionalBuilder(
                        condition: AppCubit.get(context).videoList.length > 0,
                        builder: (BuildContext context) => Container(
                          child: GridView.count(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            crossAxisCount: 3,
                            shrinkWrap: true,
                            childAspectRatio: 1 / 1.8,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            padding: EdgeInsetsDirectional.only(
                                start: 7.sp,
                                end: 7.sp,
                                top: 7.sp,
                                bottom: 7.sp),
                            physics: const ScrollPhysics(),
                            children: List.generate(
                                AppCubit.get(context).videoList.length,
                                (index) => Video(AppCubit.get(context).videoList[index],index)),
                          ),
                        ),
                        fallback: (BuildContext context) => const Center(
                            child: const CircularProgressIndicator()),
                      );
                    }
                  },
                ),
                if(translator.isDirectionRTL(context)==true)
                StreamBuilder<QuerySnapshot>(
                  stream: AppCubit.get(context).GetArabicVideos(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      AppCubit.get(context).ArabicvideoList = [];
                      for (var doc in snapshot.data!.docs) {
                        AppCubit.get(context).ArabicvideoList.add(VideoModel(photo: doc['photo'], video: doc['video']));
                        //             AppCubit.get(context).videoController.add(VideoPlayerController.network(doc['video']));
                      }
                      return ConditionalBuilder(
                        condition: AppCubit.get(context).ArabicvideoList.length > 0,
                        builder: (BuildContext context) => Container(
                          child: GridView.count(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            crossAxisCount: 3,
                            shrinkWrap: true,
                            childAspectRatio: 1 / 1.8,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            padding: EdgeInsetsDirectional.only(
                                start: 7.sp,
                                end: 7.sp,
                                top: 7.sp,
                                bottom: 7.sp),
                            physics: const ScrollPhysics(),
                            children: List.generate(
                                AppCubit.get(context).ArabicvideoList.length,
                                    (index) => arabicVideo(AppCubit.get(context).ArabicvideoList[index],index)),
                          ),
                        ),
                        fallback: (BuildContext context) => const Center(
                            child: const CircularProgressIndicator()),
                      );
                    }
                  },
                ),
                if(translator.isDirectionRTL(context)==false)
                StreamBuilder<QuerySnapshot>(
                  stream: AppCubit.get(context).GetQoutes(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data!.size == 0) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      AppCubit.get(context).Qoutes = [];
                      List<String> Ids = [];
                      for (var doc in snapshot.data!.docs) {
                        AppCubit.get(context).Qoutes.add(QouteModel(name: doc['name'], iconImage: doc['icon']));
                        Ids.add(doc.id);
                      }
                      return ConditionalBuilder(
                        condition: true,
                        builder: (BuildContext context) => Container(
                            child: ListView.separated(
                                itemBuilder: (context, index) =>
                                    ListViewForQoutes(
                                      context,
                                      AppCubit.get(context).Qoutes[index],
                                      Ids[index],
                                    ),
                                separatorBuilder: (context, index) => Container(
                                      height: 0,
                                      color: Colors.grey[300],
                                    ),
                                itemCount: AppCubit.get(context).Qoutes.length)),
                        fallback: (BuildContext context) => const Center(
                            child: const CircularProgressIndicator()),
                      );
                    }
                  },
                ),
                if(translator.isDirectionRTL(context)==true)
                  StreamBuilder<QuerySnapshot>(
                    stream: AppCubit.get(context).GetArabicQoutes(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data!.size == 0) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        AppCubit.get(context).ArabicQoutesList = [];
                        List<String> Ids = [];
                        for (var doc in snapshot.data!.docs) {
                          AppCubit.get(context).ArabicQoutesList.add(QouteModel(name: doc['name'], iconImage: doc['icon']));
                          Ids.add(doc.id);
                        }
                        return ConditionalBuilder(
                          condition: true,
                          builder: (BuildContext context) => Container(
                              child: ListView.separated(
                                  itemBuilder: (context, index) =>
                                      ListViewForArabicQoutes(
                                        context,
                                        AppCubit.get(context).ArabicQoutesList[index],
                                        Ids[index],
                                      ),
                                  separatorBuilder: (context, index) => Container(
                                    height: 0,
                                    color: Colors.grey[300],
                                  ),
                                  itemCount: AppCubit.get(context).ArabicQoutesList.length)),
                          fallback: (BuildContext context) => const Center(
                              child: const CircularProgressIndicator()),
                        );
                      }
                    },
                  ),

                 */
                if(translator.isDirectionRTL(context)==false)
                  PaginateFirestore(
                    itemBuilder: (context, documentSnapshots, index)
                  {
                  AppCubit.get(context).photoList = [];
                  for (var doc in documentSnapshots) {
                    AppCubit.get(context).photoList.add(PhotoModel(image: doc['image']));
                  }
                  return Builview(context,documentSnapshots[index]['image'],index,);
                  }, // orderBy is compulsary to enable pagination
                    query: FirebaseFirestore.instance.collection('Photoes').orderBy('time',descending: true),
                     itemBuilderType: PaginateBuilderType.gridView,
                    allowImplicitScrolling:true,
                    gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1 / 1.8,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,),
                      itemsPerPage:12,
                      padding: EdgeInsets.all(7.sp) ,
                      shrinkWrap: true,bottomLoader:Text(''),
                    isLive: true,
                  ),
                if(translator.isDirectionRTL(context)==true)
                  PaginateFirestore(
                    itemBuilder: (context, documentSnapshots, index)
                    {
                      AppCubit.get(context).ArapicPhotoList = [];
                      for (var doc in documentSnapshots) {
                        AppCubit.get(context).ArapicPhotoList.add(PhotoModel(image: doc['image']));
                      }
                      return buildViewForArabicPhotes(context,documentSnapshots[index]['image'],index,);
                    }, // orderBy is compulsary to enable pagination
                    query: FirebaseFirestore.instance.collection('صور').orderBy("time", descending: true),
                    itemBuilderType: PaginateBuilderType.gridView,allowImplicitScrolling:true,
                    gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1 / 1.8,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,),
                    itemsPerPage:12,
                    padding: EdgeInsets.all(7.sp) ,bottomLoader:Text(''),
                    shrinkWrap: true,
                    isLive: true,
                  ),
                if(translator.isDirectionRTL(context)==false)
                  PaginateFirestore(
                    itemBuilder: (context, documentSnapshots, index)
                    {
                      AppCubit.get(context).videoList = [];
                      for (var doc in documentSnapshots) {
                        AppCubit.get(context).videoList.add(VideoModel(photo: doc['photo'],video: doc['video']));
                      }
                      return Video(context,documentSnapshots[index]['photo'],documentSnapshots[index]['video'],index,);
                    }, // orderBy is compulsary to enable pagination
                    query:FirebaseFirestore.instance.collection('videos').orderBy("time", descending: true),
                    itemBuilderType: PaginateBuilderType.gridView,allowImplicitScrolling:true,
                    gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1 / 1.8,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,),
                    itemsPerPage:12,
                    padding: EdgeInsets.all(7.sp) ,
                    shrinkWrap: true,
                    isLive: true,
                    bottomLoader:Text(''),
                  ),
                if(translator.isDirectionRTL(context)==true)
                  PaginateFirestore(
                    itemBuilder: (context, documentSnapshots, index)
                    {
                      AppCubit.get(context).ArabicvideoList = [];
                      for (var doc in documentSnapshots) {
                        AppCubit.get(context).ArabicvideoList.add(VideoModel(photo: doc['photo'],video: doc['video']));
                      }
                      return arabicVideo(context,documentSnapshots[index]['photo'],documentSnapshots[index]['video'],index,);
                    }, // orderBy is compulsary to enable pagination
                    query:FirebaseFirestore.instance.collection('فيديو').orderBy("time", descending: true),
                    itemBuilderType: PaginateBuilderType.gridView,allowImplicitScrolling:true,
                    gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1 / 1.8,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,),
                    itemsPerPage:12,bottomLoader:Text(''),
                    padding: EdgeInsets.all(7.sp) ,
                    shrinkWrap: true,
                    isLive: true,
                  ),
                if(translator.isDirectionRTL(context)==false)
                  StreamBuilder<QuerySnapshot>(
                    stream: AppCubit.get(context).GetQoutes(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data!.size == 0) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        AppCubit.get(context).Qoutes = [];
                        List<String> Ids = [];
                        for (var doc in snapshot.data!.docs) {
                          AppCubit.get(context).Qoutes.add(QouteModel(name: doc['name'], iconImage: doc['icon']));
                          Ids.add(doc.id);
                        }
                        return ConditionalBuilder(
                          condition: true,
                          builder: (BuildContext context) => Container(
                              child: ListView.separated(
                                  itemBuilder: (context, index) =>
                                      ListViewForQoutes(
                                        context,
                                        AppCubit.get(context).Qoutes[index],
                                        Ids[index],
                                      ),
                                  separatorBuilder: (context, index) => Container(
                                    height: 0,
                                    color: Colors.grey[300],
                                  ),
                                  itemCount: AppCubit.get(context).Qoutes.length)),
                          fallback: (BuildContext context) => const Center(
                              child: const CircularProgressIndicator()),
                        );
                      }
                    },
                  ),
                if(translator.isDirectionRTL(context)==true)
                  StreamBuilder<QuerySnapshot>(
                    stream: AppCubit.get(context).GetArabicQoutes(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data!.size == 0) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        AppCubit.get(context).ArabicQoutesList = [];
                        List<String> Ids = [];
                        for (var doc in snapshot.data!.docs) {
                          AppCubit.get(context).ArabicQoutesList.add(QouteModel(name: doc['name'], iconImage: doc['icon']));
                          Ids.add(doc.id);
                        }
                        return ConditionalBuilder(
                          condition: true,
                          builder: (BuildContext context) => Container(
                              child: ListView.separated(
                                  itemBuilder: (context, index) =>
                                      ListViewForArabicQoutes(
                                        context,
                                        AppCubit.get(context).ArabicQoutesList[index],
                                        Ids[index],
                                      ),
                                  separatorBuilder: (context, index) => Container(
                                    height: 0,
                                    color: Colors.grey[300],
                                  ),
                                  itemCount: AppCubit.get(context).ArabicQoutesList.length)),
                          fallback: (BuildContext context) => const Center(
                              child: const CircularProgressIndicator()),
                        );
                      }
                    },
                  ),
              ]),
              bottomNavigationBar: _isBottomBannerAdLoaded
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
          ),
        );
      },
    );
  }
}

DropdownMenuItem<String> BuildMenuItem(String item) {
  return DropdownMenuItem(
    child: Text(
      item,
      style: TextStyle(
        fontSize: 16.sp,
        color: Colors.white,
      ),
    ),
    value: item,
  );
}

class Builview extends StatefulWidget {
//  PhotoModel photoList;
  int index;
  var data;
  var documentSnapshot;
  Builview(BuildContext context, this.documentSnapshot, int this.index,{Key? key})
      : super(key: key);

  @override
  _BuilviewState createState() => _BuilviewState();
}

class _BuilviewState extends State<Builview> {
  @override
  Widget build(BuildContext context) {
    return ScaleButton(
      bound: .1,
      reverse: true,
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          if (AppCubit.get(context).interstialadCountForPhotoes == 5) {
            AppCubit.get(context).showInterstialAd();
          } else if (AppCubit.get(context).interstialadCountForPhotoes == 0) {
            AppCubit.get(context).loadInterstialAd();
          }
          AppCubit.get(context).adCountForPhotoes();
          print(
              'quote == ${AppCubit.get(context).interstialadCountForPhotoes}');
          NavigateTo(context, PhotoOpen('${widget.documentSnapshot}', widget.index));
        },
        child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            color: AppCubit.get(context).isDark == false
                ? Colors.white
                : Colors.black,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.sp),
                bottomRight: Radius.circular(10.sp),
                topLeft: Radius.circular(10.sp),
                topRight: Radius.circular(10.sp)),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 0),
                blurRadius: .5,
                color: AppCubit.get(context).isDark == false
                    ? Colors.black
                    : Colors.white,
              ),
            ],
          ),
          child: CachedNetworkImage(
            placeholder: (context, url) => Center(
              child: Icon(Icons.image,
                  size: 36.sp,
                  color: AppCubit.get(context).isDark == false
                      ? Colors.green[200]
                      : Colors.green[200]),

              /*

              Shimmer.fromColors(

                baseColor:  Colors.grey[350]!,

                highlightColor: Colors.grey[100]!,

                child: Container(

                  width: double.infinity,

                  color: Colors.grey[700],

                ),

              ),



                   */
            ),

            //            height: 28.h,
            width: double.infinity,
            fit: BoxFit.cover,
            imageUrl: '${widget.documentSnapshot}',
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.sp),
                    bottomRight: Radius.circular(10.sp),
                    topLeft: Radius.circular(10.sp),
                    topRight: Radius.circular(10.sp)),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 0),
                    blurRadius: .5,
                    color: AppCubit.get(context).isDark == false
                        ? Colors.black
                        : Colors.white,
                  ),
                ],
              ),
            ),

            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}

/*
Widget BuilView(BuildContext context, param1, int index,) =>
    ScaleButton(
      bound: .1,
      reverse: true,
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          if(AppCubit.get(context).interstialadCountForPhotoes==5)
          {
            AppCubit.get(context).showInterstialAd();
          }
          else if(AppCubit.get(context).interstialadCountForPhotoes==0) {
            AppCubit.get(context).loadInterstialAd();
          }
          AppCubit.get(context).adCountForPhotoes();
          print('quote == ${AppCubit.get(context).interstialadCountForPhotoes}');
          NavigateTo(context, PhotoOpen('${param1}',index));
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppCubit.get(context).isDark == false ? Colors.white : Colors.black,

            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.sp),
                bottomRight: Radius.circular(10.sp),
                topLeft: Radius.circular(10.sp),
                topRight: Radius.circular(10.sp)),

            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 0),
                blurRadius: 0,
                color: AppCubit.get(context).isDark==false?Colors.black:Colors.white,
              ),
            ],
          ),
          child: CachedNetworkImage(
            placeholder: (context, url) => Center(
              child: Icon(Icons.image,
                  size: 36.sp,
                  color: AppCubit.get(context).isDark == false
                      ? Colors.green[200]
                      : Colors.green[200]),

              /*

              Shimmer.fromColors(

                baseColor:  Colors.grey[350]!,

                highlightColor: Colors.grey[100]!,

                child: Container(

                  width: double.infinity,

                  color: Colors.grey[700],

                ),

              ),



                   */
            ),

            //            height: 28.h,
            width: double.infinity,
            fit: BoxFit.cover,
            imageUrl: '${param1}',
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.sp),
                    bottomRight: Radius.circular(10.sp),
                    topLeft: Radius.circular(10.sp),
                    topRight: Radius.circular(10.sp)),
                image:
                    DecorationImage(image: imageProvider, fit: BoxFit.cover),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 0),
                    blurRadius: .5,
                    color: AppCubit.get(context).isDark==false?Colors.black:Colors.white,
                  ),
                ],
              ),
            ),

            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );

 */

Widget buildViewForArabicPhotes(BuildContext context, documentSnapshot, int index) =>
    ScaleButton(
      bound: .1,
      reverse: true,
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          if (AppCubit.get(context).interstialadCountForPhotoes == 5) {
            AppCubit.get(context).showInterstialAd();
          } else if (AppCubit.get(context).interstialadCountForPhotoes == 0) {
            AppCubit.get(context).loadInterstialAd();
          }
          AppCubit.get(context).adCountForPhotoes();
          NavigateTo(context, PhotoOpen('${documentSnapshot}', index));
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppCubit.get(context).isDark == false
                ? Colors.white
                : Colors.black,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.sp),
                bottomRight: Radius.circular(10.sp),
                topLeft: Radius.circular(10.sp),
                topRight: Radius.circular(10.sp)),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 0),
                blurRadius: .5,
                color: AppCubit.get(context).isDark == false
                    ? Colors.black
                    : Colors.white,
              ),
            ],
          ),
          child: CachedNetworkImage(
            placeholder: (context, url) => Center(
              child: Icon(Icons.image,
                  size: 36.sp,
                  color: AppCubit.get(context).isDark == false
                      ? Colors.green[200]
                      : Colors.green[200]),

              /*

              Shimmer.fromColors(

                baseColor:  Colors.grey[350]!,

                highlightColor: Colors.grey[100]!,

                child: Container(

                  width: double.infinity,

                  color: Colors.grey[700],

                ),

              ),



                   */
            ),

            //            height: 28.h,

            width: double.infinity,

            fit: BoxFit.cover,

            imageUrl: '${documentSnapshot}',

            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.sp),
                    bottomRight: Radius.circular(10.sp),
                    topLeft: Radius.circular(10.sp),
                    topRight: Radius.circular(10.sp)),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 0),
                    blurRadius: .5,
                    color: AppCubit.get(context).isDark == false
                        ? Colors.black
                        : Colors.white,
                  ),
                ],
              ),
            ),

            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
/*
 BuilViewForVideo(BuildContext context, VideoModel videoList){
  AppCubit.get(context).videoPlayerController = VideoPlayerController.network(videoList.video!);
  //if(!AppCubit.get(context).videoPlayerController.value.isInitialized)
  Future.wait({AppCubit.get(context).videoPlayerController.initialize()});
  // AppCubit.get(context).LoadFrame(videoList.video);
  return Material(
    color: Colors.grey,
    child: InkWell(
      onTap: () {
        NavigateTo(context,VideoOpen(videoList.video));
      },
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                //    height: 252,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(2.sp),
                      bottomRight: Radius.circular(2.sp),
                      topLeft: Radius.circular(2.sp),
                      topRight: Radius.circular(2.sp)),),
                child:Stack(children:
                [
                  VideoPlayer(AppCubit.get(context).videoPlayerController),
                  Center(child: Icon(MdiIcons.play,color: Colors.white,size: 40.sp,)),
                ],
                ),

              ),
            ),
          ],
        ),
      ),
    ),
  );
}

 */
Widget ListViewForQoutes(
  BuildContext context,
  QouteModel qout,
  String id,
) {
  AppCubit.get(context).GetMasseges(id);
  return InkWell(
    onTap: () {
      NavigateTo(context, QouteScreen(id, qout.name));
    },
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            height: 38.sp,
            width: 38.sp,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(const Radius.circular(20)),
                color: AppCubit.get(context).isDark == false
                    ? Colors.white
                    : Colors.black,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage('${qout.iconImage}'))),
            child: CachedNetworkImage(
              imageUrl: '${qout.iconImage}',
              placeholder: (context, url) => CupertinoActivityIndicator(
                  color: AppCubit.get(context).isDark == false
                      ? Colors.black
                      : Colors.grey),
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(20)),
                    color: AppCubit.get(context).isDark == false
                        ? Colors.white
                        : Colors.black,
                    image: DecorationImage(
                        fit: BoxFit.cover, image: imageProvider)),
              ),
            ),
          ),
          SizedBox(
            width: 4.w,
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${qout.name}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: 'VarelaRound',
                      fontWeight: FontWeight.w600,
                      color: AppCubit.get(context).isDark == false
                          ? Colors.grey[700]
                          : Colors.white),
                ),
                SizedBox(
                  height: .5.h,
                ),
                Row(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        height: 2.h,
                        width: 4.w,
                        child: Image(
                          height: 15.sp,
                          color: Colors.green,
                          image: const AssetImage(
                            'Assets/images/email.png',
                          ),
                        )),
                    SizedBox(
                      width: 2.w,
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: AppCubit.get(context).GetNumberOfQoutes(id),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || snapshot.data!.size == 0) {
                          return Text(
                            translator.isDirectionRTL(context)
                                ? '0 رسائل'
                                : '0 Messages',
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: translator.isDirectionRTL(context)
                                    ? 11.sp
                                    : 10.sp),
                          );
                        } else {
                          return Row(
                            children: [
                              Text(
                                '${snapshot.data!.docs.length}',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 10.sp,
                                    fontFamily: 'VarelaRound'),
                              ),
                              SizedBox(width: 1.w),
                              Text(
                                'Messages'.tr(),
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: translator.isDirectionRTL(context)
                                        ? 11.sp
                                        : 10.sp,
                                    fontFamily: 'VarelaRound'),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

///اقتباسات عربي
Widget ListViewForArabicQoutes(
  BuildContext context,
  QouteModel qout,
  String id,
) {
  AppCubit.get(context).GetMasseges(id);
  return InkWell(
    onTap: () {
      NavigateTo(context, QouteScreen(id, qout.name));
    },
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            height: 38.sp,
            width: 38.sp,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(const Radius.circular(20)),
                color: AppCubit.get(context).isDark == false
                    ? Colors.white
                    : Colors.black,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage('${qout.iconImage}'))),
            child: CachedNetworkImage(
              imageUrl: '${qout.iconImage}',
              placeholder: (context, url) => CupertinoActivityIndicator(
                  color: AppCubit.get(context).isDark == false
                      ? Colors.black
                      : Colors.grey),
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(20)),
                    color: AppCubit.get(context).isDark == false
                        ? Colors.white
                        : Colors.black,
                    image: DecorationImage(
                        fit: BoxFit.cover, image: imageProvider)),
              ),
            ),
          ),
          SizedBox(
            width: 4.w,
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${qout.name}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 17.sp,
                      fontFamily: 'ElMessiri',
                      fontWeight: FontWeight.w600,
                      color: AppCubit.get(context).isDark == false
                          ? Colors.grey[700]
                          : Colors.white),
                ),
                Row(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        height: 2.h,
                        width: 4.w,
                        child: Image(
                          height: 15.sp,
                          color: Colors.green,
                          image: const AssetImage(
                            'Assets/images/email.png',
                          ),
                        )),
                    SizedBox(
                      width: 2.w,
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: AppCubit.get(context).GetNumberOfArabicQoutes(id),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || snapshot.data!.size == 0) {
                          return Text(
                            translator.isDirectionRTL(context)
                                ? '0 رسائل'
                                : '0 Messages',
                            style: TextStyle(
                                fontFamily: 'ElMessiri',
                                color: Colors.green,
                                fontSize: translator.isDirectionRTL(context)
                                    ? 11.sp
                                    : 10.sp),
                          );
                        } else {
                          return Row(
                            children: [
                              Text(
                                '${snapshot.data!.docs.length}',
                                style:  TextStyle(
                                    color: Colors.green, fontSize: 12.sp),
                              ),
                              SizedBox(width: 1.w),
                              Text(
                                'Messages'.tr(),
                                style: TextStyle(
                                    fontFamily: 'ElMessiri',
                                    color: Colors.green,
                                    fontSize: translator.isDirectionRTL(context)
                                        ? 11.sp
                                        : 10.sp),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

///اقتباسات عربي

class Video extends StatefulWidget {
  int index;

  var photo;

  var video;

  Video(BuildContext context, this.photo, this.video, int this.index,   {Key? key}) : super(key: key);

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  /*
  @override
  void initState() async{
   // AppCubit.get(context).initalizePlayer(widget.videoList.video);
  }

   */
/*
  @override
  void initState() {
    super.initState();
    if(!widget.videoController.value.isInitialized)
    {
      Future.wait([widget.videoController.initialize()]).then((value)
      {
   //     setState(() {});
      });
    //////
 //     widget.videoController..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
  //      setState(() {});
  //    });
    }
     }
*/

  @override
  Widget build(BuildContext context) {
    return ScaleButton(
      bound: .1,
      reverse: true,
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          if (AppCubit.get(context).interstialadCountForVideos == 5) {
            AppCubit.get(context).showInterstialAd();
          } else if (AppCubit.get(context).interstialadCountForVideos == 0) {
            AppCubit.get(context).loadInterstialAd();
          }
          AppCubit.get(context).adCountForVideos();
          print('quote == ${AppCubit.get(context).interstialadCountForVideos}');
          NavigateTo(
              context,
              VideoOpen(widget.video, widget.photo, widget.index));
        },
        /*
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  //    height: 252,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(2.sp),
                        bottomRight: Radius.circular(2.sp),
                        topLeft: Radius.circular(2.sp),
                        topRight: Radius.circular(2.sp)),),
                  child:Stack(children:
                  [
           //         if(!widget.videoController.value.isInitialized)
                      Center(
                        child: Shimmer.fromColors(
                          baseColor:  Colors.grey[350]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: double.infinity,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
             //       VideoPlayer(widget.videoController),
                    Container(decoration: BoxDecoration(image: DecorationImage(image: NetworkImage('${widget.videoList.photo}')))),
                    Center(child: Icon(MdiIcons.play,color: Colors.white,size: 40.sp,)),
                  ],
                  ),

                ),
              ),
            ],
          ),
        ),

         */
        child: Container(
          decoration: BoxDecoration(
            color: AppCubit.get(context).isDark == false
                ? Colors.white
                : Colors.black,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.sp),
                bottomRight: Radius.circular(10.sp),
                topLeft: Radius.circular(10.sp),
                topRight: Radius.circular(10.sp)),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 0),
                blurRadius: .5,
                color: AppCubit.get(context).isDark == false
                    ? Colors.black
                    : Colors.white,
              ),
            ],
          ),
          child: CachedNetworkImage(
            placeholder: (context, url) => Center(
              child: Image.asset('Assets/images/video.png',
                  height: 5.h,
                  color: AppCubit.get(context).isDark
                      ? Colors.green[200]
                      : Colors.green[200]),
              /*
               CupertinoActivityIndicator(color: AppCubit.get(context).isDark==false?Colors.black:Colors.grey),

                    */

              /*
               Icon(Icons.play_arrow,size: 65.sp,color: Colors.white),

                */
              /*
               Shimmer.fromColors(
                 baseColor:  Colors.grey[350]!,
                 highlightColor: Colors.grey[100]!,
                 child: Container(
                   width: double.infinity,
                   color: Colors.grey[700],
                 ),
               ),

                    */
            ),
            /*
                 Center(
               child: Shimmer.fromColors(
                 baseColor:  Colors.grey[350]!,
                 highlightColor: Colors.grey[100]!,
                 child: Container(
                   width: double.infinity,
                   color: Colors.grey[700],
                 ),
               ),
             ),

                  */
            width: double.infinity,
            fit: BoxFit.cover,
            imageUrl: '${widget.photo}',
            imageBuilder: (context, imageProvider) => Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.sp),
                        bottomRight: Radius.circular(10.sp),
                        topLeft: Radius.circular(10.sp),
                        topRight: Radius.circular(10.sp)),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 0),
                        blurRadius: .5,
                        color: AppCubit.get(context).isDark == false
                            ? Colors.black
                            : Colors.white,
                      ),
                    ],
                  ),
                ),
                /*
                 Center(child: Icon(MdiIcons.play,color: Colors.white,size: 40.sp)),
                  */
                Center(
                    child: Image.asset('Assets/images/play-button.png',
                        height: 35.sp, color: Colors.white)),
              ],
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}

///arabicVideos

class arabicVideo extends StatefulWidget {

  var index;

  var photo;

  var video;

  // VideoPlayerController videoController;

  arabicVideo(BuildContext context, this.photo, this.video,this.index,  {Key? key})
      : super(key: key);

  @override
  State<arabicVideo> createState() => _arabicVideoState();
}

class _arabicVideoState extends State<arabicVideo> {
  /*
  @override
  void initState() async{
   // AppCubit.get(context).initalizePlayer(widget.videoList.video);
  }

   */
/*
  @override
  void initState() {
    super.initState();
    if(!widget.videoController.value.isInitialized)
    {
      Future.wait([widget.videoController.initialize()]).then((value)
      {
   //     setState(() {});
      });
    //////
 //     widget.videoController..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
  //      setState(() {});
  //    });
    }
     }
*/

  @override
  Widget build(BuildContext context) {
    return ScaleButton(
      bound: .1,
      reverse: true,
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          if (AppCubit.get(context).interstialadCountForVideos == 5) {
            AppCubit.get(context).showInterstialAd();
          } else if (AppCubit.get(context).interstialadCountForVideos == 0) {
            AppCubit.get(context).loadInterstialAd();
          }
          AppCubit.get(context).adCountForVideos();
          NavigateTo(
              context,
              VideoOpen(widget.video, widget.photo,
                  widget.index));
        },
        /*
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  //    height: 252,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(2.sp),
                        bottomRight: Radius.circular(2.sp),
                        topLeft: Radius.circular(2.sp),
                        topRight: Radius.circular(2.sp)),),
                  child:Stack(children:
                  [
           //         if(!widget.videoController.value.isInitialized)
                      Center(
                        child: Shimmer.fromColors(
                          baseColor:  Colors.grey[350]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: double.infinity,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
             //       VideoPlayer(widget.videoController),
                    Container(decoration: BoxDecoration(image: DecorationImage(image: NetworkImage('${widget.videoList.photo}')))),
                    Center(child: Icon(MdiIcons.play,color: Colors.white,size: 40.sp,)),
                  ],
                  ),

                ),
              ),
            ],
          ),
        ),

         */
        child: Container(
          decoration: BoxDecoration(
            color: AppCubit.get(context).isDark == false
                ? Colors.white
                : Colors.black,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.sp),
                bottomRight: Radius.circular(10.sp),
                topLeft: Radius.circular(10.sp),
                topRight: Radius.circular(10.sp)),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 0),
                blurRadius: .5,
                color: AppCubit.get(context).isDark == false
                    ? Colors.black
                    : Colors.white,
              ),
            ],
          ),
          child: CachedNetworkImage(
            placeholder: (context, url) => Center(
              child: Image.asset('Assets/images/video.png',
                  height: 5.h,
                  color: AppCubit.get(context).isDark
                      ? Colors.green[200]
                      : Colors.green[200]),
            ),
            /*
               CupertinoActivityIndicator(color: AppCubit.get(context).isDark==false?Colors.black:Colors.grey),

                    */

            /*
               Icon(Icons.play_arrow,size: 65.sp,color: Colors.white),

                */
            /*
               Shimmer.fromColors(
                 baseColor:  Colors.grey[350]!,
                 highlightColor: Colors.grey[100]!,
                 child: Container(
                   width: double.infinity,
                   color: Colors.grey[700],
                 ),
               ),

                    */
            /*
                 Center(
               child: Shimmer.fromColors(
                 baseColor:  Colors.grey[350]!,
                 highlightColor: Colors.grey[100]!,
                 child: Container(
                   width: double.infinity,
                   color: Colors.grey[700],
                 ),
               ),
             ),

                  */
            width: double.infinity,
            fit: BoxFit.cover,
            imageUrl: '${widget.photo}',
            imageBuilder: (context, imageProvider) => Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.sp),
                        bottomRight: Radius.circular(10.sp),
                        topLeft: Radius.circular(10.sp),
                        topRight: Radius.circular(10.sp)),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 0),
                        blurRadius: .5,
                        color: AppCubit.get(context).isDark == false
                            ? Colors.black
                            : Colors.white,
                      ),
                    ],
                  ),
                ),
                /*
                 Center(child: Icon(MdiIcons.play,color: Colors.white,size: 40.sp)),
                  */
                Center(
                    child: Image.asset('Assets/images/play-button.png',
                        height: 35.sp, color: Colors.white)),
              ],
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}

///arabicVideos
