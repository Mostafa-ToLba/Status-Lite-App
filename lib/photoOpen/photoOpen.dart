

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scale_button/scale_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:skeleton_animation/skeleton_animation.dart';
import 'package:square_percent_indicater/square_percent_indicater.dart';
import 'package:statuses/AppCubit/appCubit.dart';
import 'package:statuses/AppCubit/appCubitStates.dart';
import 'package:statuses/Models/photoModel/photoModel.dart';
import 'package:statuses/shared/componenet/component.dart';
import 'package:statuses/shared/styles/icon_broken.dart';
class PhotoOpen extends StatefulWidget {
  String image;

  int index;



   PhotoOpen( this.image, this.index,   {Key? key}) : super(key: key);

  @override
  State<PhotoOpen> createState() => _PhotoOpenState();
}

class _PhotoOpenState extends State<PhotoOpen> {
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
  @override
  Widget build(BuildContext context) {
   return BlocConsumer<AppCubit,AppCubitStates>(
          listener: (BuildContext context, state) {  },
          builder: (BuildContext context, Object? state) {
            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness:  Brightness.light,
              ),
              child: Scaffold(
                /*
                appBar: AppBar(
                  leading: IconButton(icon: const Icon(IconBroken.Arrow___Left,color: Colors.white), onPressed: ()
                  {
                    Navigator.pop(context);
                  },),
                ),

                 */
                body:translator.isDirectionRTL(context)?Stack(
                  children: [
                    PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: AppCubit.get(context).ArapicPhotoList.length,
                      onPageChanged: (page)
                      {
                        if(AppCubit.get(context).interstialadCountForPhotoOpen==5)
                        {
                          AppCubit.get(context).showInterstialAd();
                        }
                        else if(AppCubit.get(context).interstialadCountForPhotoOpen==0) {
                          AppCubit.get(context).loadInterstialAd();
                        }
                        AppCubit.get(context).adCountForPhotoOpen();
                      },
                      /*
                      List.generate(AppCubit.get(context).videoList.length, (index) => pageView(AppCubit.get(context).videoList[index]),),

                       */
                      controller: contoller, itemBuilder: (BuildContext context, int index)=>pageViewForArabicPhotoes(AppCubit.get(context).ArapicPhotoList[index]),
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 2.w,vertical: 5.h),
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
                ):
                Stack(
                  children: [
                    PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: AppCubit.get(context).photoList.length,
                      onPageChanged: (page)
                      {
                        if(AppCubit.get(context).interstialadCountForPhotoOpen==5)
                        {
                          AppCubit.get(context).showInterstialAd();
                        }
                        else if(AppCubit.get(context).interstialadCountForPhotoOpen==0) {
                          AppCubit.get(context).loadInterstialAd();
                        }
                        AppCubit.get(context).adCountForPhotoOpen();
                      },
                      /*
                      List.generate(AppCubit.get(context).videoList.length, (index) => pageView(AppCubit.get(context).videoList[index]),),

                       */
                      controller: contoller, itemBuilder: (BuildContext context, int index)=>pageView(AppCubit.get(context).photoList[index]),
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
                /*
                Stack(
                  children: [
                    InkWell(
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:AppCubit.get(context).isDark==false?Colors.white:Colors.black,
                          shape: BoxShape.rectangle,
                          /*
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 10),
                              blurRadius: 5,
                              spreadRadius: 25,
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ],

                           */
                      //        borderRadius: BorderRadius.circular(1.1.h),
                        ),
                        child: CachedNetworkImage(imageUrl: image,imageBuilder:(context, imageProvider) => Container(clipBehavior: Clip.antiAliasWithSaveLayer,decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(0),),image:DecorationImage(
                            image: imageProvider, fit: BoxFit.cover) )),
                          placeholder: (context, url) => const Center(child: CupertinoActivityIndicator(color: Colors.black,radius: 30),),
                        ),
                      ),
                      onTap: ()
                      {
                        /*
                        final imageProvider = Image.network(image).image;
                        showImageViewer(context, imageProvider, onViewerDismissed: () {
                          print("dismissed");
                        });

                         */
                      },
                    ),
                    Padding(
                      padding:  EdgeInsets.only(bottom: 7.h,left: 3.w),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(onPressed: ()
                                {
                                  if(AppCubit.get(context).IsFavoriteImagesList.containsValue(image))
                                  {
                                    AppCubit.get(context).deleteDataFromImagePage(image:image );
                                  }
                                  else
                                  {
                                    AppCubit.get(context).insertToDatabase(image: image).then((value){
                                      AppCubit.get(context).getDataFromImageDatabase(AppCubit.get(context).databaseForImages);
                                    });
                                  }

                                }, icon: Icon(Icons.favorite,color:AppCubit.get(context).IsFavoriteImagesList.containsValue(image)?Colors.green:Colors.white,size: 30.sp,)),
                                SizedBox(height: .5.h),
                                Padding(
                                  padding:  EdgeInsets.only(left: 1.w),
                                  child: Text('Like',style: TextStyle(color: Colors.white,fontSize: 11.sp)),
                                ),
                              ],
                            ),
                            Padding(
                              padding:  EdgeInsets.only(top: 1.h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(onPressed:()
                                  async{
                                    final urlImage =image;
                                    final url =Uri.parse(urlImage);
                                    final response = await http.get(url);
                                    final bytes = response.bodyBytes;
                                    final temp = await getTemporaryDirectory();
                                    final path ='${temp.path}/image.jpg';
                                    File(path).writeAsBytesSync(bytes);
                                    await Share.shareFiles([path]);

                                  }, icon: Icon(MdiIcons.share,color: Colors.white,size: 30.sp,)),
                                  SizedBox(height: .5.h),
                                  Padding(
                                    padding:  EdgeInsets.only(left: 1.w),
                                    child: Text('Share',style: TextStyle(color: Colors.white,fontSize: 10.sp)),
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
                                  IconButton(onPressed: ()
                                  async{
                                    final temp = await getTemporaryDirectory();
                                    final path = '${temp.path}/myfile.jpg';
                                    await Dio().download(image, path);
                                    await GallerySaver.saveImage(path);
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Downladed To Gallery')));

                                  }, icon: Icon(MdiIcons.download,color: Colors.white,size: 30.sp,)),
                                  SizedBox(height: .5.h),
                                  Padding(
                                    padding:  EdgeInsets.only(left: 2.w),
                                    child: Text('Download',style: TextStyle(color: Colors.white,fontSize: 10.sp)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    /*
                    SizedBox(height: 3.5.h),
                    Container(
                      height: 12.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 3.w,),
                          Expanded(child: ScaleButton(
                            bound:.2,
                            reverse: true,
                            child: OutlinedButton(

                              style:ButtonStyle(padding:MaterialStateProperty.resolveWith(AppCubit.get(context).padding) ,overlayColor: MaterialStateProperty.resolveWith(AppCubit.get(context).getColorr) ,backgroundColor: MaterialStateProperty.resolveWith(AppCubit.get(context).getColor),) ,
                              onPressed: ()
                            async {
                              final urlImage =image;
                              final url =Uri.parse(urlImage);
                              final response = await http.get(url);
                              final bytes = response.bodyBytes;
                              final temp = await getTemporaryDirectory();
                              final path ='${temp.path}/image.jpg';
                              File(path).writeAsBytesSync(bytes);
                              await Share.shareFiles([path]);

                            }, child:  Text('Share',style: TextStyle(color: AppCubit.get(context).isDark==false?Colors.green:Colors.white)), ),
                          ),),
                          SizedBox(width: 6.w,),
                          Expanded(
                            child: ScaleButton(
                              bound:.2,
                              reverse: true,
                              child: OutlinedButton(
                                style: ButtonStyle(
              overlayColor: MaterialStateProperty.resolveWith(AppCubit.get(context).getColorr),

                                    backgroundColor:

           AppCubit.get(context).IsFavoriteImagesList.containsValue(image)?MaterialStateProperty.all(AppCubit.get(context).isDark==false?Colors.green:Colors.green):MaterialStateProperty.all(AppCubit.get(context).isDark==false?Colors.transparent:Colors.grey[800]),
                             padding: MaterialStateProperty.resolveWith(AppCubit.get(context).padding),

                                ),
                                  onPressed: ()
                              {

                                if(AppCubit.get(context).IsFavoriteImagesList.containsValue(image))
                                {
                                  AppCubit.get(context).deleteDataFromImagePage(image:image );
                                }
                                else
                                {
                                  AppCubit.get(context).insertToDatabase(image: image).then((value){
                                    AppCubit.get(context).getDataFromImageDatabase(AppCubit.get(context).databaseForImages);
                                  });
                                }

                              }, child:AppCubit.get(context).IsFavoriteImagesList.containsValue(image)? Text('Love',style: TextStyle(color:AppCubit.get(context).isDark==false?Colors.white:Colors.white),):
              Text('Love',style: TextStyle(color:AppCubit.get(context).isDark==false?Colors.green:Colors.white),),),
                            ),
                          ),
                          SizedBox(width: 6.w,),
                          Expanded(child: ScaleButton(
                            bound:.2,
                            reverse: true,
                            child: OutlinedButton(
                                style: ButtonStyle(
                                  padding:  MaterialStateProperty.resolveWith(AppCubit.get(context).padding),
                                  backgroundColor:MaterialStateProperty.resolveWith(AppCubit.get(context).getColor),
              overlayColor: MaterialStateProperty.resolveWith(AppCubit.get(context).getColorr),
                                ),

                                onPressed: ()
                            async {
                              final temp = await getTemporaryDirectory();
                              final path = '${temp.path}/myfile.jpg';
                              await Dio().download(image, path);
                              await GallerySaver.saveImage(path);
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Downladed To Gallery')));
                            }, child:  Text('Download',style: TextStyle(color: AppCubit.get(context).isDark==false?Colors.green:Colors.white)),),
                          )),
                          SizedBox(width: 3.w,),
                        ],
                      ),
                    ),


                     */
                  ],
                  alignment: AlignmentDirectional.bottomStart,
                ),

                 */
                bottomNavigationBar: _isBottomBannerAdLoaded
                    ? Container(
                  color: AppCubit.get(context).isDark?Colors.black:Colors.white,
                  height: _bottomBannerAd.size.height.toDouble(),
                  width: _bottomBannerAd.size.width.toDouble(),
                  child: AdWidget(ad: _bottomBannerAd),
                )
                    : null,
              ),
            );
          },
        );
  }

}


 class pageView extends StatefulWidget {
  PhotoModel photoList;

    pageView(PhotoModel this.photoList,  {Key? key}) : super(key: key);

   @override
   _pageViewState createState() => _pageViewState();
 }

 class _pageViewState extends State<pageView> {
   @override
   Widget build(BuildContext context) {
     return BlocConsumer<AppCubit,AppCubitStates>(
       listener: (BuildContext context, state) {  },
     builder: (BuildContext context, Object? state) {
       return Scaffold(
         body: Stack(
           children: [
             InkWell(
               child: Container(
                 height: double.infinity,
                 width: double.infinity,
                 decoration: BoxDecoration(
                   color:AppCubit.get(context).isDark==false?Colors.white:Colors.black,
                   shape: BoxShape.rectangle,
                   /*
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 10),
                          blurRadius: 5,
                          spreadRadius: 25,
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ],

                       */
                   //        borderRadius: BorderRadius.circular(1.1.h),
                 ),
                 child: CachedNetworkImage(imageUrl: '${widget.photoList.image}',imageBuilder:(context, imageProvider) => Container(clipBehavior: Clip.antiAliasWithSaveLayer,decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(0),),image:DecorationImage(
                     image: imageProvider, fit: BoxFit.cover) )),
                   placeholder: (context, url) => const Center(child: CupertinoActivityIndicator(color: Colors.black,radius: 30),),
                 ),
               ),
               onTap: ()
               {
                 /*
                    final imageProvider = Image.network(image).image;
                    showImageViewer(context, imageProvider, onViewerDismissed: () {
                      print("dismissed");
                    });

                     */
               },
             ),
             if(SizerUtil.deviceType==DeviceType.mobile)
             Padding(
               padding:  EdgeInsets.only(bottom: 8.h,left: .5.w,right: 4.w),
               child: Container(
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.end,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         IconButton(onPressed: ()
                         {
                           if(AppCubit.get(context).IsFavoriteImagesList.containsValue(widget.photoList.image))
                           {

                               AppCubit.get(context).deleteDataFromImagePage(image:widget.photoList.image);

                           }
                           else
                           {
                             AppCubit.get(context).insertToDatabase(image: widget.photoList.image).then((value){
                                 AppCubit.get(context).getDataFromImageDatabasee(AppCubit.get(context).databaseForImages);
                             });
                           }

                         }, icon: Icon(Icons.favorite,color:AppCubit.get(context).IsFavoriteImagesList.containsValue(widget.photoList.image)?Colors.red:Colors.white,size: 30.sp,)),
                         SizedBox(height:translator.isDirectionRTL(context)? 0: .5.h),
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
                           IconButton(onPressed:()
                           async{
                             final urlImage =widget.photoList.image;
                             final url =Uri.parse(urlImage!);
                             final response = await http.get(url);
                             final bytes = response.bodyBytes;
                             final temp = await getTemporaryDirectory();
                             final path ='${temp.path}/image.jpg';
                             File(path).writeAsBytesSync(bytes);
                             await Share.shareFiles([path]);

                           }, icon: Icon(MdiIcons.share,color: Colors.white,size: 30.sp,)),
                           SizedBox(height:translator.isDirectionRTL(context)? 0:.5.h),
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
                           IconButton(onPressed: ()
                           async{
                             print('download start');
                             final temp = await getTemporaryDirectory();
                             final path = '${temp.path}.jpg';
                             await Dio().download(widget.photoList.image.toString(), path).then((value)
                             {
                                GallerySaver.saveImage(path).then((value)
                               {
                                 ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text('Download'.tr(),style: TextStyle(fontSize: 12.sp,color: Colors.white),),backgroundColor: Colors.green,),);
                               });
                             });
                           }, icon: Icon(MdiIcons.download,color: Colors.white,size: 30.sp,)),
                           SizedBox(height:translator.isDirectionRTL(context)? 0:.5.h),
                           Padding(
                             padding:  EdgeInsets.only(left: 2.w),
                             child: Text('downloadButton'.tr(),style: TextStyle(color: Colors.white,fontSize:translator.isDirectionRTL(context)?13.sp:11.sp,fontWeight: FontWeight.w800,fontFamily: 'VarelaRound')),
                           ),
                         ],
                       ),
                     ),
                   ],
                 ),
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
                             if(AppCubit.get(context).IsFavoriteImagesList.containsValue(widget.photoList.image))
                             {

                               AppCubit.get(context).deleteDataFromImagePage(image:widget.photoList.image);

                             }
                             else
                             {
                               AppCubit.get(context).insertToDatabase(image: widget.photoList.image).then((value){
                                 AppCubit.get(context).getDataFromImageDatabasee(AppCubit.get(context).databaseForImages);
                               });
                             }

                           }, icon: Icon(Icons.favorite,color:AppCubit.get(context).IsFavoriteImagesList.containsValue(widget.photoList.image)?Colors.red:Colors.white,size: 30.sp,)),
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
                                 onPressed:()
                             async{
                               final urlImage =widget.photoList.image;
                               final url =Uri.parse(urlImage!);
                               final response = await http.get(url);
                               final bytes = response.bodyBytes;
                               final temp = await getTemporaryDirectory();
                               final path ='${temp.path}/image.jpg';
                               File(path).writeAsBytesSync(bytes);
                               await Share.shareFiles([path]);

                             }, icon: Icon(MdiIcons.share,color: Colors.white,size: 30.sp,)),
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
                               final temp = await getTemporaryDirectory();
                               final path = '${temp.path}/.jpg';
                               await Dio().download(widget.photoList.image.toString(), path).then((value)
                               {
                                  GallerySaver.saveImage(path).then((value)
                                  {
                                    ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text('Download'.tr(),style: TextStyle(fontSize: 12.sp,color: Colors.white),),backgroundColor: Colors.green,),);
                                  });
                               });
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
             /*
                SizedBox(height: 3.5.h),
                Container(
                  height: 12.h
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 3.w,),
                      Expanded(child: ScaleButton(
                        bound:.2,
                        reverse: true,
                        child: OutlinedButton(

                          style:ButtonStyle(padding:MaterialStateProperty.resolveWith(AppCubit.get(context).padding) ,overlayColor: MaterialStateProperty.resolveWith(AppCubit.get(context).getColorr) ,backgroundColor: MaterialStateProperty.resolveWith(AppCubit.get(context).getColor),) ,
                          onPressed: ()
                        async {
                          final urlImage =image;
                          final url =Uri.parse(urlImage);
                          final response = await http.get(url);
                          final bytes = response.bodyBytes;
                          final temp = await getTemporaryDirectory();
                          final path ='${temp.path}/image.jpg';
                          File(path).writeAsBytesSync(bytes);
                          await Share.shareFiles([path]);

                        }, child:  Text('Share',style: TextStyle(color: AppCubit.get(context).isDark==false?Colors.green:Colors.white)), ),
                      ),),
                      SizedBox(width: 6.w,),
                      Expanded(
                        child: ScaleButton(
                          bound:.2,
                          reverse: true,
                          child: OutlinedButton(
                            style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith(AppCubit.get(context).getColorr),

                                backgroundColor:

       AppCubit.get(context).IsFavoriteImagesList.containsValue(image)?MaterialStateProperty.all(AppCubit.get(context).isDark==false?Colors.green:Colors.green):MaterialStateProperty.all(AppCubit.get(context).isDark==false?Colors.transparent:Colors.grey[800]),
                         padding: MaterialStateProperty.resolveWith(AppCubit.get(context).padding),

                            ),
                              onPressed: ()
                          {

                            if(AppCubit.get(context).IsFavoriteImagesList.containsValue(image))
                            {
                              AppCubit.get(context).deleteDataFromImagePage(image:image );
                            }
                            else
                            {
                              AppCubit.get(context).insertToDatabase(image: image).then((value){
                                AppCubit.get(context).getDataFromImageDatabase(AppCubit.get(context).databaseForImages);
                              });
                            }

                          }, child:AppCubit.get(context).IsFavoriteImagesList.containsValue(image)? Text('Love',style: TextStyle(color:AppCubit.get(context).isDark==false?Colors.white:Colors.white),):
          Text('Love',style: TextStyle(color:AppCubit.get(context).isDark==false?Colors.green:Colors.white),),),
                        ),
                      ),
                      SizedBox(width: 6.w,),
                      Expanded(child: ScaleButton(
                        bound:.2,
                        reverse: true,
                        child: OutlinedButton(
                            style: ButtonStyle(
                              padding:  MaterialStateProperty.resolveWith(AppCubit.get(context).padding),
                              backgroundColor:MaterialStateProperty.resolveWith(AppCubit.get(context).getColor),
          overlayColor: MaterialStateProperty.resolveWith(AppCubit.get(context).getColorr),
                            ),

                            onPressed: ()
                        async {
                          final temp = await getTemporaryDirectory();
                          final path = '${temp.path}/myfile.jpg';
                          await Dio().download(image, path);
                          await GallerySaver.saveImage(path);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Downladed To Gallery')));
                        }, child:  Text('Download',style: TextStyle(color: AppCubit.get(context).isDark==false?Colors.green:Colors.white)),),
                      )),
                      SizedBox(width: 3.w,),
                    ],
                  ),
                ),


                 */
           ],
           alignment: AlignmentDirectional.bottomStart,
         ),
       );
     },
     );
   }
 }


class pageViewForArabicPhotoes extends StatefulWidget {
  PhotoModel photoList;

  pageViewForArabicPhotoes(PhotoModel this.photoList,  {Key? key}) : super(key: key);

  @override
  _pageViewForArabicPhotoesState createState() => _pageViewForArabicPhotoesState();
}

class _pageViewForArabicPhotoesState extends State<pageViewForArabicPhotoes> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppCubitStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          body: Stack(
            children: [
              InkWell(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color:AppCubit.get(context).isDark==false?Colors.white:Colors.black,
                    shape: BoxShape.rectangle,
                    /*
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 10),
                          blurRadius: 5,
                          spreadRadius: 25,
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ],

                       */
                    //        borderRadius: BorderRadius.circular(1.1.h),
                  ),
                  child: CachedNetworkImage(imageUrl: '${widget.photoList.image}',imageBuilder:(context, imageProvider) => Container(clipBehavior: Clip.antiAliasWithSaveLayer,decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(0),),image:DecorationImage(
                      image: imageProvider, fit: BoxFit.cover) )),
                    placeholder: (context, url) => const Center(child: CupertinoActivityIndicator(color: Colors.black,radius: 30),),
                  ),
                ),
                onTap: ()
                {
                  /*
                    final imageProvider = Image.network(image).image;
                    showImageViewer(context, imageProvider, onViewerDismissed: () {
                      print("dismissed");
                    });

                     */
                },
              ),
              if(SizerUtil.deviceType==DeviceType.mobile)
              Padding(
                padding:  EdgeInsets.only(bottom: 8.h,left: 4.w,right: 4.w),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(onPressed: ()
                          {
                            if(AppCubit.get(context).IsFavoriteArabicImagesList.containsValue(widget.photoList.image))
                            {

                              AppCubit.get(context).deleteDataFromArabicImagePage(image:widget.photoList.image).then((value)
                              {
                                setState(() {
                                  AppCubit.get(context).getDataFromArabicImageDatabasee(AppCubit.get(context).databaseForArabicImages);
                                });
                              });

                            }
                            else
                            {
                              AppCubit.get(context).insertToDatabaseForArabicImages(image: widget.photoList.image).then((value){
                                setState(() {
                                  AppCubit.get(context).getDataFromArabicImageDatabasee(AppCubit.get(context).databaseForArabicImages);
                                });
                              });
                            }

                          }, icon: Icon(Icons.favorite,color:AppCubit.get(context).IsFavoriteArabicImagesList.containsValue(widget.photoList.image)?Colors.red:Colors.white,size: 30.sp,)),
                          SizedBox(height:translator.isDirectionRTL(context)? 0: .5.h),
                          Padding(
                            padding:  EdgeInsets.only(left: 1.w),
                            child: Text('likeButton'.tr(),style: TextStyle(color: Colors.white,fontSize:translator.isDirectionRTL(context)?13.sp :11.sp,fontFamily: 'ElMessiri')),
                          ),
                        ],
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top: 1.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(onPressed:()
                            async{
                              final urlImage =widget.photoList.image;
                              final url =Uri.parse(urlImage!);
                              final response = await http.get(url);
                              final bytes = response.bodyBytes;
                              final temp = await getTemporaryDirectory();
                              final path ='${temp.path}/image.jpg';
                              File(path).writeAsBytesSync(bytes);
                              await Share.shareFiles([path]);

                            }, icon: Icon(MdiIcons.share,color: Colors.white,size: 30.sp,)),
                            SizedBox(height:translator.isDirectionRTL(context)? 0:.5.h),
                            Padding(
                              padding:  EdgeInsets.only(left: 1.w),
                              child: Text('shareButton'.tr(),style: TextStyle(color: Colors.white,fontSize:translator.isDirectionRTL(context)?13.sp: 10.sp,fontFamily: 'ElMessiri')),
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
                            IconButton(onPressed: ()
                            async{
                              final temp = await getTemporaryDirectory();
                              final path = '${temp.path}.jpg';
                              await Dio().download(widget.photoList.image.toString(), path);
                              await GallerySaver.saveImage(path);
                              ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text('Download'.tr(),style: TextStyle(fontSize: 14.sp,color: Colors.white),),backgroundColor: Colors.green,),);

                            }, icon: Icon(MdiIcons.download,color: Colors.white,size: 30.sp,)),
                            SizedBox(height:translator.isDirectionRTL(context)? 0:.5.h),
                            Padding(
                              padding:  EdgeInsets.only(left: 2.w),
                              child: Text('downloadButton'.tr(),style: TextStyle(color: Colors.white,fontSize:translator.isDirectionRTL(context)?13.sp:10.sp,fontFamily: 'ElMessiri')),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if(SizerUtil.deviceType==DeviceType.tablet)
                Padding(
                  padding:  EdgeInsets.only(bottom: 8.h,left: 4.w,right: 4.w),
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

                              if(AppCubit.get(context).IsFavoriteArabicImagesList.containsValue(widget.photoList.image))
                              {

                                AppCubit.get(context).deleteDataFromArabicImagePage(image:widget.photoList.image).then((value)
                                {
                                  setState(() {
                                    AppCubit.get(context).getDataFromArabicImageDatabasee(AppCubit.get(context).databaseForArabicImages);
                                  });
                                });

                              }
                              else
                              {
                                AppCubit.get(context).insertToDatabaseForArabicImages(image: widget.photoList.image).then((value){
                                  setState(() {
                                    AppCubit.get(context).getDataFromArabicImageDatabasee(AppCubit.get(context).databaseForArabicImages);
                                  });
                                });
                              }

                            }, icon: Icon(Icons.favorite,color:AppCubit.get(context).IsFavoriteArabicImagesList.containsValue(widget.photoList.image)?Colors.red:Colors.white,size: 30.sp,)),
                     //       SizedBox(height:translator.isDirectionRTL(context)? 0: .5.h),
                            Padding(
                              padding:  EdgeInsets.only(left:0.w),
                              child: Text('likeButton'.tr(),style: TextStyle(color: Colors.white,fontSize:translator.isDirectionRTL(context)?13.sp :11.sp,fontFamily: 'ElMessiri')),
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
                                  onPressed:()
                              async{
                                final urlImage =widget.photoList.image;
                                final url =Uri.parse(urlImage!);
                                final response = await http.get(url);
                                final bytes = response.bodyBytes;
                                final temp = await getTemporaryDirectory();
                                final path ='${temp.path}/image.jpg';
                                File(path).writeAsBytesSync(bytes);
                                await Share.shareFiles([path]);

                              }, icon: Icon(MdiIcons.share,color: Colors.white,size: 30.sp,)),
                              SizedBox(height:translator.isDirectionRTL(context)? 0:.5.h),
                              Padding(
                                padding:  EdgeInsets.only(left: 0.w),
                                child: Text('shareButton'.tr(),style: TextStyle(color: Colors.white,fontSize:translator.isDirectionRTL(context)?13.sp: 10.sp,fontFamily: 'ElMessiri')),
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
                                final temp = await getTemporaryDirectory();
                                final path = '${temp.path}.jpg';
                                await Dio().download(widget.photoList.image.toString(), path);
                                await GallerySaver.saveImage(path);
                                ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text('Download'.tr(),style: TextStyle(fontSize: 14.sp,color: Colors.white),),backgroundColor: Colors.green,),);

                              }, icon: Icon(MdiIcons.download,color: Colors.white,size: 30.sp,)),
                              SizedBox(height:translator.isDirectionRTL(context)? 0:.5.h),
                              Padding(
                                padding:  EdgeInsets.only(left: 0.w),
                                child: Text('downloadButton'.tr(),style: TextStyle(color: Colors.white,fontSize:translator.isDirectionRTL(context)?13.sp:10.sp,fontFamily: 'ElMessiri')),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              /*
                SizedBox(height: 3.5.h),
                Container(
                  height: 12.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 3.w,),
                      Expanded(child: ScaleButton(
                        bound:.2,
                        reverse: true,
                        child: OutlinedButton(

                          style:ButtonStyle(padding:MaterialStateProperty.resolveWith(AppCubit.get(context).padding) ,overlayColor: MaterialStateProperty.resolveWith(AppCubit.get(context).getColorr) ,backgroundColor: MaterialStateProperty.resolveWith(AppCubit.get(context).getColor),) ,
                          onPressed: ()
                        async {
                          final urlImage =image;
                          final url =Uri.parse(urlImage);
                          final response = await http.get(url);
                          final bytes = response.bodyBytes;
                          final temp = await getTemporaryDirectory();
                          final path ='${temp.path}/image.jpg';
                          File(path).writeAsBytesSync(bytes);
                          await Share.shareFiles([path]);

                        }, child:  Text('Share',style: TextStyle(color: AppCubit.get(context).isDark==false?Colors.green:Colors.white)), ),
                      ),),
                      SizedBox(width: 6.w,),
                      Expanded(
                        child: ScaleButton(
                          bound:.2,
                          reverse: true,
                          child: OutlinedButton(
                            style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith(AppCubit.get(context).getColorr),

                                backgroundColor:

       AppCubit.get(context).IsFavoriteImagesList.containsValue(image)?MaterialStateProperty.all(AppCubit.get(context).isDark==false?Colors.green:Colors.green):MaterialStateProperty.all(AppCubit.get(context).isDark==false?Colors.transparent:Colors.grey[800]),
                         padding: MaterialStateProperty.resolveWith(AppCubit.get(context).padding),

                            ),
                              onPressed: ()
                          {

                            if(AppCubit.get(context).IsFavoriteImagesList.containsValue(image))
                            {
                              AppCubit.get(context).deleteDataFromImagePage(image:image );
                            }
                            else
                            {
                              AppCubit.get(context).insertToDatabase(image: image).then((value){
                                AppCubit.get(context).getDataFromImageDatabase(AppCubit.get(context).databaseForImages);
                              });
                            }

                          }, child:AppCubit.get(context).IsFavoriteImagesList.containsValue(image)? Text('Love',style: TextStyle(color:AppCubit.get(context).isDark==false?Colors.white:Colors.white),):
          Text('Love',style: TextStyle(color:AppCubit.get(context).isDark==false?Colors.green:Colors.white),),),
                        ),
                      ),
                      SizedBox(width: 6.w,),
                      Expanded(child: ScaleButton(
                        bound:.2,
                        reverse: true,
                        child: OutlinedButton(
                            style: ButtonStyle(
                              padding:  MaterialStateProperty.resolveWith(AppCubit.get(context).padding),
                              backgroundColor:MaterialStateProperty.resolveWith(AppCubit.get(context).getColor),
          overlayColor: MaterialStateProperty.resolveWith(AppCubit.get(context).getColorr),
                            ),

                            onPressed: ()
                        async {
                          final temp = await getTemporaryDirectory();
                          final path = '${temp.path}/myfile.jpg';
                          await Dio().download(image, path);
                          await GallerySaver.saveImage(path);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Downladed To Gallery')));
                        }, child:  Text('Download',style: TextStyle(color: AppCubit.get(context).isDark==false?Colors.green:Colors.white)),),
                      )),
                      SizedBox(width: 3.w,),
                    ],
                  ),
                ),


                 */
            ],
            alignment: AlignmentDirectional.bottomStart,
          ),
        );
      },
    );
  }
}