import 'dart:io';

import 'package:better_player/better_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:statuses/AppCubit/appCubit.dart';
import 'package:statuses/AppCubit/appCubitStates.dart';
import 'package:statuses/Models/videoModel/videoModel.dart';
import 'package:statuses/shared/styles/icon_broken.dart';

class VideoOpen extends StatefulWidget {
  var video;
  var photo;
  int index;

  VideoOpen(this.video, this.photo, this.index, {Key? key}) : super(key: key);

  @override
  State<VideoOpen> createState() => _VideoOpenState();
}

class _VideoOpenState extends State<VideoOpen> {
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
  PageController? contoller;



  /*
  static const SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: Colors.black,
  );

   */
  /*
  late ChewieController _chewieController;
  late BetterPlayerController betterPlayerController;
  late VideoPlayerController videoPlayerController;


  @override
  void initState() {
    super.initState();
    /*
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    });


     */
      videoPlayerController = VideoPlayerController.network(widget.video)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
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

    bettroller.addEventsListener((BetterPlayerEvent event) {
      if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
        betterPlayerController.setOverriddenAspectRatio(
            betterPlayerController.videoPlayerController!.value.aspectRatio);
        setState(() {});
      }
    });


   */
  }

   */

  /*
  Future startDownload() async {
    final request = Request('GET', Uri.parse(widget.video));
    final response = await Client().send(request);
    final contentLength = response.contentLength;
    final file = await getFile('file.mp4');
    final bytes = <int>[];
    response.stream.listen(
      (newBytes) {
        bytes.addAll(newBytes);

        setState(() {
          progress = bytes.length / contentLength!;
        });
      },
      onDone: () async {
        setState(() {
          progress = 1;
          progress = 0;
        });
        await file.writeAsBytes(bytes);
      },
      onError: print,
      cancelOnError: false,
    );
    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/myfile.video.mp4';
    await Dio().download(widget.video, path).then((value) async {
      await GallerySaver.saveVideo(path).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Downladed To Gallery')));
      });
    });
  }

  Future starttDownload() async {
    final url = '${widget.video}';

    final request = Request('GET', Uri.parse(url));
    final response = await Client().send(request);
    final contentLength = response.contentLength;

    final file = await getFile('file.mp4');
    final bytes = <int>[];
    response.stream.listen(
      (newBytes) {
        bytes.addAll(newBytes);
        setState(() {
          progress = bytes.length / contentLength!;
        });
      },
      onDone: () async {
        setState(() {
          progress = 1;
        });

        await file.writeAsBytes(bytes);
      },
      onError: print,
      cancelOnError: true,
    );
  }

   */

  //Download--share
  /*
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
    if (progress == 1) {
      return const Icon(
        Icons.done,
        color: Colors.green,
        size: 56,
      );
    } else {
      return Text(
        '${(progress * 100).toStringAsFixed(1)}',
        style:  TextStyle(
          fontWeight: FontWeight.bold,
          color: AppCubit.get(context).isDark?Colors.white:Colors.black,
          fontSize: 24,
        ),
      );
    }
  }

  Future startShare() async {
    if(progress == 0 && AppCubit.get(context).ss == 0)
    {
      progress =.1;
      final url = widget.video;
      final request = Request('GET', Uri.parse(url));
      final response = await Client().send(request);
      final contentLength = response.contentLength;

      final file = await getFile('file.mp4');
      final bytes = <int>[];
      response.stream.listen(
            (newBytes) {
          bytes.addAll(newBytes);

          setState(() {
            progress = bytes.length / contentLength!;
          });
        },
        onDone: () async {
          setState(() {
            progress = 1;
            progress = 0;
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
  }

  Future downloadVideo()
  async{
    if(check==0)
    {
      check=1;
      final temp = await getTemporaryDirectory();
      final path =
          '${temp.path}/myfile.video.mp4';
      await Dio().download(
        widget.video,
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
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Downladed To Gallery')));
          setState(() {
            AppCubit.get(context).ss = 0;
          });
          check =0;
        });
      });
    }
    else null;
  }

   */

/*
  Future<File> getFile(String filename) async {
    final dir = await getApplicationDocumentsDirectory();

    return File('${dir.path}/$filename');
  }


 */

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
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppCubitStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {

          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 0.h,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
                systemNavigationBarColor: Colors.black,
                systemNavigationBarDividerColor: Colors.transparent,
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
            body: translator.isDirectionRTL(context)?Stack(
              children: [
                PageView.builder(
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (page)
                  {
                    if(AppCubit.get(context).interstialadCountForVideoOpen==5)
                    {
                      AppCubit.get(context).showInterstialAd();
                    }
                    else if(AppCubit.get(context).interstialadCountForVideoOpen==0) {
                      AppCubit.get(context).loadInterstialAd();
                    }
                    AppCubit.get(context).adCountForVideoOpen();
                  },
                  itemCount: AppCubit.get(context).ArabicvideoList.length,
                  /*
                  List.generate(AppCubit.get(context).videoList.length, (index) => pageView(AppCubit.get(context).videoList[index]),),

                   */
                  controller: contoller, itemBuilder: (BuildContext context, int index)=>pageViewForArabicVideos(AppCubit.get(context).ArabicvideoList[index]),
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 2.w,vertical: 3.h),
                  child: Container(
                    child: IconButton(
                      iconSize: 5.h,
                      onPressed: () async {
                      Navigator.pop(context);
                    }, icon: Icon(IconBroken.Arrow___Right,size:23.sp),
                      splashColor: Colors.transparent,color: Colors.white,
                      highlightColor: Colors.transparent,

                    ),
                  ),
                ),
              ],
            ):
            Stack(
              children: [
                PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: AppCubit.get(context).videoList.length,
                  onPageChanged: (page)
                  {
                    if(AppCubit.get(context).interstialadCountForVideoOpen==5)
                    {
                      AppCubit.get(context).showInterstialAd();
                    }
                    else if(AppCubit.get(context).interstialadCountForVideoOpen==0) {
                      AppCubit.get(context).loadInterstialAd();
                    }
                    AppCubit.get(context).adCountForVideoOpen();
                  },
                  /*
                  List.generate(AppCubit.get(context).videoList.length, (index) => pageView(AppCubit.get(context).videoList[index]),),

                   */
                  controller: contoller, itemBuilder: (BuildContext context, int index)=>pageView(AppCubit.get(context).videoList[index]),
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 2.w,vertical: 3.h),
                  child: Container(
                    child: IconButton(
                      iconSize: 5.h,
                      onPressed: () async {
                      Navigator.pop(context);
                    }, icon: Icon(IconBroken.Arrow___Left,size:23.sp),
                      splashColor: Colors.transparent,color: Colors.white,
                      highlightColor: Colors.transparent,

                    ),
                  ),
                ),
              ],
            ),
            /*
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                if (videoPlayerController.value.isInitialized)
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          color: Colors.black,
                          child: Chewie(
                            controller: _chewieController,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 47.h, left: 3.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 0),
                                child: Column(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          if (AppCubit.get(context).IsFavoriteVideosList.containsValue(widget.video)) {
                                            AppCubit.get(context)
                                                .deleteDataForVideosFromVideoScreen(
                                                    video: widget.video);
                                          } else {
                                            AppCubit.get(context)
                                                .insertToDatabaseForVideos(
                                                    imageVideo: widget.photo,
                                                    video: widget.video)
                                                .then((value) {
                                              AppCubit.get(context)
                                                  .getDataFromVideoDatabase(
                                                      AppCubit.get(context)
                                                          .databaseForVideos);
                                            });
                                          }
                                        },
                                        icon: Icon(
                                          Icons.favorite,
                                          color: AppCubit.get(context)
                                                  .IsFavoriteVideosList
                                                  .containsValue(widget.video)
                                              ? Colors.green
                                              : Colors.white,
                                          size: 30.sp,
                                        )),
                                    SizedBox(height: .5.h),
                                    Padding(
                                      padding: EdgeInsets.only(left: 2.w),
                                      child: Text(
                                        'Like',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 1.h),
                                child: Column(
                                  children: [
                                    IconButton(
                                        onPressed: AppCubit.get(context).progresss == 0 && AppCubit.get(context).circle == 0 ? () async {
                                               await  AppCubit.get(context).startShare(video: widget.video);
                                              }
                                            : null,
                                        icon: Icon(
                                          MdiIcons.share,
                                          color: Colors.white,
                                          size: 30.sp,
                                        )),
                                    Padding(
                                      padding: EdgeInsets.only(left: 2.w),
                                      child: Text(
                                        'Share',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 1.h),
                                child: Column(
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          if (AppCubit.get(context).circle == 0 && AppCubit.get(context).progresss == 0)
                                        await  AppCubit.get(context).Download(video: widget.video);
                                          else
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'please wait previous download is not finished')));
                                        },
                                        icon: Icon(
                                          MdiIcons.download,
                                          color: Colors.white,
                                          size: 30.sp,
                                        )),
                                    Padding(
                                      padding: EdgeInsets.only(left: 2.w),
                                      child: Text(
                                        'Download',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                if (!videoPlayerController.value.isInitialized)
                  Expanded(
                      child: Center(
                          child: CupertinoActivityIndicator(
                    animating: true,
                    radius: 15.sp,
                    color: AppCubit.get(context).isDark
                        ? Colors.white
                        : Colors.grey,
                  ))),

                /*
                if(videoPlayerController.value.isInitialized)
                  Container(
                    height: 10.h,
                  child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 3.w,
                      ),
                      Expanded(
                          child: ScaleButton(
                            bound:.2,
                            reverse: true,
                            child: OutlinedButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.resolveWith(AppCubit.get(context).padding),
                                backgroundColor: MaterialStateProperty.resolveWith(AppCubit.get(context).getColor),
                                  overlayColor: MaterialStateProperty.resolveWith(AppCubit.get(context).getColorr),
                              ),
                                onPressed: AppCubit.get(context).progresss == 0 && AppCubit.get(context).circle == 0 ? () {
                                   AppCubit.get(context).startShare(video: widget.video);
                                          }
                                        : null,
                                child: Text('Share',style: TextStyle(color: AppCubit.get(context).isDark==false?Colors.green:Colors.white),)),
                          )),
                      SizedBox(
                        width: 3.w,
                      ),
                      Expanded(
                          child: ScaleButton(
                            bound:.2,
                            reverse: true,
                            child: OutlinedButton(
                                style: ButtonStyle(
                                  padding:  MaterialStateProperty.resolveWith(AppCubit.get(context).padding),
                                  backgroundColor:
                                AppCubit.get(context).IsFavoriteVideosList.containsValue(widget.video)?MaterialStateProperty.all(AppCubit.get(context).isDark==false?Colors.green:Colors.green):MaterialStateProperty.all(AppCubit.get(context).isDark==false?Colors.transparent:Colors.grey[800]),
                                    overlayColor: MaterialStateProperty.resolveWith(AppCubit.get(context).getColorr),
                                ),
                                onPressed: () {
                                  if (AppCubit.get(context).IsFavoriteVideosList.containsValue(widget.video)) {
                                    AppCubit.get(context).deleteDataForVideosFromVideoScreen(video:widget.video);
                                  }
                                  else {
             AppCubit.get(context).insertToDatabaseForVideos(imageVideo: widget.photo, video: widget.video).then((value) {
                   AppCubit.get(context).getDataFromVideoDatabase(AppCubit.get(context).databaseForVideos);

                                    });
                                  }
                                },
                                child:AppCubit.get(context).IsFavoriteVideosList.containsValue(widget.video)?
                                Text('Love',style: TextStyle(color:AppCubit.get(context).isDark==false?Colors.white:Colors.white),):
                                Text('Love',style: TextStyle(color:AppCubit.get(context).isDark==false?Colors.green:Colors.white),)
                            ),
                          )),
                      SizedBox(
                        width: 3.w,
                      ),
                      Expanded(
                          child: ScaleButton(
                            bound:.2,
                            reverse: true,
                            child: OutlinedButton(
                              style: ButtonStyle(
                                padding:  MaterialStateProperty.resolveWith(AppCubit.get(context).padding),
                                backgroundColor: MaterialStateProperty.resolveWith(AppCubit.get(context).getColor),
                                  overlayColor: MaterialStateProperty.resolveWith(AppCubit.get(context).getColorr),
                              ),
                                onPressed: () {
                                  if(AppCubit.get(context).circle==0&&AppCubit.get(context).progresss == 0)
                                    AppCubit.get(context).Download(video: widget.video);
                                  else
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                        content:
                                        Text('please wait previous download is not finished')));
                                      },
                                child:  Text('Download',style: TextStyle(color: AppCubit.get(context).isDark==false?Colors.green:Colors.white),),),
                          )),
                      SizedBox(
                        width: 3.w,
                      ),
                    ],
                  ),
                ),

                 */

                //        if (AppCubit.get(context).circle != 0||AppCubit.get(context).progresss != 0)
                //          SizedBox(height: 2.h),
                if (AppCubit.get(context).circle != 0)
                  Container(
                    height: 2.h,
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
                    height: 2.h,
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

             */
            bottomNavigationBar: _isBottomBannerAdLoaded
                ? Container(
              height: _bottomBannerAd.size.height.toDouble(),
              width: _bottomBannerAd.size.width.toDouble(),
              child: AdWidget(ad: _bottomBannerAd),
            )
                : null,
          );
        });
  }
}

class pageView extends StatefulWidget {
  VideoModel videoList;

   pageView( this.videoList, {Key? key}) : super(key: key);

  @override
  _pageViewState createState() => _pageViewState();
}

class _pageViewState extends State<pageView> {
 // late ChewieController _chewieController;
 // late VideoPlayerController videoPlayerController;
  late BetterPlayerController _betterPlayerController;

  @override
  initState()  {
    super.initState();
    _betterPlayerController = BetterPlayerController(
      const BetterPlayerConfiguration(
        autoPlay: true,
        fit: BoxFit.cover,
        aspectRatio: 8/19,
        autoDetectFullscreenAspectRatio: true,
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
      betterPlayerDataSource: BetterPlayerDataSource.network(widget.videoList.video.toString()),
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
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ):SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
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
           body: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisSize: MainAxisSize.max,
             children: [
          //     if (_betterPlayerController.videoPlayerController!.value.initialized)
                 Expanded(
                   child: Stack(
                     children: [
                       BetterPlayer(
                         controller: _betterPlayerController,
                       ),
                       if(SizerUtil.deviceType==DeviceType.mobile)
                       Padding(
                         padding: EdgeInsets.only(top: 42.h, left: .5.w,right: 4.w),
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Padding(
                               padding: EdgeInsets.only(top: 0),
                               child: Column(
                                 children: [
                                   IconButton(
                                       onPressed: () {
                                         if (AppCubit.get(context).IsFavoriteVideosList.containsValue(widget.videoList.video)) {
                                           AppCubit.get(context).deleteDataForVideosFromVideoScreen(video: widget.videoList.video);
                                         }
                                         else {
                                           AppCubit.get(context).insertToDatabaseForVideos(imageVideo: widget.videoList.photo, video: widget.videoList.video)
                                               .then((value) {
                                             AppCubit.get(context).getDataFromVideoDatabase(AppCubit.get(context).databaseForVideos);
                                           });
                                         }
                                       },
                                       icon: Icon(
                                         Icons.favorite,
                                         color: AppCubit.get(context)
                                             .IsFavoriteVideosList
                                             .containsValue(widget.videoList.video)
                                             ? Colors.red
                                             : Colors.white,
                                         size: 30.sp,
                                       )),
                                   SizedBox(height:translator.isDirectionRTL(context)? 0:.5.h),
                                   Padding(
                                     padding: EdgeInsets.only(left: 2.w),
                                     child: Text(
                                       'likeButton'.tr(),
                                       style: TextStyle(
                                         color: Colors.white,
                                         fontSize:translator.isDirectionRTL(context)?13.sp:12.sp,fontFamily: 'VarelaRound',fontWeight: FontWeight.w800
                                       ),
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                             Padding(
                               padding: EdgeInsets.only(top: 1.h),
                               child: Column(
                                 children: [
                                   IconButton(
                                       onPressed: AppCubit.get(context).progresss == 0 && AppCubit.get(context).circle == 0 ? () async {
                                         await  AppCubit.get(context).startShare(video: widget.videoList.video);
                                       }
                                           : null,
                                       icon: Icon(
                                         MdiIcons.share,
                                         color: Colors.white,
                                         size: 30.sp,
                                       )),
                                   Padding(
                                     padding: EdgeInsets.only(left: 2.w),
                                     child: Text(
                                       'shareButton'.tr(),
                                       style: TextStyle(
                                         color: Colors.white,
                                         fontSize:translator.isDirectionRTL(context)?13.sp:12.sp,fontFamily: 'VarelaRound',fontWeight: FontWeight.w800
                                       ),
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                             Padding(
                               padding: EdgeInsets.only(top: 1.h),
                               child: Column(
                                 children: [
                                   IconButton(
                                       onPressed: () async {
                                         if (AppCubit.get(context).circle == 0 && AppCubit.get(context).progresss == 0)
                                           await  AppCubit.get(context).Download(video: widget.videoList.video);
                                         else
                                           ScaffoldMessenger.of(context)
                                               .showSnackBar( SnackBar(content: Text('repaitDownload'.tr(),style: TextStyle(color:Colors.white,fontSize: 12.sp)),backgroundColor: Colors.green,));
                                       },
                                       icon: Icon(
                                         MdiIcons.download,
                                         color: Colors.white,
                                         size: 30.sp,
                                       )),
                                   Padding(
                                     padding: EdgeInsets.only(left: 2.w),
                                     child: Text(
                                       'downloadButton'.tr(),
                                       style: TextStyle(
                                         color: Colors.white,
                                         fontSize: translator.isDirectionRTL(context)?13.sp:11.sp,fontFamily: 'VarelaRound',fontWeight: FontWeight.w800
                                       ),
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                           ],
                         ),
                       ),
                       if(SizerUtil.deviceType==DeviceType.tablet)
                         Padding(
                           padding:  EdgeInsets.only(bottom: 8.h,left: 0.w,right: 4.w),
                           child: Container(
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.end,
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                     IconButton(
                                         iconSize: 6.h,
                                         onPressed: ()
                                         {
                                           if (AppCubit.get(context).IsFavoriteVideosList.containsValue(widget.videoList.video)) {
                                             AppCubit.get(context).deleteDataForVideosFromVideoScreen(video: widget.videoList.video);
                                           }
                                           else {
                                             AppCubit.get(context).insertToDatabaseForVideos(imageVideo: widget.videoList.photo, video: widget.videoList.video)
                                                 .then((value) {
                                               AppCubit.get(context).getDataFromVideoDatabase(AppCubit.get(context).databaseForVideos);
                                             });
                                           }

                                         }, icon:  Icon(
                                       Icons.favorite,
                                       color: AppCubit.get(context)
                                           .IsFavoriteVideosList
                                           .containsValue(widget.videoList.video)
                                           ? Colors.red
                                           : Colors.white,
                                       size: 30.sp,
                                     )),
                                     SizedBox(height:translator.isDirectionRTL(context)? 0: 1.h),
                                     Padding(
                                       padding:  EdgeInsets.only(left: 1.w),
                                       child: Text('likeButton'.tr(),style: TextStyle(color: Colors.white,fontSize:translator.isDirectionRTL(context)?13.sp :12.sp,fontFamily: 'VarelaRound',fontWeight: FontWeight.w800)),
                                     ),
                                   ],
                                 ),
                                 Padding(
                                   padding:  EdgeInsets.only(top: 1.h),
                                   child: Column(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     children: [
                                       IconButton(
                                           iconSize: 6.h,
                                           onPressed:AppCubit.get(context).progresss == 0 && AppCubit.get(context).circle == 0 ? () async {
          await  AppCubit.get(context).startShare(video: widget.videoList.video);
          }
              : null, icon: Icon(MdiIcons.share,color: Colors.white,size: 30.sp,)),
                                       SizedBox(height:translator.isDirectionRTL(context)? 0: 1.h),
                                       Padding(
                                         padding:  EdgeInsets.only(left: 1.w),
                                         child: Text('shareButton'.tr(),style: TextStyle(color: Colors.white,fontSize:translator.isDirectionRTL(context)?13.sp: 12.sp,fontFamily: 'VarelaRound',fontWeight: FontWeight.w800)),
                                       ),
                                     ],
                                   ),
                                 ),
                                 Padding(
                                   padding:  EdgeInsets.only(top: 1.h),
                                   child: Column(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     children: [
                                       IconButton(
                                           iconSize: 6.h,
                                           onPressed: ()
                                           async{
                                             if (AppCubit.get(context).circle == 0 && AppCubit.get(context).progresss == 0)
                                               await  AppCubit.get(context).Download(video: widget.videoList.video);
                                             else
                                               ScaffoldMessenger.of(context)
                                                   .showSnackBar( SnackBar(content: Text('repaitDownload'.tr(),style: TextStyle(color:Colors.white,fontSize: 12.sp)),backgroundColor: Colors.green,));

                                           }, icon: Icon(MdiIcons.download,color: Colors.white,size: 30.sp,)),
                                       SizedBox(height:translator.isDirectionRTL(context)? 0: 1.h),
                                       Padding(
                                         padding:  EdgeInsets.only(left: 1.w),
                                         child: Text('downloadButton'.tr(),style: TextStyle(color: Colors.white,fontSize:translator.isDirectionRTL(context)?13.sp:11.sp,fontWeight: FontWeight.w800,fontFamily: 'VarelaRound')),
                                       ),
                                     ],
                                   ),
                                 ),
                               ],
                             ),
                           ),
                         ),
                     ],
                   ),
                 ),
               /*
               if (!videoPlayerController.value.isInitialized)
                 Expanded(
                     child: Center(
                         child: CupertinoActivityIndicator(
                           animating: true,
                           radius: 15.sp,
                           color: AppCubit.get(context).isDark
                               ? Colors.white
                               : Colors.grey,
                         ))),

                */

               /*
                        if(videoPlayerController.value.isInitialized)
                          Container(
                            height: 10.h,
                          child: Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 3.w,
                              ),
                              Expanded(
                                  child: ScaleButton(
                                    bound:.2,
                                    reverse: true,
                                    child: OutlinedButton(
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty.resolveWith(AppCubit.get(context).padding),
                                        backgroundColor: MaterialStateProperty.resolveWith(AppCubit.get(context).getColor),
                                          overlayColor: MaterialStateProperty.resolveWith(AppCubit.get(context).getColorr),
                                      ),
                                        onPressed: AppCubit.get(context).progresss == 0 && AppCubit.get(context).circle == 0 ? () {
                                           AppCubit.get(context).startShare(video: widget.video);
                                                  }
                                                : null,
                                        child: Text('Share',style: TextStyle(color: AppCubit.get(context).isDark==false?Colors.green:Colors.white),)),
                                  )),
                              SizedBox(
                                width: 3.w,
                              ),
                              Expanded(
                                  child: ScaleButton(
                                    bound:.2,
                                    reverse: true,
                                    child: OutlinedButton(
                                        style: ButtonStyle(
                                          padding:  MaterialStateProperty.resolveWith(AppCubit.get(context).padding),
                                          backgroundColor:
                                        AppCubit.get(context).IsFavoriteVideosList.containsValue(widget.video)?MaterialStateProperty.all(AppCubit.get(context).isDark==false?Colors.green:Colors.green):MaterialStateProperty.all(AppCubit.get(context).isDark==false?Colors.transparent:Colors.grey[800]),
                                            overlayColor: MaterialStateProperty.resolveWith(AppCubit.get(context).getColorr),
                                        ),
                                        onPressed: () {
                                          if (AppCubit.get(context).IsFavoriteVideosList.containsValue(widget.video)) {
                                            AppCubit.get(context).deleteDataForVideosFromVideoScreen(video:widget.video);
                                          }
                                          else {
                     AppCubit.get(context).insertToDatabaseForVideos(imageVideo: widget.photo, video: widget.video).then((value) {
                           AppCubit.get(context).getDataFromVideoDatabase(AppCubit.get(context).databaseForVideos);

                                            });
                                          }
                                        },
                                        child:AppCubit.get(context).IsFavoriteVideosList.containsValue(widget.video)?
                                        Text('Love',style: TextStyle(color:AppCubit.get(context).isDark==false?Colors.white:Colors.white),):
                                        Text('Love',style: TextStyle(color:AppCubit.get(context).isDark==false?Colors.green:Colors.white),)
                                    ),
                                  )),
                              SizedBox(
                                width: 3.w,
                              ),
                              Expanded(
                                  child: ScaleButton(
                                    bound:.2,
                                    reverse: true,
                                    child: OutlinedButton(
                                      style: ButtonStyle(
                                        padding:  MaterialStateProperty.resolveWith(AppCubit.get(context).padding),
                                        backgroundColor: MaterialStateProperty.resolveWith(AppCubit.get(context).getColor),
                                          overlayColor: MaterialStateProperty.resolveWith(AppCubit.get(context).getColorr),
                                      ),
                                        onPressed: () {
                                          if(AppCubit.get(context).circle==0&&AppCubit.get(context).progresss == 0)
                                            AppCubit.get(context).Download(video: widget.video);
                                          else
                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                content:
                                                Text('please wait previous download is not finished')));
                                              },
                                        child:  Text('Download',style: TextStyle(color: AppCubit.get(context).isDark==false?Colors.green:Colors.white),),),
                                  )),
                              SizedBox(
                                width: 3.w,
                              ),
                            ],
                          ),
                        ),

                         */

               //        if (AppCubit.get(context).circle != 0||AppCubit.get(context).progresss != 0)
               //          SizedBox(height: 2.h),
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
          );
        },
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    _betterPlayerController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    /*
    void didChangeDependencies() {
      setState(() {
        AppCubit.get(context).progresss = 0;
        AppCubit.get(context).circle = 0;
        AppCubit.get(context).startShare().onError(
                (error, stackTrace) => AppCubit.get(context).progresss = 0);
      });

      super.didChangeDependencies();
    }

     */
  }
}
///arabicVideos

class pageViewForArabicVideos extends StatefulWidget {
  VideoModel videoList;

  pageViewForArabicVideos( this.videoList, {Key? key}) : super(key: key);

  @override
  _pageViewForArabicVideosState createState() => _pageViewForArabicVideosState();
}

class _pageViewForArabicVideosState extends State<pageViewForArabicVideos> {
  // late ChewieController _chewieController;
  // late VideoPlayerController videoPlayerController;
  late BetterPlayerController _betterPlayerController;

  @override
  initState()  {
    super.initState();
    _betterPlayerController = BetterPlayerController(
      const BetterPlayerConfiguration(
        autoPlay: true,
        fit: BoxFit.cover,
        aspectRatio: 8/19,
        autoDetectFullscreenAspectRatio: true,
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
      betterPlayerDataSource: BetterPlayerDataSource.network(widget.videoList.video.toString()),
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
    return BlocConsumer<AppCubit,AppCubitStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {

        return Scaffold(
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
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              //     if (_betterPlayerController.videoPlayerController!.value.initialized)
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      color: Colors.black,
                      child: BetterPlayer(
                        controller: _betterPlayerController,
                      ),
                    ),
               if(SizerUtil.deviceType==DeviceType.mobile)
                    Padding(
                      padding: EdgeInsets.only(top: 42.h, left: 3.w,right: 4.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 0),
                            child: Column(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      if (AppCubit.get(context).IsFavoriteArabicVideosList.containsValue(widget.videoList.video)) {
                                        AppCubit.get(context).deleteDataForArabicVideosFromVideoScreen(video: widget.videoList.video).then((value)
                                        {
                                          setState(() {
                                            AppCubit.get(context).getDataFromArabicVideoDatabases(AppCubit.get(context).databaseForArabicVideos);
                                          });
                                        });
                                      } else {
                                        AppCubit.get(context)
                                            .insertToDatabaseForArabicVideos(
                                            imageVideo: widget.videoList.photo,
                                            video: widget.videoList.video)
                                            .then((value) {
                                          AppCubit.get(context).getDataFromArabicVideoDatabase(AppCubit.get(context).databaseForArabicVideos);
                                        });
                                      }
                                    },
                                    icon: Icon(
                                      Icons.favorite,
                                      color: AppCubit.get(context).IsFavoriteArabicVideosList.containsValue(widget.videoList.video) ? Colors.red : Colors.white,
                                      size: 30.sp,
                                    )),
                                SizedBox(height:translator.isDirectionRTL(context)? 0:.5.h),
                                Padding(
                                  padding: EdgeInsets.only(left: 2.w),
                                  child: Text(
                                    'likeButton'.tr(),
                                    style: TextStyle(
                                      color: Colors.white,
                                        fontFamily: 'ElMessiri',
                                      fontSize:translator.isDirectionRTL(context)?13.sp:11.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 1.h),
                            child: Column(
                              children: [
                                IconButton(
                                    onPressed: AppCubit.get(context).progresss == 0 && AppCubit.get(context).circle == 0 ? () async {
                                      await  AppCubit.get(context).startShare(video: widget.videoList.video);
                                    }
                                        : null,
                                    icon: Icon(
                                      MdiIcons.share,
                                      color: Colors.white,
                                      size: 30.sp,
                                    )),
                                Padding(
                                  padding: EdgeInsets.only(left: 2.w),
                                  child: Text(
                                    'shareButton'.tr(),
                                    style: TextStyle(
                                      fontFamily: 'ElMessiri',
                                      color: Colors.white,
                                      fontSize:translator.isDirectionRTL(context)?13.sp:11.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 1.h),
                            child: Column(
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      if (AppCubit.get(context).circle == 0 && AppCubit.get(context).progresss == 0)
                                        await  AppCubit.get(context).Download(video: widget.videoList.video);
                                      else
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(content: Text('repaitDownload'.tr(),style: TextStyle(color:Colors.white,fontSize: 14.sp)),backgroundColor: Colors.green,));
                                    },
                                    icon: Icon(
                                      MdiIcons.download,
                                      color: Colors.white,
                                      size: 30.sp,
                                    )),
                                Padding(
                                  padding: EdgeInsets.only(left: 2.w),
                                  child: Text(
                                    'downloadButton'.tr(),
                                    style: TextStyle(
                                      color: Colors.white,
                                        fontFamily: 'ElMessiri',
                                      fontSize: translator.isDirectionRTL(context)?13.sp:11.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if(SizerUtil.deviceType==DeviceType.tablet)
                      Padding(
                        padding: EdgeInsets.only(top: 42.h, left: 3.w,right: 4.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: Column(
                                children: [
                                  IconButton(
                                      iconSize: 6.h,
                                      onPressed: () {
                                        if (AppCubit.get(context).IsFavoriteArabicVideosList.containsValue(widget.videoList.video)) {
                                          AppCubit.get(context).deleteDataForArabicVideosFromVideoScreen(video: widget.videoList.video).then((value)
                                          {
                                            setState(() {
                                              AppCubit.get(context).getDataFromArabicVideoDatabases(AppCubit.get(context).databaseForArabicVideos);
                                            });
                                          });
                                        } else {
                                          AppCubit.get(context)
                                              .insertToDatabaseForArabicVideos(
                                              imageVideo: widget.videoList.photo,
                                              video: widget.videoList.video)
                                              .then((value) {
                                            AppCubit.get(context).getDataFromArabicVideoDatabase(AppCubit.get(context).databaseForArabicVideos);
                                          });
                                        }
                                      },
                                      icon: Icon(
                                        Icons.favorite,
                                        color: AppCubit.get(context).IsFavoriteArabicVideosList.containsValue(widget.videoList.video) ? Colors.red : Colors.white,
                                        size: 30.sp,
                                      )),
                                  SizedBox(height:translator.isDirectionRTL(context)? 0:.5.h),
                                  Padding(
                                    padding: EdgeInsets.only(left: 0.w),
                                    child: Text(
                                      'likeButton'.tr(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'ElMessiri',
                                        fontSize:translator.isDirectionRTL(context)?13.sp:11.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 1.h),
                              child: Column(
                                children: [
                                  IconButton(
                                      iconSize: 6.h,
                                      onPressed: AppCubit.get(context).progresss == 0 && AppCubit.get(context).circle == 0 ? () async {
                                        await  AppCubit.get(context).startShare(video: widget.videoList.video);
                                      }
                                          : null,
                                      icon: Icon(
                                        MdiIcons.share,
                                        color: Colors.white,
                                        size: 30.sp,
                                      )),
                                  Padding(
                                    padding: EdgeInsets.only(left: 0.w),
                                    child: Text(
                                      'shareButton'.tr(),
                                      style: TextStyle(
                                        fontFamily: 'ElMessiri',
                                        color: Colors.white,
                                        fontSize:translator.isDirectionRTL(context)?13.sp:11.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 1.h),
                              child: Column(
                                children: [
                                  IconButton(
                                      iconSize: 6.h,
                                      onPressed: () async {
                                        if (AppCubit.get(context).circle == 0 && AppCubit.get(context).progresss == 0)
                                          await  AppCubit.get(context).Download(video: widget.videoList.video);
                                        else
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(content: Text('repaitDownload'.tr(),style: TextStyle(color:Colors.white,fontSize: 14.sp)),backgroundColor: Colors.green,));
                                      },
                                      icon: Icon(
                                        MdiIcons.download,
                                        color: Colors.white,
                                        size: 30.sp,
                                      )),
                                  Padding(
                                    padding: EdgeInsets.only(left: 0.w),
                                    child: Text(
                                      'downloadButton'.tr(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'ElMessiri',
                                        fontSize: translator.isDirectionRTL(context)?13.sp:11.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              /*
             if (!videoPlayerController.value.isInitialized)
               Expanded(
                   child: Center(
                       child: CupertinoActivityIndicator(
                         animating: true,
                         radius: 15.sp,
                         color: AppCubit.get(context).isDark
                             ? Colors.white
                             : Colors.grey,
                       ))),

              */
              /*
                      if(videoPlayerController.value.isInitialized)
                        Container(
                          height: 10.h,
                        child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 3.w,
                            ),
                            Expanded(
                                child: ScaleButton(
                                  bound:.2,
                                  reverse: true,
                                  child: OutlinedButton(
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.resolveWith(AppCubit.get(context).padding),
                                      backgroundColor: MaterialStateProperty.resolveWith(AppCubit.get(context).getColor),
                                        overlayColor: MaterialStateProperty.resolveWith(AppCubit.get(context).getColorr),
                                    ),
                                      onPressed: AppCubit.get(context).progresss == 0 && AppCubit.get(context).circle == 0 ? () {
                                         AppCubit.get(context).startShare(video: widget.video);
                                                }
                                              : null,
                                      child: Text('Share',style: TextStyle(color: AppCubit.get(context).isDark==false?Colors.green:Colors.white),)),
                                )),
                            SizedBox(
                              width: 3.w,
                            ),
                            Expanded(
                                child: ScaleButton(
                                  bound:.2,
                                  reverse: true,
                                  child: OutlinedButton(
                                      style: ButtonStyle(
                                        padding:  MaterialStateProperty.resolveWith(AppCubit.get(context).padding),
                                        backgroundColor:
                                      AppCubit.get(context).IsFavoriteVideosList.containsValue(widget.video)?MaterialStateProperty.all(AppCubit.get(context).isDark==false?Colors.green:Colors.green):MaterialStateProperty.all(AppCubit.get(context).isDark==false?Colors.transparent:Colors.grey[800]),
                                          overlayColor: MaterialStateProperty.resolveWith(AppCubit.get(context).getColorr),
                                      ),
                                      onPressed: () {
                                        if (AppCubit.get(context).IsFavoriteVideosList.containsValue(widget.video)) {
                                          AppCubit.get(context).deleteDataForVideosFromVideoScreen(video:widget.video);
                                        }
                                        else {
                   AppCubit.get(context).insertToDatabaseForVideos(imageVideo: widget.photo, video: widget.video).then((value) {
                         AppCubit.get(context).getDataFromVideoDatabase(AppCubit.get(context).databaseForVideos);

                                          });
                                        }
                                      },
                                      child:AppCubit.get(context).IsFavoriteVideosList.containsValue(widget.video)?
                                      Text('Love',style: TextStyle(color:AppCubit.get(context).isDark==false?Colors.white:Colors.white),):
                                      Text('Love',style: TextStyle(color:AppCubit.get(context).isDark==false?Colors.green:Colors.white),)
                                  ),
                                )),
                            SizedBox(
                              width: 3.w,
                            ),
                            Expanded(
                                child: ScaleButton(
                                  bound:.2,
                                  reverse: true,
                                  child: OutlinedButton(
                                    style: ButtonStyle(
                                      padding:  MaterialStateProperty.resolveWith(AppCubit.get(context).padding),
                                      backgroundColor: MaterialStateProperty.resolveWith(AppCubit.get(context).getColor),
                                        overlayColor: MaterialStateProperty.resolveWith(AppCubit.get(context).getColorr),
                                    ),
                                      onPressed: () {
                                        if(AppCubit.get(context).circle==0&&AppCubit.get(context).progresss == 0)
                                          AppCubit.get(context).Download(video: widget.video);
                                        else
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                              content:
                                              Text('please wait previous download is not finished')));
                                            },
                                      child:  Text('Download',style: TextStyle(color: AppCubit.get(context).isDark==false?Colors.green:Colors.white),),),
                                )),
                            SizedBox(
                              width: 3.w,
                            ),
                          ],
                        ),
                      ),

                       */

              //        if (AppCubit.get(context).circle != 0||AppCubit.get(context).progresss != 0)
              //          SizedBox(height: 2.h),
              if (AppCubit.get(context).circle != 0)
                Container(
                  height: 2.h,
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
                  height: 2.h,
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
        );
      },
    );
  }
  @override
  void dispose() {
    super.dispose();
    //   videoPlayerController.dispose();
    //  _chewieController.dispose();
    _betterPlayerController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    void didChangeDependencies() {
      setState(() {
        AppCubit.get(context).progresss = 0;
        AppCubit.get(context).circle = 0;
        AppCubit.get(context).startShare().onError(
                (error, stackTrace) => AppCubit.get(context).progresss = 0);
      });

      super.didChangeDependencies();
    }
  }
}
