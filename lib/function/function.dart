

 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statuses/AppCubit/appCubitStates.dart';

import '../AppCubit/appCubit.dart';

class Function extends StatefulWidget {
   const Function({Key? key}) : super(key: key);

   @override
   _FunctionState createState() => _FunctionState();
 }

 class _FunctionState extends State<Function> {

   @override
   Widget build(BuildContext context) {
     return BlocConsumer<AppCubit,AppCubitStates>(listener: (BuildContext context, state) {  },
     builder: (BuildContext context, Object? state) {
       return Container();
     },
     );}
 }
