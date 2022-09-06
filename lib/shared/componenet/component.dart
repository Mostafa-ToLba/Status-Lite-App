import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:statuses/shared/styles/icon_broken.dart';

Widget defultButton({
  required Color? backGround,
  required double? width,
  required var function,
  String text = '',
  required height,
}) =>
    Container(
      height: height,
      color: backGround,
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(text.toUpperCase(),
            style: const TextStyle(
              fontSize: 17.0,
              color: Colors.white,
            )),
      ),
    );

Widget defultformfield({
  TextEditingController? controle,
  var onfieldsubmite,
  var validate,
  var onchange,
  var ontap,
  TextInputType? keyboard,
  String? label,
  IconData? prefix,
  IconData? suffix,
  bool isPassword = false,
  var suffixPressed,
  var textStyle,
  var contentPadding,
}) =>
    TextFormField(
      controller: controle,
      strutStyle: StrutStyle(
        height: 1,
      ),
      onFieldSubmitted: onfieldsubmite,
      onTap: ontap,
      validator: validate,
      onChanged: onchange,
      keyboardType: keyboard,
      obscureText: isPassword,
      style: textStyle,
      decoration: InputDecoration(
          //  fillColor: HexColor('F6F6F6'),
          //   filled: true,

          contentPadding: contentPadding,
          prefixIcon: Icon(
            prefix,
            color: Colors.grey,
            size: 18.5.sp,
          ),
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: suffixPressed,
                  icon: Icon(
                    suffix,
                    color: Colors.grey,
                    size: 16.sp,
                  ),
                )
              : null,
          label: Text(
            label!,
            style: textStyle,
          ),
          border: OutlineInputBorder()),
    );

void NavigateTo(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
    );

dynamic NavigateAndFinsh(context, dynamic) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => dynamic,
    ),
    (route) => false);

Widget ss() => Container(
      color: Colors.green,
      height: 200,
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: IconButton(
                      onPressed: () {
//scaffoldkey.currentState!.openDrawer();
                      },
                      icon: Icon(
                        IconBroken.Home,
                        color: Colors.white,
                      ))),
              Padding(
                padding: const EdgeInsets.only(top: 60, left: 10),
                child: Text(
                  'Statuses Lite',
                  style: TextStyle(fontSize: 35, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60, left: 20),
                child: IconButton(
                  splashColor: Colors.white,
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: Icon(IconBroken.Notification),
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 60,
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: Icon(IconBroken.Search),
                  color: Colors.white,
                ),
              )
            ],
          ),
          SizedBox(
            height: 14,
          ),
          TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                text: 'Images',
                icon: Icon(IconBroken.Image),
              ),
              Tab(
                text: 'Videos',
                icon: Icon(IconBroken.Video),
              ),
              Tab(
                text: 'Qoutes',
                icon: Icon(IconBroken.Edit),
              ),
            ],
          ),
          TabBarView(children: [
            Text('tab1'),
            Text('tab2'),
            Text('tab3'),
            Text('ds'),
          ])
        ],
      ),
    );

