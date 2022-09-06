import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:statuses/AppCubit/appCubit.dart';
import 'package:statuses/AppCubit/appCubitStates.dart';
import 'package:statuses/Models/typeOfQoutes/typeOfQoutes.dart';
import 'package:statuses/newWidget/NewWidget.dart';
import 'package:statuses/shared/componenet/component.dart';
import 'package:statuses/shared/styles/icon_broken.dart';
import 'package:video_player/video_player.dart';
import 'package:share_plus/share_plus.dart';

class QoutesScreen extends StatefulWidget {
  var id;
  var name;
   QoutesScreen( this.id,  this.name, {Key? key}) : super(key: key);

  @override
  State<QoutesScreen> createState() => _QoutesScreenState();
}

class _QoutesScreenState extends State<QoutesScreen> {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppCubitStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        AppCubit.get(context).getImages();
        return Scaffold(
          appBar: AppBar(
            title: Text('${widget.name}',style: TextStyle(color: Colors.white,fontSize: 17.sp,fontWeight: FontWeight.w400,fontFamily: 'MyriadPro'),),
            actions:
            [
              IconButton(onPressed: (){}, icon: Icon(IconBroken.Search,color: Colors.white,))
            ],
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
          body: StreamBuilder<QuerySnapshot>(
            stream: AppCubit.get(context).GetQoutesFromTypeOfQoutes(widget.id),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(child: Text('there is no Qoutes',style: TextStyle(fontSize: 17.sp,fontWeight: FontWeight.w400,fontFamily: 'MyriadPro'),));
              else {
                List<TypeOfQoutesModel> Qoutes = [];
                for (var doc in snapshot.data!.docs) {

                  Qoutes.add(TypeOfQoutesModel(Qoute:doc['quote'],));
                }
                return ConditionalBuilder(
                  condition: Qoutes.length>0,
                  builder: (BuildContext context) => Container(
                      child: ListView.builder(
                        itemBuilder: (context, index) => BuilViewForQoute(context,Qoutes[index],index),
                        itemCount: Qoutes.length,
                      )),
                  fallback: (BuildContext context) => Center(child: CircularProgressIndicator()),
                );
              }
            },
          ),

        );
      },

    );
  }
}

Widget BuilViewForQoutes(BuildContext context) => Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          // height: 16.h,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'While you are hating your life just because you cannot get what you want, someone is praying to have a life like yours',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'MyriadPro',
                  color: Colors.grey[700],
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.zero,
          height: 7.h,
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
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      MdiIcons.contentCopy,
                      color: Colors.green[500],
                    )),
                IconButton(
                    iconSize: 20.sp,
                    splashRadius: 26.sp,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      MdiIcons.share,
                      color: Colors.green[500],
                    )),
                IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    iconSize: 20.sp,
                    splashRadius: 26.sp,
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      MdiIcons.delete,
                      color: Colors.green[500],
                    )),
                IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    iconSize: 20.sp,
                    splashRadius: 26.sp,
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.green[500],
                    )),
              ],
            ),
          ),
        ),
      ],
    );
Widget BuilViewForQoute(BuildContext context, TypeOfQoutesModel qout,index)
{
  int a=0 ;
 // AudioPlayer audioPlayer = AudioPlayer();
  // audioPlayer.setUrl('https://assets.mixkit.co/sfx/download/mixkit-plastic-bubble-click-1124.wav'); // prepare the player with this audio but do not start playing
  // audioPlayer.setReleaseMode(ReleaseMode.STOP);
  return Padding(
    padding: const EdgeInsets.all(8.0),
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
         NavigateTo(context, NewScreen(qout.Qoute!));
     //  AppCubit.get(context).ChangePhoto();
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
                          final data = ClipboardData(text: qout.Qoute);
                          Clipboard.setData(data);
                          Fluttertoast.showToast(msg: 'copied to clipboard',gravity: ToastGravity.CENTER);
                        },
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          MdiIcons.contentCopy,
                          color: Colors.green[500],
                        )),
                    SizedBox(width: 2.w,),
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
                          color: Colors.green[500],
                        )),
                    SizedBox(width: 2.w,),
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
