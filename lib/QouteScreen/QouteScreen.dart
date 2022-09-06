
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:like_button/like_button.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:scale_button/scale_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:statuses/AppCubit/appCubitStates.dart';
import 'package:statuses/Models/typeOfQoutes/typeOfQoutes.dart';
import 'package:statuses/QouteStyle/QouteStyle.dart';
import 'package:statuses/shared/styles/icon_broken.dart';
import '../AppCubit/appCubit.dart';


class QouteScreen extends StatefulWidget {
  var name;
  var id;

    QouteScreen( this.id,this.name, {Key? key}) : super(key: key);

  @override
  State<QouteScreen> createState() => _QouteScreenState();
}


class _QouteScreenState extends State<QouteScreen> {
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
  final _inlineAdIndex = 6;
  late BannerAd _inlineBannerAd;
  bool _isInlineBannerAdLoaded = false;
  void _createInlineBannerAd() {
    _inlineBannerAd = BannerAd(
      size: AdSize.mediumRectangle,
      adUnitId: Platform.isAndroid?'ca-app-pub-3940256099942544/6300978111':'ca-app-pub-3940256099942544/2934735716',
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isInlineBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    _inlineBannerAd.load();
  }
  int _getListViewItemIndex(int index)  {
    if (index >= _inlineAdIndex && _isInlineBannerAdLoaded) {
      return index - 1;
    }
    return index;
  }
  @override
  void initState() {
    _createInlineBannerAd();
    _createBottomBannerAd();
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    _bottomBannerAd.dispose();
    _inlineBannerAd.dispose();
  }
   @override
   Widget build(BuildContext context) {
     return BlocConsumer<AppCubit,AppCubitStates>(
       listener: (BuildContext context, state) {  },
       builder: (BuildContext context, Object? state) {
         return Scaffold(
           appBar: AppBar(
             toolbarHeight: 7.6.h,
             titleSpacing: 0,
             title: SizerUtil.deviceType==DeviceType.mobile?Text('${widget.name}',style: TextStyle(color: Colors.white,fontSize: 16.sp,fontWeight: FontWeight.w600,fontFamily:translator.isDirectionRTL(context)?'ElMessiri':'VarelaRound',),)
                 :Padding(
                   padding: EdgeInsets.only(left: 0.w),
                   child: Text('${widget.name}',style: TextStyle(color: Colors.white,fontSize: 15.5.sp,fontWeight: FontWeight.w600,fontFamily:translator.isDirectionRTL(context)?'ElMessiri':'VarelaRound',),),
                 ),
             leadingWidth: 14.2.w,
             leading:IconButton(
               icon:  Icon(
                 translator.isDirectionRTL(context)?IconBroken.Arrow___Right:IconBroken.Arrow___Left,
                 color: Colors.white,
                 size: 18.sp,
               ),
               onPressed: () async {
                 Navigator.pop(context);
               },
             ),
           ),

           body: translator.isDirectionRTL(context)?StreamBuilder<QuerySnapshot>(
             stream: AppCubit.get(context).GetArabicQoutesFromTypeOfQoutes(widget.id),
             builder: (context, snapshot) {
               if (!snapshot.hasData) {
                 return const Center(child: CircularProgressIndicator());
               } else {
                 //   List<TypeOfQoutesModel> Qoutes = [];
                 AppCubit.get(context).ArabicTypeOfQuotesList=[];
                 for (var doc in snapshot.data!.docs) {

                   AppCubit.get(context).ArabicTypeOfQuotesList.add(TypeOfQoutesModel(Qoute:doc['quote'],));
                 }
                 return ConditionalBuilder(
                   condition: AppCubit.get(context).ArabicTypeOfQuotesList.length>0,
                   builder: (BuildContext context) => Container(
                       child: ListView.separated(
                         itemBuilder: (context, index) => BuilViewForArabicQoutes(context,AppCubit.get(context).ArabicTypeOfQuotesList[index],index),
                         itemCount: AppCubit.get(context).ArabicTypeOfQuotesList.length,
                         separatorBuilder: (BuildContext context, int index)
                         {
                           if (index == 5 && _isInlineBannerAdLoaded ) {
                             return Container(
                               padding: EdgeInsets.only(
                                 bottom: 0,
                               ),
                               width: _inlineBannerAd.size.width.toDouble(),
                               height: _inlineBannerAd.size.height.toDouble(),
                               child: AdWidget(ad: _inlineBannerAd),
                             );
                           }
                           else {
                             return Container(height: 0,);
                           }
                         },

                       )),
                   fallback: (BuildContext context) => const Center(child: CircularProgressIndicator()),
                 );
               }
             },
           ):
           StreamBuilder<QuerySnapshot>(
             stream: AppCubit.get(context).GetQoutesFromTypeOfQoutes(widget.id),
             builder: (context, snapshot) {
               if (!snapshot.hasData) {
                 return const Center(child: CircularProgressIndicator());
               } else {
              //   List<TypeOfQoutesModel> Qoutes = [];
                 AppCubit.get(context).Quotes=[];
                 for (var doc in snapshot.data!.docs) {
                   AppCubit.get(context).Quotes.add(TypeOfQoutesModel(Qoute:doc['quote'],));
                 }
                 return ConditionalBuilder(
                   condition: AppCubit.get(context).Quotes.length>0,
                   builder: (BuildContext context) => Container(
                       child: ListView.separated(
                         /*
                         itemBuilder: (context, index) => BuilViewForQoute(context,AppCubit.get(context).Quotes[index],index),

                          */
                         itemCount:  AppCubit.get(context).Quotes.length,
                         separatorBuilder: (BuildContext context, int index)
                         {
                           if (index == 5&&_isInlineBannerAdLoaded ) {
                             return Container(
                               padding: EdgeInsets.only(
                                 bottom: 0,
                               ),
                               width: _inlineBannerAd.size.width.toDouble(),
                               height: _inlineBannerAd.size.height.toDouble(),
                               child: AdWidget(ad: _inlineBannerAd),
                             );
                           }
                           else {
                             return Container(height: 0,);
                           }
                         },
                        itemBuilder: (context,index)
                        {
                          return BuilViewForQoute(context,AppCubit.get(context).Quotes[index],index);
                        },
                         /*
                         separatorBuilder: (BuildContext context, int index)
                       {
                           if (index % 2 == 0&&index!=0) {
                             return AppCubit.get(context).getAd();
                           }
                           else {
                             return Container();
                           }
                       },

                          */
                       )),
                   fallback: (BuildContext context) => Center(child: Text('No Quotes..',style: TextStyle(fontSize: 20.sp,fontFamily:'VarelaRound',fontWeight: FontWeight.w400),)),
                 );
               }
             },
           ),

           bottomNavigationBar: _isBottomBannerAdLoaded
               ? Container(
             color: AppCubit.get(context).isDark?Colors.black:Colors.white,
             height: _bottomBannerAd.size.height.toDouble(),
             width: _bottomBannerAd.size.width.toDouble(),
             child: AdWidget(ad: _bottomBannerAd),
           )
               : null,
         );
       },

     );
   }
}
 class BuilViewForQoute extends StatefulWidget {
  TypeOfQoutesModel qout;
  int index;
    BuilViewForQoute(BuildContext context, TypeOfQoutesModel this.qout, int this.index, {Key? key}) : super(key: key);

  @override
  State<BuilViewForQoute> createState() => _BuilViewForQouteState();
}


class _BuilViewForQouteState extends State<BuilViewForQoute> {

  bool isLiked =false;
  Future<bool> onLikeButtonTapped(bool isLiked,) async{

    if(AppCubit.get(context).IsFavoriteQuotesList.containsValue(widget.qout.Qoute))
    {
      AppCubit.get(context).deleteeData(quote:widget.qout.Qoute ).then((value)
      {
        setState(() {
          AppCubit.get(context).getDataFromQuotesDatabase(AppCubit.get(context).databaseForQuotes);
        });
      });
    }
    else
    {
      AppCubit.get(context).insertToDatabaseForQuotes(quote: widget.qout.Qoute).then((value){
        setState(() {
          AppCubit.get(context).getDataFromQuotesDatabase(AppCubit.get(context).databaseForQuotes);
      });});
    }

    return !isLiked;
  }


   @override
   Widget build(BuildContext context) {
     return BlocConsumer<AppCubit,AppCubitStates>(
       listener: (BuildContext context, state) {  },
       builder: (BuildContext context, Object? state) {
         return ScaleButton(
           bound: .1,
           reverse: false,
           child: Padding(
             padding:  EdgeInsets.all(1.1.h),
             child:Container(
               //    width: double.infinity,
               //    height: 22.h,
               decoration: BoxDecoration(
                 //  ${AppCubit.get(context).Images[AppCubit.get(context).change]}
                 color:AppCubit.get(context).isDark==false?Colors.white:Colors.black,
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
                     onTap: ()
                     async{
                       AppCubit.get(context).change=0;
                       AppCubit.get(context).changeText=0;
                       if(AppCubit.get(context).interstialadCount==5)
                       {
                         AppCubit.get(context).showInterstialAd();
                       }
                       else if(AppCubit.get(context).interstialadCount==0) {
                         AppCubit.get(context).loadInterstialAd();
                       }
                       AppCubit.get(context).adCount();
                       Navigator.push(context, MaterialPageRoute(builder: (context) => QouteStyle('${widget.qout.Qoute}',widget.index),
                         ),
                       );
                     },
                     child: Padding(
                       padding:  EdgeInsets.all(4.h),
                       child: Text(
                         '${widget.qout.Qoute}',
                         textAlign: TextAlign.center,
                         style: TextStyle(
                       //      height: 1.2.sp,
                               height:AppCubit.get(context).GetDeviceType(),
                             color: AppCubit.get(context).isDark==false?Colors.grey[700]:Colors.white,
                             fontFamily: 'VarelaRound',
                         //    fontSize: 14.3.sp,
                             fontSize: 15.sp,
                             fontWeight: FontWeight.w600),
                       ),
                     ),
                   ),
                   Container(
                     padding: EdgeInsets.zero,
                       height: 7.h,
                     width: double.infinity,
                     color:AppCubit.get(context).isDark==false?Colors.grey[300]:Colors.grey[900],
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
                               onPressed: ()
                               async{
                                 final data = ClipboardData(text: '${widget.qout.Qoute}');
                                 Clipboard.setData(data);
                                 Fluttertoast.showToast(msg: 'Copy'.tr(),gravity: ToastGravity.CENTER,fontSize:SizerUtil.deviceType == DeviceType.mobile?12.sp:5.sp);
                               },
                               padding: EdgeInsets.zero,
                               icon:  Icon(
                                 MdiIcons.contentCopy,
                                 color: AppCubit.get(context).isDark?Colors.grey:Colors.green,
                               )),
                           if(SizerUtil.deviceType==DeviceType.mobile)
                           SizedBox(width:1.w,),
                           if(SizerUtil.deviceType==DeviceType.tablet)
                             SizedBox(width:4.w,),
                           IconButton(
                               splashColor: Colors.transparent,
                               highlightColor: Colors.transparent,
                               iconSize: 20.sp,
                               splashRadius: 26.sp,
                               onPressed: () async{
                                 Clipboard.setData(const ClipboardData());
                                 Share.share('${widget.qout.Qoute}');
                               },
                               padding: EdgeInsets.zero,
                               icon:  Icon(
                                 MdiIcons.shareVariant,
                                 color: AppCubit.get(context).isDark?Colors.grey:Colors.green,
                               )),
                           SizedBox(width: 3.2.w,),
                           /*
                             IconButton(
                                 key: Key('${widget.index}'),
                                 iconSize: 20.sp,
                                 splashRadius: 26.sp,
                                 splashColor: Colors.grey,
                                 onPressed: ()
                                 async{
                                   if(AppCubit.get(context).IsFavoriteList.containsValue(widget.qout.Qoute))
                                      {
                                     AppCubit.get(context).deleteeData(qoute: widget.qout.Qoute).then((value)
                                     {
                                       Fluttertoast.showToast(msg: 'Deleted from favorites',gravity: ToastGravity.CENTER,backgroundColor: Colors.red);
                                       setState(() {

                                       });
                                     });
                                   }
                                   else
                                      {
                                         AppCubit.get(context).insertToDatabase(qoute: widget.qout.Qoute).then((value)
                                        {
                                         Fluttertoast.showToast(msg: 'Added Successfully to favorites',gravity: ToastGravity.CENTER);
                                         setState(() {

                                         });
                                       });

                                     }
                                 },
                                 padding: EdgeInsets.zero,
                                 icon: Icon(AppCubit.get(context).function(widget.qout.Qoute)? Icons.favorite_outline:Icons.favorite,
                                   color: Colors.green,
                                 )),

                              */
                           LikeButton(
                             size: 20.sp,
                             circleColor:
                              CircleColor(start: AppCubit.get(context).isDark==false?Colors.green:Colors.grey, end: AppCubit.get(context).isDark==false?Colors.green:Colors.grey,),
                             bubblesColor:   BubblesColor(
                               dotPrimaryColor:AppCubit.get(context).isDark==false?Colors.green:Colors.white,
                               dotSecondaryColor: AppCubit.get(context).isDark==false?Colors.green:Colors.white,
                               dotLastColor: AppCubit.get(context).isDark==false?Colors.green:Colors.white,
                               dotThirdColor:AppCubit.get(context).isDark==false?Colors.green:Colors.white,
                             ),
                             onTap: onLikeButtonTapped,
                             isLiked: isLiked,
                             likeBuilder: ( isLiked) {
                               if(AppCubit.get(context).isDark)
                                 return Icon(
                                   AppCubit.get(context).function(widget.qout.Qoute)? Icons.favorite_outline:Icons.favorite,
                                   color: isLiked ? Colors.grey : Colors.grey,
                                   size: 20.sp,
                                 );
                               else
                               return Icon(
                                 AppCubit.get(context).function(widget.qout.Qoute)? Icons.favorite_outline:Icons.favorite,
                                 color: isLiked ? Colors.green : Colors.green,
                                 size: 20.sp,
                               );
                             },
                           ),
                         ],
                       ),
                     ),
                   ),
                 ],
               ),
             ),
           ),
         );
       },
     );
   }
}
///اقتباسات عربي

class BuilViewForArabicQoutes extends StatefulWidget {
  TypeOfQoutesModel qout;
  int index;
  BuilViewForArabicQoutes(BuildContext context, TypeOfQoutesModel this.qout, int this.index, {Key? key}) : super(key: key);

  @override
  State<BuilViewForArabicQoutes> createState() => _BuilViewForArabicQoutesState();
}


class _BuilViewForArabicQoutesState extends State<BuilViewForArabicQoutes> {

  bool isLiked =false;
  Future<bool> onLikeButtonTapped(bool isLiked,) async{

    if(AppCubit.get(context).IsFavoriteArabicQuotesList.containsValue(widget.qout.Qoute))
    {
      AppCubit.get(context).deleteeDataForArabic(quote:widget.qout.Qoute ).then((value)
      {
        setState(() {
          AppCubit.get(context).getDataFromArabicQuotesDatabase(AppCubit.get(context).databaseForArabicQuotes);
        });
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
      AppCubit.get(context).insertToDatabaseForArabicQuotes(quote: widget.qout.Qoute).then((value){
        setState(() {
          AppCubit.get(context).getDataFromArabicQuotesDatabase(AppCubit.get(context).databaseForArabicQuotes);
        });});
    }

    return !isLiked;
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppCubitStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        return ScaleButton(
          bound: .1,
          reverse: false,
          child: Padding(
            padding:  EdgeInsets.all(1.1.h),
            child:Container(
              //    width: double.infinity,
              //    height: 22.h,
              decoration: BoxDecoration(
                //  ${AppCubit.get(context).Images[AppCubit.get(context).change]}
                color:AppCubit.get(context).isDark==false?Colors.white:Colors.black,
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
                    onTap: ()
                    async{
                      AppCubit.get(context).change=0;
                      AppCubit.get(context).changeArabicText =0;
                      if(AppCubit.get(context).interstialadCount==5)
                      {
                        AppCubit.get(context).showInterstialAd();
                      }
                      else if(AppCubit.get(context).interstialadCount==0) {
                        AppCubit.get(context).loadInterstialAd();
                      }
                      AppCubit.get(context).adCount();
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => QouteStyle('${widget.qout.Qoute}',widget.index),
                        ),
                      );
                    },
                    child: Padding(
                      padding:  EdgeInsets.all(4.h),
                      child: Text(
                        '${widget.qout.Qoute}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          //      height: 1.2.sp,
                            height:SizerUtil.deviceType==DeviceType.mobile?1.1.sp:0.sp,
                            color: AppCubit.get(context).isDark==false?Colors.grey[700]:Colors.white,
                            fontFamily:'ElMessiri',
                            //    fontSize: 14.3.sp,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.zero,
                    height: 7.h,
                    width: double.infinity,
                    color:AppCubit.get(context).isDark==false?Colors.grey[300]:Colors.grey[900],
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
                              onPressed: ()
                              async{
                                final data = ClipboardData(text: '${widget.qout.Qoute}');
                                Clipboard.setData(data);
                                Fluttertoast.showToast(msg:'Copy'.tr(),gravity: ToastGravity.CENTER,fontSize:SizerUtil.deviceType==DeviceType.mobile?12.sp:6.sp);

                              },
                              padding: EdgeInsets.zero,
                              icon:  Icon(
                                MdiIcons.contentCopy,
                                color: AppCubit.get(context).isDark?Colors.grey:Colors.green,
                              )),
                          if(SizerUtil.deviceType==DeviceType.mobile)
                            SizedBox(width:1.w,),
                          if(SizerUtil.deviceType==DeviceType.tablet)
                            SizedBox(width:4.w,),
                          IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              iconSize: 20.sp,
                              splashRadius: 26.sp,
                              onPressed: () async{
                                Clipboard.setData(const ClipboardData());
                                Share.share('${widget.qout.Qoute}');
                              },
                              padding: EdgeInsets.zero,
                              icon:  Icon(
                                MdiIcons.shareVariant,
                                color: AppCubit.get(context).isDark?Colors.grey:Colors.green,
                              )),
                          SizedBox(width: 3.2.w,),
                          /*
                             IconButton(
                                 key: Key('${widget.index}'),
                                 iconSize: 20.sp,
                                 splashRadius: 26.sp,
                                 splashColor: Colors.grey,
                                 onPressed: ()
                                 async{
                                   if(AppCubit.get(context).IsFavoriteList.containsValue(widget.qout.Qoute))
                                      {
                                     AppCubit.get(context).deleteeData(qoute: widget.qout.Qoute).then((value)
                                     {
                                       Fluttertoast.showToast(msg: 'Deleted from favorites',gravity: ToastGravity.CENTER,backgroundColor: Colors.red);
                                       setState(() {

                                       });
                                     });
                                   }
                                   else
                                      {
                                         AppCubit.get(context).insertToDatabase(qoute: widget.qout.Qoute).then((value)
                                        {
                                         Fluttertoast.showToast(msg: 'Added Successfully to favorites',gravity: ToastGravity.CENTER);
                                         setState(() {

                                         });
                                       });

                                     }
                                 },
                                 padding: EdgeInsets.zero,
                                 icon: Icon(AppCubit.get(context).function(widget.qout.Qoute)? Icons.favorite_outline:Icons.favorite,
                                   color: Colors.green,
                                 )),

                              */
                          LikeButton(
                            size: 20.sp,
                            circleColor:
                            CircleColor(start: AppCubit.get(context).isDark==false?Colors.green:Colors.grey, end: AppCubit.get(context).isDark==false?Colors.green:Colors.grey,),
                            bubblesColor:   BubblesColor(
                              dotPrimaryColor:AppCubit.get(context).isDark==false?Colors.green:Colors.white,
                              dotSecondaryColor: AppCubit.get(context).isDark==false?Colors.green:Colors.white,
                              dotLastColor: AppCubit.get(context).isDark==false?Colors.green:Colors.white,
                              dotThirdColor:AppCubit.get(context).isDark==false?Colors.green:Colors.white,
                            ),
                            onTap: onLikeButtonTapped,
                            isLiked: isLiked,
                            likeBuilder: ( isLiked) {
                              if(AppCubit.get(context).isDark)
                                return Icon(
                                  AppCubit.get(context).functionForArabic(widget.qout.Qoute)? Icons.favorite_outline:Icons.favorite,
                                  color: isLiked ? Colors.grey : Colors.grey,
                                  size: 20.sp,
                                );
                              else
                                return Icon(
                                  AppCubit.get(context).functionForArabic(widget.qout.Qoute)? Icons.favorite_outline:Icons.favorite,
                                  color: isLiked ? Colors.green : Colors.green,
                                  size: 20.sp,
                                );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

///اقتباسات عربي
 /*
 Widget BuilViewForQoute(context, TypeOfQoutesModel qout, int index)
 {

   return Padding(
     padding: const EdgeInsets.all(8.0),
     child: InkWell(
       onTap: ()
       {
         Navigator.push(
           context,
           MaterialPageRoute(
             builder: (context) => QouteStyle('${qout.Qoute}'),
           ),
         );

       },
       child: Container(
         //    width: double.infinity,
         //    height: 22.h,

         decoration: BoxDecoration(
           //  ${AppCubit.get(context).Images[AppCubit.get(context).change]}
           color: Colors.white,
           boxShadow: [
             BoxShadow(
               offset: const Offset(0, 1),
               blurRadius: 5,
               color: Colors.black.withOpacity(0.3),
             ),
           ],
           borderRadius: BorderRadius.circular(8),
         ),

         child: Column(
           children: [
             Padding(
               padding: const EdgeInsets.all(35.0),
               child: Text(
                 '${qout.Qoute}',
                 textAlign: TextAlign.center,
                 style: TextStyle(
                     height: 1.3.sp,
                     color: Colors.black,
                     //     color: Colors.grey[700],
                     fontSize: 16.sp,
                     fontWeight: FontWeight.w400),
               ),
             ),
             Container(
               padding: EdgeInsets.zero,
               //  height: 7.h,
               width: double.infinity,
               color: Colors.grey[300],
               alignment: Alignment.center,
               child: Center(
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     IconButton(
                         iconSize: 20.sp,
                         splashRadius: 26.sp,
                         splashColor: Colors.grey,
                         onPressed: ()
                         {
                           final data = ClipboardData(text: '${qout.Qoute}');
                           Clipboard.setData(data);
                           Fluttertoast.showToast(msg: 'copied to clipboard',gravity: ToastGravity.CENTER);
                         },
                         padding: EdgeInsets.zero,
                         icon: Icon(
                           MdiIcons.contentCopy,
                           color: Colors.green,
                         )),
                     SizedBox(width: 5.w,),
                     IconButton(
                         iconSize: 20.sp,
                         splashRadius: 26.sp,
                         splashColor: Colors.grey,
                         onPressed: () {
                           Share.share('${qout.Qoute}');
                         },
                         padding: EdgeInsets.zero,
                         icon: Icon(
                           MdiIcons.shareVariant,
                           color: Colors.green,
                         )),
                     SizedBox(width: 5.w,),
                     IconButton(
                       key: Key('${index}'),
                         iconSize: 20.sp,
                         splashRadius: 26.sp,
                         splashColor: Colors.grey,
                         onPressed: ()
                         {
                         AppCubit.get(context).insertToDatabase(qoute: qout.Qoute);
                         Fluttertoast.showToast(msg: 'Added Successfully to favorites',gravity: ToastGravity.CENTER);
                         },
                         padding: EdgeInsets.zero,
                         icon: Icon(AppCubit.get(context).IsFavoriteList.containsValue(qout.Qoute)? Icons.favorite:Icons.favorite_outline,
                           color: Colors.green,
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
 }

  */

