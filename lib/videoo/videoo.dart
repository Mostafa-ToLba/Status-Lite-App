
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';



class VideoApp extends StatefulWidget {
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/Assets-for-api-docs/Assets/videos/bee.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
              : Container(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      );
  }
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    /*
                      Padding(
                        padding:  EdgeInsets.only(bottom: 11.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(top: 0),
                              child: Column(
                                children: [
                                  IconButton(onPressed: ()
                                  {
                                    if (AppCubit.get(context).IsFavoriteVideosList.containsValue(widget.video)) {
                                      AppCubit.get(context).deleteDataForVideosFromVideoScreen(video:widget.video);
                                    }
                                    else {
                                      AppCubit.get(context).insertToDatabaseForVideos(imageVideo: widget.photo, video: widget.video).then((value) {
                                        AppCubit.get(context).getDataFromVideoDatabase(AppCubit.get(context).databaseForVideos);

                                      });
                                    }

                                  }, icon: Icon(Icons.favorite,color:AppCubit.get(context).IsFavoriteVideosList.containsValue(widget.video)? Colors.green:Colors.white,size: 30.sp,)),
                                  SizedBox(height: .5.h),
                                  Padding(
                                    padding:  EdgeInsets.only(left: 2.w),
                                    child: Text('Like',style: TextStyle(color: Colors.white,fontSize: 11.sp, ),),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(top: 1.h),
                              child: Column(
                                children: [
                                  IconButton(onPressed: AppCubit.get(context).progresss == 0 && AppCubit.get(context).circle == 0 ?()
                                  {
                                    AppCubit.get(context).startShare(video: widget.video);
                                  }:null, icon: Icon(MdiIcons.share,color: Colors.white,size: 30.sp,)),
                                  Padding(
                                    padding:  EdgeInsets.only(left: 2.w),
                                    child: Text('Share',style: TextStyle(color: Colors.white,fontSize: 11.sp, ),),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(top: 1.h),
                              child: Column(
                                children: [
                                  IconButton(onPressed: ()
                                  {
                                    if(AppCubit.get(context).circle==0&&AppCubit.get(context).progresss == 0)
                                      AppCubit.get(context).Download(video: widget.video);
                                    else
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                          content:
                                          Text('please wait previous download is not finished')));

                                  }, icon: Icon(MdiIcons.download,color: Colors.white,size: 30.sp,)),
                                  Padding(
                                    padding:  EdgeInsets.only(left: 2.w),
                                    child: Text('Download',style: TextStyle(color: Colors.white,fontSize: 11.sp, ),),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                       */

    /*
    Padding(
      padding:  EdgeInsets.only(top: 50.h,left: 3.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding:  EdgeInsets.only(top: 0),
            child: Column(
              children: [
                IconButton(onPressed: ()
                {
                  if (AppCubit.get(context).IsFavoriteVideosList.containsValue(widget.video)) {
                    AppCubit.get(context).deleteDataForVideosFromVideoScreen(video:widget.video);
                  }
                  else {
                    AppCubit.get(context).insertToDatabaseForVideos(imageVideo: widget.photo, video: widget.video).then((value) {
                      AppCubit.get(context).getDataFromVideoDatabase(AppCubit.get(context).databaseForVideos);

                    });
                  }

                }, icon: Icon(Icons.favorite,color:AppCubit.get(context).IsFavoriteVideosList.containsValue(widget.video)? Colors.green:Colors.white,size: 30.sp,)),
                SizedBox(height: .5.h),
                Padding(
                  padding:  EdgeInsets.only(left: 2.w),
                  child: Text('Like',style: TextStyle(color: Colors.white,fontSize: 11.sp, ),),
                ),
              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(top: 1.h),
            child: Column(
              children: [
                IconButton(onPressed: AppCubit.get(context).progresss == 0 && AppCubit.get(context).circle == 0 ?()
                {
                  AppCubit.get(context).startShare(video: widget.video);
                }:null, icon: Icon(MdiIcons.share,color: Colors.white,size: 30.sp,)),
                Padding(
                  padding:  EdgeInsets.only(left: 2.w),
                  child: Text('Share',style: TextStyle(color: Colors.white,fontSize: 11.sp, ),),
                ),
              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(top: 1.h),
            child: Column(
              children: [
                IconButton(onPressed: ()
                {
                  if(AppCubit.get(context).circle==0&&AppCubit.get(context).progresss == 0)
                    AppCubit.get(context).Download(video: widget.video);
                  else
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                        Text('please wait previous download is not finished')));

                }, icon: Icon(MdiIcons.download,color: Colors.white,size: 30.sp,)),
                Padding(
                  padding:  EdgeInsets.only(left: 2.w),
                  child: Text('Download',style: TextStyle(color: Colors.white,fontSize: 11.sp, ),),
                ),
              ],
            ),
          ),
        ],
      ),
    ),

     */
  }
}