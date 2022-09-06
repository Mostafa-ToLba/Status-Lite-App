
 import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:statuses/AppCubit/appCubit.dart';
import 'package:statuses/AppCubit/appCubitStates.dart';
import 'package:statuses/shared/styles/icon_broken.dart';

class NewScreen extends StatelessWidget {
  String qoute;
  File? _imageFile;

  GlobalKey previewContainer = new GlobalKey();
  ScreenshotController screenshotController = ScreenshotController();
  NewScreen(String this.qoute, {Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     return BlocConsumer<AppCubit,AppCubitStates>(
       listener: (BuildContext context, state) {  },
       builder: (BuildContext context, Object? state) {
         return  AnnotatedRegion<SystemUiOverlayStyle>(
           value: SystemUiOverlayStyle(
             statusBarColor: Colors.transparent,
             statusBarIconBrightness:  Brightness.light,
           ),
           child: Scaffold(
             /*
             appBar: AppBar(
               leading: IconButton(
                 icon: Icon(
                   IconBroken.Arrow___Left,
                   color: Colors.white,
                 ),
                 onPressed: () {
                   Navigator.pop(context);
                 },
               ),
             ),

              */
             body: Column(
               children: [
                 Expanded(
                   child: RepaintBoundary(
                     key:previewContainer ,
                     child: Container(

                       decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover,image: NetworkImage(AppCubit.get(context).Images[AppCubit.get(context).change])),),
                       child: InkWell(
                         onTap: ()
                         {
                           //     audioPlayer.resume();
                           //    play() async {
                           //     int result = await audioPlayer.play('https://assets.mixkit.co/sfx/download/mixkit-plastic-bubble-click-1124.wav');
                           //    if (result == 1) {
                           // success
                           //     }
                           //   }
                           //  AppCubit.get(context).ChangePhoto();
                           AppCubit.get(context).ChangePhoto();
                         },
                         child: Column(
                           mainAxisSize: MainAxisSize.max,
                           children: [
                             Container(height: 34.h,),
                             Center(
                               child: Padding(
                               padding: const EdgeInsets.all(35.0),
                               child: Center(
                               child: Text(
                               '${qoute}',
                               textAlign: TextAlign.center,
                               style: TextStyle(
                                   height: 1.3.sp,
                                   color: Colors.white,
                                   //     color: Colors.grey[700],
                                   fontSize: 18.sp,
                                   fontWeight: FontWeight.w500),
                               ),
                               ),
                       ),
                             ),
                             Spacer(),
                           ],
                         ),
                       ),
                     ),
                   ),
                 ),
                 Container(
                   padding: EdgeInsets.zero,
                   //  height: 7.h,
                   width: double.infinity,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8),bottomRight: Radius.circular(8)),
                     color: Colors.grey[300],
                   ),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.end,
                     children: [
                       IconButton(
                           iconSize: 20.sp,
                           splashRadius: 26.sp,
                           splashColor: Colors.grey,
                           onPressed: () {
                             final data = ClipboardData(text: qoute);
                             Clipboard.setData(data);
                             Fluttertoast.showToast(msg: 'copied to clipboard',gravity: ToastGravity.CENTER);
                           },
                           padding: EdgeInsets.zero,
                           icon: Icon(
                             MdiIcons.contentCopy,
                             color: Colors.green[500],
                           )),
                       SizedBox(width: 6.w,),
                       IconButton(
                           iconSize: 20.sp,
                           splashRadius: 26.sp,
                           splashColor: Colors.grey,
                           onPressed: ()
                           {
                             ShareFilesAndScreenshotWidgets().shareScreenshot(
                               previewContainer,
                               1000,
                               "Title",
                               "Name.png",
                               "image/png",
                             );
                           },
                           padding: EdgeInsets.zero,
                           icon: Icon(
                             MdiIcons.shareVariant,
                             color: Colors.green[500],
                           )),
                       SizedBox(width: 6.w,),
                       IconButton(
                           iconSize: 20.sp,
                           splashRadius: 26.sp,
                           splashColor: Colors.grey,
                           onPressed: () {},
                           padding: EdgeInsets.zero,
                           icon: Icon(
                             Icons.favorite,
                             color: Colors.green[500],
                           )),
                       SizedBox(width: 6.w,),
                       IconButton(
                           iconSize: 20.sp,
                           splashRadius: 26.sp,
                           splashColor: Colors.grey,
                           onPressed: () {
                             AppCubit.get(context).ChangePhoto();
                           },
                           padding: EdgeInsets.zero,
                           icon: Icon(
                             Icons.edit,
                             color: Colors.green[500],
                           )),
                     ],
                   ),
                 ),
               ],
             ),
           ),
         );
       },
     );
   }
 }
