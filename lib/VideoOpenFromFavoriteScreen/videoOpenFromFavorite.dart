
import 'dart:io';

import 'package:better_player/better_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:statuses/AppCubit/appCubit.dart';
import 'package:statuses/AppCubit/appCubitStates.dart';
import 'package:statuses/shared/styles/icon_broken.dart';
import 'package:video_player/video_player.dart';

class VideoOpenFromFavoriteScreen extends StatefulWidget {
  var favoriteVideoList;

  VideoOpenFromFavoriteScreen(this.favoriteVideoList,  {Key? key}) : super(key: key);

  @override
  State<VideoOpenFromFavoriteScreen> createState() => _VideoOpenFromFavoriteScreenState();
}

class _VideoOpenFromFavoriteScreenState extends State<VideoOpenFromFavoriteScreen> {
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
  late BetterPlayerController _betterPlayerController;
  @override
  initState()  {
    super.initState();
    _createBottomBannerAd();
    _betterPlayerController = BetterPlayerController(
      const BetterPlayerConfiguration(
        autoPlay: true,
        fit: BoxFit.cover,
        aspectRatio: 8/19,
        autoDetectFullscreenDeviceOrientation: true,autoDispose: true,expandToFill: true,handleLifecycle: true,
        looping: true,placeholderOnTop: true,showPlaceholderUntilPlay: true,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          enableOverflowMenu: false,
          showControlsOnInitialize: false,
          enableRetry: true,
          showControls: true,
          enableQualities: true,
        ),
      ),
      betterPlayerDataSource: BetterPlayerDataSource.network(widget.favoriteVideoList.toString()),
    );
    /*
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    });


     */
    /*
     videoPlayerController = VideoPlayerController.network(widget.videoList.video.toString());
     videoPlayerController.initialize().then((value)
    {
      setState(() {
        videoPlayerController.play();
      });
    });
    /*
   if(!widget.videoController.value.isInitialized)
     widget.videoController.initialize().then((value)
     {
     //  setState(() {});
     });
    // _controller = VideoPlayerController.network('${widget.video}')
     // ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
     //   setState(() {});
   //   });


     */

    _chewieController = ChewieController(
      allowedScreenSleep: false,
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
      videoPlayerController: videoPlayerController,
      //    aspectRatio: _aspectRatio,
      autoInitialize: true,
      autoPlay: true,
      showControls: true,
      looping: true,
      zoomAndPan: true,
    );

    _chewieController.addListener(() {
      if (_chewieController.isFullScreen) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
        ]);
      } else {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      }
    });

    AppCubit.get(context).progresss = 0;

     */
    /*
    betterPlayerController = BetterPlayerController(
       BetterPlayerConfiguration(
        autoPlay: true,
        fit: BoxFit.contain,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          enableOverflowMenu: true,
          showControlsOnInitialize: true,
          enableSkips: true,
          enableQualities: true,

          enableRetry: true,
          showControls: true,
        ),
      ),
      betterPlayerDataSource: BetterPlayerDataSource.network(widget.video),
    );

    betterPlayerController.addEventsListener((BetterPlayerEvent event) {
      if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
        betterPlayerController.setOverriddenAspectRatio(
            betterPlayerController.videoPlayerController!.value.aspectRatio);
        setState(() {});
      }
    });


   */
  }
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppCubit.get(context).isDark?SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      //  statusBarIconBrightness: Brightness.light,
      ):SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
    //    statusBarIconBrightness: Brightness.light,
      ),
      child: BlocConsumer<AppCubit,AppCubitStates>(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state) {

          return Scaffold(
            /*
            appBar: AppBar(
              toolbarHeight: 0.h,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
                systemNavigationBarColor: Colors.black,
              ),
              backgroundColor: Colors.black,
              /*
                leading: IconButton(
                  icon: const Icon(IconBroken.Arrow___Left, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),

                 */
            ),

             */
            appBar: AppBar(
              toolbarHeight: 0.h,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
                systemNavigationBarColor: Colors.black,
              ),
              backgroundColor: Colors.black,
              /*
              leading: IconButton(
                icon: const Icon(IconBroken.Arrow___Left, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

               */
            ),
            body: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Container(color: Colors.black,
                        child: BetterPlayer(
                          controller: _betterPlayerController,
                        ),
                      ),
                    ),
                    if (AppCubit.get(context).circle != 0)
                      Container(
                        height: 3.h,
                        child: Padding(
                          padding: EdgeInsets.only(right: 3.w, left: 3.w),
                          child: SizedBox(
                            width: double.infinity,
                            height: 3.5.h,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                LinearProgressIndicator(
                                  minHeight: 1.h,
                                  valueColor: AlwaysStoppedAnimation(
                                      AppCubit.get(context).isDark
                                          ? Colors.green
                                          : Colors.green),
                                  //      strokeWidth: 10,
                                  value: AppCubit.get(context).circle,
                                  backgroundColor: Colors.grey[300],
                                ),
                                Center(
                                  child: AppCubit.get(context).circle != 100
                                      ? Text(AppCubit.get(context).text,
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: AppCubit.get(context).isDark
                                              ? Colors.black
                                              : Colors.black))
                                      : const Icon(Icons.done,
                                      size: 50, color: Colors.green),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    if (AppCubit.get(context).progresss != 0)
                      Container(
                        height: 3.h,
                        child: Padding(
                          padding: EdgeInsets.only(left: 3.h, right: 3.h),
                          child: SizedBox(
                            width: double.infinity,
                            height: 3.5.h,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                LinearProgressIndicator(
                                  minHeight: 1.h,
                                  valueColor: AlwaysStoppedAnimation(
                                      AppCubit.get(context).isDark
                                          ? Colors.green
                                          : Colors.green),
                                  //     strokeWidth: 10,
                                  value: AppCubit.get(context).progresss,
                                  backgroundColor: Colors.grey[300],
                                ),
                                Center(
                                    child: AppCubit.get(context)
                                        .buildProgressForVideoScreen()),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 2.w,vertical: 3.h),
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
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _betterPlayerController.dispose();
    _bottomBannerAd.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

}
