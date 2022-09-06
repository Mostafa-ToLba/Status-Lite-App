
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:statuses/AppCubit/appCubit.dart';
import 'package:statuses/Models/Qoute%20Model/qouteModel.dart';
import 'package:statuses/Models/photoModel/photoModel.dart';
import 'package:statuses/Models/typeOfQoutes/typeOfQoutes.dart';
import 'package:statuses/Models/videoModel/videoModel.dart';
import 'package:statuses/shared/local/cashe_helper.dart';
import 'package:video_player/video_player.dart';

import 'appCubitStates.dart';

class AppCubit extends Cubit<AppCubitStates> {
  static BuildContext? context;

  AppCubit(AppCubitStates InitialAppCubitState) : super(InitialAppCubitState);

  static AppCubit get(context) => BlocProvider.of(context);

  Stream<QuerySnapshot> GetPhotoes() {
    return FirebaseFirestore.instance.collection('Photoes').orderBy("time", descending: true).snapshots();
  }

  List<VideoModel> video = [];

  Stream<QuerySnapshot> GetVideos() {
/*
    ftechedVideos.forEach(( element) {
      video.add(VideoModel.fromJson(element));
    });

 */
    return FirebaseFirestore.instance.collection('videos').orderBy("time", descending: true).snapshots();
  }

  bool loaded = false;

// //  VideoPlayerController? networkController;
//   late VideoPlayerController controller;
//   // https://flutter.github.io/Assets-for-api-docs/Assets/videos/bee.mp4
//   void initState(url) {
//     controller = VideoPlayerController.network('${url}')
//       ..initialize().then((_) {
//         // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
//         emit(InititStateForVideos());
//       });
//   }

  Stream<QuerySnapshot> GetQoutes() {
    return FirebaseFirestore.instance.collection('quotes').orderBy('time',descending: true).snapshots();
  }

  Stream<QuerySnapshot> GetNumberOfQoutes(String id) {
    return FirebaseFirestore.instance.collection('quotes').doc(id).collection(
        'getQuotes').snapshots();
  }


  Stream<QuerySnapshot> GetQoutesFromTypeOfQoutes(id) {
    return FirebaseFirestore.instance.collection('quotes').doc(id).collection(
        'getQuotes').orderBy('time',descending: true).snapshots();
  }

  int? Message;

  GetMasseges(id) {
    FirebaseFirestore.instance.collection('quotes').doc(id).collection(
        'getQuotes').get().then((value) {
      Message = value.docs.length;
      // emit(GetMessageState());
    });
  }

  late VideoPlayerController videoPlayerController;

  Future initalizePlayer(videoUrl) async {
    videoPlayerController = VideoPlayerController.network('');
    videoPlayerController = VideoPlayerController.network(videoUrl.toString());
    Future.wait([videoPlayerController.initialize()]);
    //    emit(InititStateForVideos());
  }

  List<VideoPlayerController>videoController = [];


  List<String>Images = [];
  List<int>IndexOfImage = [];
  int change = 0;
  var photo;

  var thabt = 0;

  Future getImages() async {
    await FirebaseFirestore.instance.collection('Images').get().then((value) {
      value.docs.forEach((element) {
        Images.add(element['image']);
      });
    }).then((value) {
      emit(GetImagesState());
    });
  }


  ChangePhoto() {
    if (change == 12) {
      change = 0;
    } else {
      change++;
    }
  }


  ChangeePhoto(index) {
    index++;
    return index;
  }


  List<VideoModel>videoList = [];

  LoadFrame(url) {
    videoPlayerController = VideoPlayerController.network(url);
    //  if(!AppCubit.get(context).videoPlayerController.value.isInitialized)
    Future.wait({AppCubit
        .get(context)
        .videoPlayerController
        .initialize()});
  }

  eee(image, index, context) {
    print(image);
    print(index);
    if (image == AppCubit
        .get(context)
        .Images[0])
      return index = 1;
    emit(ChangeImagesState());
    print(index);
    return index = 1;
    AppCubit.get(context).ChangePhoto();
  }


  var prograss;
  double ss = 0;
  double progresss = 0;

  List<AssetImage> Photoess = [];

  AddPhotoesToList() {
    Photoess = [
      const AssetImage('Assets/images/green.jpg',),
      const AssetImage('Assets/images/1.jpg',),
      const AssetImage('Assets/images/2.jpg'),
      const AssetImage('Assets/images/3.jpg'),
      const AssetImage('Assets/images/4.jpg'),
      const AssetImage('Assets/images/5.jpg'),
      const AssetImage('Assets/images/6.jpg'),
      const AssetImage('Assets/images/7.jpg'),
      const AssetImage('Assets/images/8.jpg'),
      const AssetImage('Assets/images/9.jpg'),
      const AssetImage('Assets/images/10.jpg'),
      const AssetImage('Assets/images/11.jpg'),
      const AssetImage('Assets/images/13.jpg'),
    ];
  }

  GetDeviceTypeOfStyleScreen() {
    if (SizerUtil.deviceType == DeviceType.mobile)
      return 1.1.sp;
    else if (SizerUtil.deviceType == DeviceType.tablet)
      return 0.sp;
  }

  List<String>Texts = [
    'VarelaRound',
    'MyriadPro',
    'PoiretOne',
    'Pompiere',
    'Satisfy',
    'AlegreyaSans',
    'KaushanScript',
    'Lobster',
    'Lobster Two',
    'Buda',
    'Linden Hill',
  ];
  int changeText = 0;

  forChangeFontSize(context) {
    //  AppCubit.get(context).changeText==0?16.sp:19.sp;
    if (SizerUtil.deviceType == DeviceType.mobile) {
      if (AppCubit.get(context).changeText == 0)
        return 17.sp;
      else
        return 18.sp;
    }
    else if (SizerUtil.deviceType == DeviceType.tablet) {
      if (AppCubit
          .get(context)
          .changeText == 0)
        return 16.sp;
      else
        return 15.sp;
    }
  }
  List<PhotoModel> photoList = [];
  List<QouteModel> Qoutes = [];
  List<TypeOfQoutesModel> Quotes = [];
  ChangeText() {
    print(changeText);
    if (changeText == 10) {
      changeText = 0;
    } else {
      changeText++;
    }
    print(changeText);
    //  emit(GetImagesState());
  }

  GetDeviceType() {
    if (SizerUtil.deviceType == DeviceType.mobile)
      return 1.sp;
    else if (SizerUtil.deviceType == DeviceType.tablet)
      return 0.sp;
  }

  Database? databaseForImages;
  List<Map<String, dynamic>> FavoriteImageList = [];


  ///database for images
  void createDatabaseForImages() {
    openDatabase(
      'favoriteImages.db',
      version: 1,
      onCreate: (database, version) {
        // id integer
        // title String
        // date String
        // time String
        // status String

        print('database for Images created');
        database.execute(
            'CREATE TABLE favoriteImages (id INTEGER PRIMARY KEY,status TEXT,image TEXT)')
            .then((value) {
          print('table created for images');
        }).catchError((error) {
          print('Error When Creating Table for images ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromImageDatabase(database);
        print('images database opened');
      },
    ).then((value) {
      databaseForImages = value;
      emit(AppCreateDatabaseState());
    });
  }

  Map<int, String> IsFavoriteImagesList = {};
  List<String> favoImages = [];

  Future<void> getDataFromImageDatabase(database) async {
    FavoriteImageList = [];
    IsFavoriteImagesList = {};
    //  emit(AppGetDatabaseLoadingState());

    await database.rawQuery('SELECT * FROM favoriteImages').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          FavoriteImageList.add(element);
        IsFavoriteImagesList.addAll(
            {
              element['id']: element['image'],
            });
      });
      emit(AppGetDatabaseState());
    });
  }


  Future insertToDatabase({
    @required String? image,
  }) async {
    await databaseForImages!.transaction((txn) async {
      txn.rawInsert(
        'INSERT INTO favoriteImages(status,image) VALUES("new","$image")',)
          .then((value) {
        print('$value inserted successfully');
        //      emit(AppInsertDatabaseState());

        //      getDataFromDatabase(database!);
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });
    });
  }

  Future deleteData({
    @required int? id,
  }) async {
    databaseForImages!.rawDelete(
        'DELETE FROM favoriteImages WHERE id = ?', [id])
        .then((value) {
      getDataFromImageDatabase(databaseForImages);
      //     emit(AppDeleteDatabaseState());
    });
  }
///
  Future deleteDataFromImagePage({
    @required String? image,
  }) async {
    databaseForImages!.rawDelete(
        'DELETE FROM favoriteImages WHERE image = ?', [image])
        .then((value) {
      getDataFromImageDatabasee(databaseForImages);
      //     emit(AppDeleteDatabaseState());
    });
  }

  Future<void> getDataFromImageDatabasee(database) async {
    FavoriteImageList = [];
    IsFavoriteImagesList = {};
    //  emit(AppGetDatabaseLoadingState());

    await database.rawQuery('SELECT * FROM favoriteImages').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          FavoriteImageList.add(element);
        IsFavoriteImagesList.addAll(
            {
              element['id']: element['image'],
            });
      });
      emit(AppGetDatabaseState());
    });
  }
  ///



  Future deleteDataFromImagePagee({
    @required String? image,
  }) async {
    databaseForImages!.rawDelete(
        'DELETE FROM favoriteImages WHERE image = ?', [image])
        .then((value) {
      getDataFromImageDatabase(databaseForImages);
      //     emit(AppDeleteDatabaseState());
    });
  }
///end of imagesDatabase


  Database? databaseForArabicImages;
  List<Map<String, dynamic>> FavoriteArabicImageList = [];

  ///database for Arabicimages
  void createDatabaseForArabicImages() {
    openDatabase(
      'favoriteArabicImages.db',
      version: 1,
      onCreate: (database, version) {
        // id integer
        // title String
        // date String
        // time String
        // status String

        print('database for ArabicImages created');
        database.execute(
            'CREATE TABLE favoriteArabicImages (id INTEGER PRIMARY KEY,status TEXT,image TEXT)')
            .then((value) {
          print('table created for Arabicimages');
        }).catchError((error) {
          print('Error When Creating Table for Arabicimages ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromArabicImageDatabase(database);
        print('images database opened');
      },
    ).then((value) {
      databaseForArabicImages = value;
      emit(AppCreateDatabaseState());
    });
  }

  Map<int, String> IsFavoriteArabicImagesList = {};
  List<String> favoArabicImages = [];

  Future<void> getDataFromArabicImageDatabase(database) async {
    FavoriteArabicImageList = [];
    IsFavoriteArabicImagesList = {};
    //  emit(AppGetDatabaseLoadingState());

    await database.rawQuery('SELECT * FROM favoriteArabicImages').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          FavoriteArabicImageList.add(element);
        IsFavoriteArabicImagesList.addAll(
            {
              element['id']: element['image'],
            });
      });
      emit(AppGetDatabaseState());
    });
  }


  Future insertToDatabaseForArabicImages({
    @required String? image,
  }) async {
    await databaseForArabicImages!.transaction((txn) async {
      txn.rawInsert(
        'INSERT INTO favoriteArabicImages(status,image) VALUES("new","$image")',)
          .then((value) {
        print('$value inserted successfully');
        //      emit(AppInsertDatabaseState());

        //      getDataFromDatabase(database!);
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });
    });
  }

  Future deleteDataForArabicImages({
    @required int? id,
  }) async {
    databaseForArabicImages!.rawDelete(
        'DELETE FROM favoriteArabicImages WHERE id = ?', [id])
        .then((value) {
      getDataFromArabicImageDatabase(databaseForArabicImages);
      //     emit(AppDeleteDatabaseState());
    });
  }
  ///
  Future deleteDataFromArabicImagePage({
    @required String? image,
  }) async {
    databaseForArabicImages!.rawDelete(
        'DELETE FROM favoriteArabicImages WHERE image = ?', [image])
        .then((value) {
      getDataFromArabicImageDatabasee(databaseForArabicImages);
      //     emit(AppDeleteDatabaseState());
    });
  }

  Future<void> getDataFromArabicImageDatabasee(database) async {
    FavoriteArabicImageList = [];
    IsFavoriteArabicImagesList = {};
    //  emit(AppGetDatabaseLoadingState());

    await database.rawQuery('SELECT * FROM favoriteArabicImages').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          FavoriteArabicImageList.add(element);
        IsFavoriteArabicImagesList.addAll(
            {
              element['id']: element['image'],
            });
      });
      emit(AppGetDatabaseState());
    });
  }
  ///



  Future deleteDataFromArabicImagePagee({
    @required String? image,
  }) async {
    databaseForArabicImages!.rawDelete(
        'DELETE FROM favoriteArabicImages WHERE image = ?', [image])
        .then((value) {
      getDataFromArabicImageDatabase(databaseForArabicImages);
      //     emit(AppDeleteDatabaseState());
    });
  }
  ///end of ArabicimagesDatabase




  ///databaseForVIdeosDatabase
  Database? databaseForVideos;
  List<Map<String, dynamic>> FavoriteVideoList = [];

  void createDatabaseForvideos() {
    openDatabase(
      'favoriteVideos.db',
      version: 1,
      onCreate: (database, version) {
        // id integer
        // title String
        // date String
        // time String
        // status String

        print('database for Videos created');
        database.execute(
            'CREATE TABLE favoriteVideos (id INTEGER PRIMARY KEY,status TEXT,video TEXT,imageVideo TEXT)')
            .then((value) {
          print('table created for videos');
        }).catchError((error) {
          print('Error When Creating Table for videos ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromVideoDatabase(database);
        print('videos database opened');
      },
    ).then((value) {
      databaseForVideos = value;
      emit(AppCreateDatabaseState());
    });
  }

  Map<int, String> IsFavoriteVideosList = {};
  List<String> favoVideos = [];

  Future<void> getDataFromVideoDatabase(database) async {
    FavoriteVideoList = [];
    IsFavoriteVideosList = {};
    //  emit(AppGetDatabaseLoadingState());

    await database.rawQuery('SELECT * FROM favoriteVideos').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          FavoriteVideoList.add(element);
        IsFavoriteVideosList.addAll(
            {
              element['id']: element['video'],
            });
      });
      emit(AppGetDatabaseState());
    });
  }

  Future<void> getDataFromVideoDatabases(database) async {
    FavoriteVideoList = [];
    IsFavoriteVideosList = {};
    //  emit(AppGetDatabaseLoadingState());

    await database.rawQuery('SELECT * FROM favoriteVideos').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          FavoriteVideoList.add(element);
        IsFavoriteVideosList.addAll(
            {
              element['id']: element['video'],
            });
      });
 //     emit(AppGetDatabaseState());
    });
  }



  Future insertToDatabaseForVideos({
    @required String? video,
    @required String? imageVideo,
  }) async {
    await databaseForVideos!.transaction((txn) async {
      txn.rawInsert(
        'INSERT INTO favoriteVideos(status,video,imageVideo) VALUES("new","$video","$imageVideo")',)
          .then((value) {
        print('$value inserted successfully');
        //      emit(AppInsertDatabaseState());

        //      getDataFromDatabase(database!);
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });
    });
  }

  void deleteDataForVideos({
    @required int? id,
  }) {
    databaseForVideos!.rawDelete(
        'DELETE FROM favoriteVideos WHERE id = ?', [id])
        .then((value) {
      getDataFromVideoDatabase(databaseForVideos);
      //     emit(AppDeleteDatabaseState());
    });
  }

  Future deleteDataForVideosFromVideoScreen({
    @required String? video,
  }) async {
    databaseForVideos!.rawDelete(
        'DELETE FROM favoriteVideos WHERE video = ?', [video])
        .then((value) {
      getDataFromVideoDatabase(databaseForVideos);
      //     emit(AppDeleteDatabaseState());
    });
  }
  ///end of DataBase Video


  ///databaseForArabicVIdeosDatabase
  Database? databaseForArabicVideos;
  List<Map<String, dynamic>> FavoriteArabicVideoList = [];

  void createDatabaseForArabicvideos() {
    openDatabase(
      'favoriteArabicVideos.db',
      version: 1,
      onCreate: (database, version) {
        // id integer
        // title String
        // date String
        // time String
        // status String

        print('database for ArabicVideos created');
        database.execute(
            'CREATE TABLE favoriteArabicVideos (id INTEGER PRIMARY KEY,status TEXT,video TEXT,imageVideo TEXT)')
            .then((value) {
          print('table created for Arabicvideos');
        }).catchError((error) {
          print('Error When Creating Table for Arabicvideos ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromArabicVideoDatabase(database);
        print('videos database opened');
      },
    ).then((value) {
      databaseForArabicVideos = value;
      emit(AppCreateDatabaseState());
    });
  }

  Map<int, String> IsFavoriteArabicVideosList = {};
  List<String> favoArabicVideos = [];

  Future<void> getDataFromArabicVideoDatabase(database) async {
    FavoriteArabicVideoList = [];
    IsFavoriteArabicVideosList = {};
    //  emit(AppGetDatabaseLoadingState());

    await database.rawQuery('SELECT * FROM favoriteArabicVideos').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          FavoriteArabicVideoList.add(element);
        IsFavoriteArabicVideosList.addAll(
            {
              element['id']: element['video'],
            });
      });
      emit(AppGetDatabaseState());
    });
  }

  Future<void> getDataFromArabicVideoDatabases(database) async {
    FavoriteArabicVideoList = [];
    IsFavoriteArabicVideosList = {};
    //  emit(AppGetDatabaseLoadingState());

    await database.rawQuery('SELECT * FROM favoriteArabicVideos').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          FavoriteArabicVideoList.add(element);
        IsFavoriteArabicVideosList.addAll(
            {
              element['id']: element['video'],
            });
      });
      //     emit(AppGetDatabaseState());
    });
  }



  Future insertToDatabaseForArabicVideos({
    @required String? video,
    @required String? imageVideo,
  }) async {
    await databaseForArabicVideos!.transaction((txn) async {
      txn.rawInsert(
        'INSERT INTO favoriteArabicVideos(status,video,imageVideo) VALUES("new","$video","$imageVideo")',)
          .then((value) {
        print('$value inserted successfully');
        //      emit(AppInsertDatabaseState());

        //      getDataFromDatabase(database!);
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });
    });
  }

  void deleteDataForArabicVideos({
    @required int? id,
  }) {
    databaseForArabicVideos!.rawDelete(
        'DELETE FROM favoriteArabicVideos WHERE id = ?', [id])
        .then((value) {
      getDataFromArabicVideoDatabase(databaseForArabicVideos);
      //     emit(AppDeleteDatabaseState());
    });
  }

  Future deleteDataForArabicVideosFromVideoScreen({
    @required String? video,
  }) async {
    databaseForArabicVideos!.rawDelete(
        'DELETE FROM favoriteArabicVideos WHERE video = ?', [video])
        .then((value) {
      getDataFromArabicVideoDatabase(databaseForArabicVideos);
      //     emit(AppDeleteDatabaseState());
    });
  }
  ///end of DataBase Video




  ///quotesDatabase
  Database? databaseForQuotes;
  List<Map<String, dynamic>> FavoriteQuotesList = [];

  void createDatabaseForQuotes() {
    openDatabase(
      'favoriteQuotes.db',
      version: 1,
      onCreate: (database, version) {
        // id integer
        // title String
        // date String
        // time String
        // status String

        print('database for Quotes created');
        database.execute(
            'CREATE TABLE favoriteQuotes (id INTEGER PRIMARY KEY,status TEXT,quote TEXT)')
            .then((value) {
          print('table created for quotes');
        }).catchError((error) {
          print('Error When Creating Table for quotes ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromQuotesDatabase(database);
        print('quotes database opened');
      },
    ).then((value) {
      databaseForQuotes = value;
      emit(AppCreateDatabaseState());
    });
  }

  Map<int, String> IsFavoriteQuotesList = {};
  List<String> favoQuotes = [];

  Future<void> getDataFromQuotesDatabase(database) async {
    FavoriteQuotesList = [];
    IsFavoriteQuotesList = {};
    //  emit(AppGetDatabaseLoadingState());

    await database.rawQuery('SELECT * FROM favoriteQuotes').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          FavoriteQuotesList.add(element);
        IsFavoriteQuotesList.addAll(
            {
              element['id']: element['quote'],
            });
      });
      //    emit(AppGetDatabaseState());
    });
  }

  Future<void> getDataFromQuotesDatabaseWithEmit(database) async {
    FavoriteQuotesList = [];
    IsFavoriteQuotesList = {};
    //  emit(AppGetDatabaseLoadingState());

    await database.rawQuery('SELECT * FROM favoriteQuotes').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          FavoriteQuotesList.add(element);
        IsFavoriteQuotesList.addAll(
            {
              element['id']: element['quote'],
            });
      });
      emit(AppGetDatabaseState());
    });
  }


  deleteDataForQuotesWithEmit({
    @required int? id,
  }) async {
    await databaseForQuotes!.rawDelete(
        'DELETE FROM favoriteQuotes WHERE id = ?', [id])
        .then((value) {
      getDataFromQuotesDatabaseWithEmit(databaseForQuotes);
      //     emit(AppDeleteDatabaseState());
    });
  }


  Future<void> getDataFromQuotesStyleDatabase(database) async {
    FavoriteQuotesList = [];
    IsFavoriteQuotesList = {};
    //  emit(AppGetDatabaseLoadingState());

    await database.rawQuery('SELECT * FROM favoriteQuotes').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          FavoriteQuotesList.add(element);
        IsFavoriteQuotesList.addAll(
            {
              element['id']: element['quote'],
            });
      });
      emit(AppGetDatabaseState());
    });
  }

  Future insertToDatabaseForQuotes({
    @required String? quote,
  }) async {
    await databaseForQuotes!.transaction((txn) async {
      txn.rawInsert(
        'INSERT INTO favoriteQuotes(status,quote) VALUES("new","$quote")',)
          .then((value) {
        print('$value inserted successfully');
        //      emit(AppInsertDatabaseState());

        //      getDataFromDatabase(database!);
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });
    });
  }

  deleteDataForQuotes({
    @required int? id,
  }) async {
    await databaseForQuotes!.rawDelete(
        'DELETE FROM favoriteQuotes WHERE id = ?', [id])
        .then((value) {
      getDataFromQuotesDatabase(databaseForQuotes);
      //     emit(AppDeleteDatabaseState());
    });
  }

  Future deleteeData({
    @required String? quote,
  }) async
  {
    await databaseForQuotes!.rawDelete(
        'DELETE FROM favoriteQuotes WHERE quote = ?', [quote]);
  }
  ///end of database for Quotes



  ///ArabicquotesDatabase
  Database? databaseForArabicQuotes;
  List<Map<String, dynamic>> FavoriteArabicQuotesList = [];

   createDatabaseForArabicQuotes()  async{
    openDatabase(
      'favoriteArabicQuotes.db',
      version: 1,
      onCreate: (database, version) {
        // id integer
        // title String
        // date String
        // time String
        // status String

        print('database for ArabicQuotes created');
        database.execute(
            'CREATE TABLE favoriteArabicQuotes (id INTEGER PRIMARY KEY,status TEXT,quote TEXT)')
            .then((value) {
          print('table created for Arabicquotes');
        }).catchError((error) {
          print('Error When Creating Table for Arabicquotes ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromArabicQuotesDatabase(database);
        print('Arabicquotes database opened');
      },
    ).then((value) {
      databaseForArabicQuotes = value;
      emit(AppCreateDatabaseState());
    });
  }

  Map<int, String> IsFavoriteArabicQuotesList = {};
  List<String> favoArabicQuotes = [];

  Future<void> getDataFromArabicQuotesDatabase(database) async {
    FavoriteArabicQuotesList = [];
    IsFavoriteArabicQuotesList = {};
    //  emit(AppGetDatabaseLoadingState());

    await database.rawQuery('SELECT * FROM favoriteArabicQuotes').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          FavoriteArabicQuotesList.add(element);
        IsFavoriteArabicQuotesList.addAll(
            {
              element['id']: element['quote'],
            });
      });
      //    emit(AppGetDatabaseState());
    });
  }

  Future<void> getDataFromArabicQuotesDatabaseWithEmit(database) async {
    FavoriteArabicQuotesList = [];
    IsFavoriteArabicQuotesList = {};
    //  emit(AppGetDatabaseLoadingState());

    await database.rawQuery('SELECT * FROM favoriteArabicQuotes').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          FavoriteArabicQuotesList.add(element);
        IsFavoriteArabicQuotesList.addAll(
            {
              element['id']: element['quote'],
            });
      });
      emit(AppGetDatabaseState());
    });
  }


  deleteDataForArabicQuotesWithEmit({
    @required int? id,
  }) async {
    await databaseForArabicQuotes!.rawDelete(
        'DELETE FROM favoriteArabicQuotes WHERE id = ?', [id])
        .then((value) {
      getDataFromArabicQuotesDatabaseWithEmit(databaseForArabicQuotes);
      //     emit(AppDeleteDatabaseState());
    });
  }


  Future<void> getDataFromArabicQuotesStyleDatabase(database) async {
    FavoriteArabicQuotesList = [];
    IsFavoriteArabicQuotesList = {};
    //  emit(AppGetDatabaseLoadingState());

    await database.rawQuery('SELECT * FROM favoriteArabicQuotes').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          FavoriteArabicQuotesList.add(element);
        IsFavoriteArabicQuotesList.addAll(
            {
              element['id']: element['quote'],
            });
      });
      emit(AppGetDatabaseState());
    });
  }

  Future insertToDatabaseForArabicQuotes({
    @required String? quote,
  }) async {
    await databaseForArabicQuotes!.transaction((txn) async {
      txn.rawInsert(
        'INSERT INTO favoriteArabicQuotes(status,quote) VALUES("new","$quote")',)
          .then((value) {
        print('$value inserted successfully');
        //      emit(AppInsertDatabaseState());

        //      getDataFromDatabase(database!);
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });
    });
  }

  deleteDataForArabicQuotes({
    @required int? id,
  }) async {
    await databaseForArabicQuotes!.rawDelete(
        'DELETE FROM favoriteArabicQuotes WHERE id = ?', [id])
        .then((value) {
      getDataFromArabicQuotesDatabase(databaseForArabicQuotes);
      //     emit(AppDeleteDatabaseState());
    });
  }

  Future deleteeDataForArabic({
    @required String? quote,
  }) async
  {
    await databaseForArabicQuotes!.rawDelete(
        'DELETE FROM favoriteArabicQuotes WHERE quote = ?', [quote]);
  }
  ///end of database for ArabicQuotes

///function for Quotes
  bool function(qoute) {
    if (IsFavoriteQuotesList.containsValue(qoute)) {
      return false;
    }
    else {
      return true;
    }
  }
  bool functionForArabic(qoute) {
    if (IsFavoriteArabicQuotesList.containsValue(qoute)) {
      return false;
    }
    else {
      return true;
    }
  }
  ///function for Quotes
  bool isDark = false;

  MakeItDark({bool? fromShared}) {
    if (fromShared == false) {
      isDark = fromShared!;
      emit(MakeItDarkState());
    } else {
      isDark = !isDark;
      CasheHelper.putBoolean(key: 'isDark', value: isDark)!.then((value) {
        emit(MakeItDarkState());
      });
    }
  }
  Color? getColor(Set<MaterialState> states,{ image}) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,

    };

 //   MaterialStateProperty.all(Colors.green):MaterialStateProperty.all(Colors.transparent);
    return isDark ==false?Colors.transparent:Colors.grey[800];
  }

  Color? getColorr(Set<MaterialState> states,{ image}) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,

    };

    return Colors.transparent;
  }

  EdgeInsetsGeometry padding(Set<MaterialState> states,{ image}) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,

    };

    return EdgeInsetsDirectional.zero;
  }


  down({check,video})
  async {
    {
      check=1;
      final temp = await getTemporaryDirectory();
      final path = '${temp.path}/video.mp4';
      await Dio().download(
        video,
        path,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            print((received / total * 100)
                .toStringAsFixed(0) +
                "%");
            print(received / total);
              AppCubit.get(context).prograss =
              ((received / total * 100)
                  .toStringAsFixed(0) +
                  "%");
              AppCubit.get(context).ss =
                  received / total;
            emit(MakeItDarkState());
          }
        },
        deleteOnError: true,
      ).then((value) async {
        await GallerySaver.saveVideo(path)
            .then((value) {

            AppCubit.get(context).ss = 0;
            AppCubit.get(context).prograss=0;
            emit(MakeItDarkState());
          check==0;
        });
      });
    }
  }


  List<String>vidDownText =[];
  List<double>vidDownCirc =[];

 var bro ;
  double sss =0;

  String text ='';
  double circle=0;
  int? index;

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
  Download({video,Index})
  async {
    index = Index;
    final temp = await getTemporaryDirectory();
    final path = '${temp.path}.mp4';
    await Dio().download(
      video,
      path,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          print((received / total * 100)
              .toStringAsFixed(0) +
              "%");
          print(received / total);
          {
            text = ((received / total * 100).toStringAsFixed(0) + "%");
            circle = received / total;
            emit(downloadState());
          }
        }
      } ,
          /*
          (received, total) {
        if (total != -1) {
          print((received / total * 100)
              .toStringAsFixed(0) +
              "%");
          print(received / total);
          text = ((received / total * 100).toStringAsFixed(0) + "%");
          circle = received / total;
          emit(MakeItDarkState());
        }
      },

           */
      deleteOnError: true,

    ).then((value) async {
      await GallerySaver.saveVideo(path).then((value) {
        Fluttertoast.showToast(msg: 'Download'.tr(),fontSize:SizerUtil.deviceType==DeviceType.mobile?12.sp:5.sp,textColor:isDark?Colors.black:Colors.white,gravity: ToastGravity.CENTER,backgroundColor:isDark? Colors.green:Colors.green);
        text = '';
        circle=0;
        emit(MakeItDarkState());

      });
    }).catchError((error)
    {
      circle=0;
      text='';
      Fluttertoast.showToast(msg: 'Error'.tr(),fontSize: 11.sp,textColor:isDark?Colors.black:Colors.white ,gravity: ToastGravity.CENTER,backgroundColor:isDark? Colors.green:Colors.green);
      emit(MakeItDarkState());
    });
  }

  Future startShare({video,Index}) async {
    index = Index;
    final url = video;
    final request = Request('GET', Uri.parse(url));
    final response = await Client().send(request);
    final contentLength = response.contentLength;

    final file = await getFile('file.mp4');
    final bytes = <int>[];
    response.stream.listen(
          (newBytes) {
        bytes.addAll(newBytes);
        {
          progresss = bytes.length / contentLength!;
          emit(shareState());
        }
      },
      onDone: () async {

    //      AppCubit.get(context).progresss = 1;
        await file.writeAsBytes(bytes);

        //     final url =Uri.parse(widget.video);
        //     final response = await http.get(url);
        //    final bytes = response.bodyBytes;
        final temp = await getTemporaryDirectory();
        final path = '${temp.path}/video.mp4';
        File(path).writeAsBytesSync(bytes);
        await Share.shareFiles([path]);
        progresss = 0;
        emit(shareState());
      },
      onError: (error)
      async{
        progresss=0;
        Fluttertoast.showToast(msg: 'error on downloading video',gravity: ToastGravity.CENTER,backgroundColor:isDark? Colors.green:Colors.black);
        emit(shareState());
      },
      cancelOnError: true,
    );
  }

  Widget buildProgress() {
    if (progresss == 1) {
      return  Icon(
        Icons.done,
        color: Colors.green,
        size: 6.sp,
      );
    } else {
      return Text(
        '${(progresss * 100).toStringAsFixed(1)}',
        style: TextStyle(fontSize: 6.sp,color: isDark?Colors.black:Colors.black),
      );
    }
  }

  Widget buildProgressForGridView() {
    if (progresss == 1) {
      return  Icon(
        Icons.done,
        color: Colors.green,
        size: 7.sp,
      );
    } else {
      return Text(
        '${(progresss * 100).toStringAsFixed(1)}',
        style: TextStyle(fontSize: 7.sp,color: isDark?Colors.black:Colors.black),
      );
    }
  }

  Widget buildProgressForVideoScreen() {
    if (progresss == 1) {
      return  Icon(
        Icons.done,
        color: Colors.green,
        size: 10.sp,
      );
    } else {
      return Text(
        '${(progresss * 100).toStringAsFixed(1)}',
        style: TextStyle(fontSize: 10.sp,color: isDark?Colors.black:Colors.black),
      );
    }
  }
  List<VideoModel>videoListCopy = [];

  Future nn()
  async {
    videoList.forEach((element)
    {
      videoListCopy.add(element);
    });
      emit(shareState());
  }

   Future nnb(context)
   async {
     Navigator.pop(context);

  }

  bb()
  {
    emit(shareState());
  }
  Future refreshData() async
  {
    await Future.delayed(Duration(seconds: 3));
    emit(shareState());
  }
  Future<void> close() {
    // dispose
    return super.close();
  }

  late var a ;
  late var b;
  late var ind;

  int s =0;
  List<PhotoModel>Lista =[];
  show({element,s})
  {
       if(s>0)
       {
         photoList.insert(0, element);
       }
       s++;
       print(s);
  }
  ///الصور العربي

  Stream<QuerySnapshot> GetArabicPhotes() {
    return FirebaseFirestore.instance.collection('صور').orderBy("time", descending: true).snapshots();
  }

  List<PhotoModel> ArapicPhotoList= [];
  ///

  ///الفيدويهات العربي
  Stream<QuerySnapshot> GetArabicVideos() {

    return FirebaseFirestore.instance.collection('فيديو').orderBy("time", descending: true).snapshots();
  }
  List<VideoModel>ArabicvideoList = [];


  ///اقتباسات العربي
  Stream<QuerySnapshot> GetArabicQoutes() {
    return FirebaseFirestore.instance.collection('اقتباسات').orderBy("time", descending: true).snapshots();
  }
  List<QouteModel> ArabicQoutesList = [];

  Stream<QuerySnapshot> GetNumberOfArabicQoutes(String id) {
    return FirebaseFirestore.instance.collection('اقتباسات').doc(id).collection(
        'getQuotes').snapshots();
  }
  Stream<QuerySnapshot> GetArabicQoutesFromTypeOfQoutes(id) {
    return FirebaseFirestore.instance.collection('اقتباسات').doc(id).collection(
        'getQuotes').orderBy("time", descending: true).snapshots();
  }
  List<TypeOfQoutesModel> ArabicTypeOfQuotesList = [];
///اقتباسات العربي
///

  String? value;

  changeLanguage(valuee,context)
  {
    ///english
    if(valuee=='English'&&translator.isDirectionRTL(context)==true)
    {
      value =valuee;
      CasheHelper.SaveData(key: 'language', value: valuee)!.then((value)
      {
        translator.setNewLanguage(context, newLanguage: 'en',restart: true,remember: true).then((value)
        {
          emit(ChangeLanguage());
        });
      });
    }
    if(valuee=='English'&&translator.isDirectionRTL(context)==false)
    {
      value =valuee;
      CasheHelper.SaveData(key: 'language', value: valuee)!.then((value)
      {
        emit(ChangeLanguage());
      });
    }
      ///Arabic
    if(valuee=='Arabic'&&translator.isDirectionRTL(context)==false)
    {
      value =valuee;
      CasheHelper.SaveData(key: 'language', value: valuee)!.then((value)
      {
        translator.setNewLanguage(context, newLanguage: 'ar',restart: true,remember: true).then((value)
        {
          emit(ChangeLanguage());
        });
      });
    }
    if(valuee=='Arabic'&&translator.isDirectionRTL(context)==true)
    {
      value =valuee;
      CasheHelper.SaveData(key: 'language', value: valuee)!.then((value)
      {

      });
      emit(ChangeLanguage());
    }

  }
  bool isHomeBannerAdLoaded=false;
  late BannerAd myHomeBanner = BannerAd(
  adUnitId: Platform.isAndroid?'ca-app-pub-3940256099942544/6300978111':'ca-app-pub-3940256099942544/2934735716',
  size: AdSize.banner,
  request: AdRequest(),
  listener: BannerAdListener(
  // Called when an ad is successfully received.
  onAdLoaded: (Ad ad) => ()
  {

  },
  // Called when an ad request failed.
  onAdFailedToLoad: (Ad ad, LoadAdError error) {
  // Dispose the ad here to free resources.
  ad.dispose();
  print('Ad failed to load: $error');
  },
  // Called when an ad opens an overlay that covers the screen.
  onAdOpened: (Ad ad) => print('Ad opened.'),
  // Called when an ad removes an overlay that covers the screen.
  onAdClosed: (Ad ad) => print('Ad closed.'),
  // Called when an impression occurs on the ad.
  onAdImpression: (Ad ad) => print('Ad impression.'),
  ),
  );

  final BannerAd FavoriteScreenAd = BannerAd(
    adUnitId: Platform.isAndroid?'ca-app-pub-3940256099942544/6300978111':'ca-app-pub-3940256099942544/2934735716',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(
      // Called when an ad is successfully received.
      onAdLoaded: (Ad ad) => print('Ad loaded.'),
      // Called when an ad request failed.
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        // Dispose the ad here to free resources.
        ad.dispose();
        print('Ad failed to load: $error');
      },
      // Called when an ad opens an overlay that covers the screen.
      onAdOpened: (Ad ad) => print('Ad opened.'),
      // Called when an ad removes an overlay that covers the screen.
      onAdClosed: (Ad ad) => print('Ad closed.'),
      // Called when an impression occurs on the ad.
      onAdImpression: (Ad ad) => print('Ad impression.'),
    ),
  );

  final BannerAd PhotoScreenAd = BannerAd(
    adUnitId: Platform.isAndroid?'ca-app-pub-3940256099942544/6300978111':'ca-app-pub-3940256099942544/2934735716',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(
      // Called when an ad is successfully received.
      onAdLoaded: (Ad ad) => print('Ad loaded.'),
      // Called when an ad request failed.
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        // Dispose the ad here to free resources.
        ad.dispose();
        print('Ad failed to load: $error');
      },
      // Called when an ad opens an overlay that covers the screen.
      onAdOpened: (Ad ad) => print('Ad opened.'),
      // Called when an ad removes an overlay that covers the screen.
      onAdClosed: (Ad ad) => print('Ad closed.'),
      // Called when an impression occurs on the ad.
      onAdImpression: (Ad ad) => print('Ad impression.'),
    ),
  );

  final BannerAd videoScreenAd = BannerAd(
    adUnitId: Platform.isAndroid?'ca-app-pub-3940256099942544/6300978111':'ca-app-pub-3940256099942544/2934735716',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(
      // Called when an ad is successfully received.
      onAdLoaded: (Ad ad) => print('Ad loaded.'),
      // Called when an ad request failed.
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        // Dispose the ad here to free resources.
        ad.dispose();
        print('Ad failed to load: $error');
      },
      // Called when an ad opens an overlay that covers the screen.
      onAdOpened: (Ad ad) => print('Ad opened.'),
      // Called when an ad removes an overlay that covers the screen.
      onAdClosed: (Ad ad) => print('Ad closed.'),
      // Called when an impression occurs on the ad.
      onAdImpression: (Ad ad) => print('Ad impression.'),
    ),
  );

  final BannerAd qouteScreenAd = BannerAd(
    adUnitId: Platform.isAndroid?'ca-app-pub-3940256099942544/6300978111':'ca-app-pub-3940256099942544/2934735716',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(
      // Called when an ad is successfully received.
      onAdLoaded: (Ad ad) => print('Ad loaded.'),
      // Called when an ad request failed.
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        // Dispose the ad here to free resources.
        ad.dispose();
        print('Ad failed to load: $error');
      },
      // Called when an ad opens an overlay that covers the screen.
      onAdOpened: (Ad ad) => print('Ad opened.'),
      // Called when an ad removes an overlay that covers the screen.
      onAdClosed: (Ad ad) => print('Ad closed.'),
      // Called when an impression occurs on the ad.
      onAdImpression: (Ad ad) => print('Ad impression.'),
    ),
  );

  final BannerAd qouteStyleScreenAd = BannerAd(
    adUnitId: Platform.isAndroid?'ca-app-pub-3940256099942544/6300978111':'ca-app-pub-3940256099942544/2934735716',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(
      // Called when an ad is successfully received.
      onAdLoaded: (Ad ad) => print('Ad loaded.'),
      // Called when an ad request failed.
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        // Dispose the ad here to free resources.
        ad.dispose();
        print('Ad failed to load: $error');
      },
      // Called when an ad opens an overlay that covers the screen.
      onAdOpened: (Ad ad) => print('Ad opened.'),
      // Called when an ad removes an overlay that covers the screen.
      onAdClosed: (Ad ad) => print('Ad closed.'),
      // Called when an impression occurs on the ad.
      onAdImpression: (Ad ad) => print('Ad impression.'),
    ),
  );

  Widget getAd() {
    BannerAd MyyBanner = BannerAd(
      adUnitId: Platform.isAndroid?'ca-app-pub-3940256099942544/6300978111':'ca-app-pub-3940256099942544/2934735716',
      size: AdSize.largeBanner,
      request: AdRequest(),
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad)
        {
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // Dispose the ad here to free resources.
          ad.dispose();
          print('Ad failed to load: $error');
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) => print('Ad opened.'),
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) => print('Ad closed.'),
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) => print('Ad impression.'),
        onAdWillDismissScreen: (ad) {
          ad.dispose();
        },
      ),
    );
    // MyyBanner.load();
    return SizedBox(
      height: MyyBanner.size.height.toDouble(),
      width: MyyBanner.size.width.toDouble(),
      child:AdWidget(ad: MyyBanner..load(),key: UniqueKey()),
    );
  }

  ///interstial ad

  InterstitialAd ? interstitialAd;
  bool  isReady =false ;
  Future<void> loadInterstialAd ()
  async {
    await InterstitialAd.load(
      adUnitId: Platform.isAndroid?'ca-app-pub-3940256099942544/1033173712':'ca-app-pub-3940256099942544/5135589807',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad)
          {
            isReady = true;
            interstitialAd = ad;
          },
          onAdFailedToLoad: (error)
          {
            print('interstial ad is failed to load');
          }
      ),
    );
  }
  Future<void> showInterstialAd()
  async {
    if(isReady) {
      await  interstitialAd!.show();
    }
  }
  int interstialadCount =0;
  void adCount()
  {
    //   print('count pefore change${interstialadCount}');
    if(interstialadCount<=4) {
      interstialadCount++;
    } else {
      interstialadCount=0;
    }
    //    print('count after change${interstialadCount}');
  }

  ///interstial ad for quote style
  int interstialadCountForQuoteStyle =0;
  void adCountForQouteStyle()
  {
    //   print('count pefore change${interstialadCount}');
    if(interstialadCountForQuoteStyle<=2) {
      interstialadCountForQuoteStyle++;
    } else {
      interstialadCountForQuoteStyle=0;
    }
    //    print('count after change${interstialadCount}');
  }

  ///interstial ad for photo
  int interstialadCountForPhotoes =0;
  void adCountForPhotoes()
  {
    //   print('count pefore change${interstialadCount}');
    if(interstialadCountForPhotoes<=4) {
      interstialadCountForPhotoes++;
    } else {
      interstialadCountForPhotoes=0;
    }
    //    print('count after change${interstialadCount}');
  }

  ///interstial ad for photoOpen
  int interstialadCountForPhotoOpen =0;
  void adCountForPhotoOpen()
  {
    //   print('count pefore change${interstialadCount}');
    if(interstialadCountForPhotoOpen<=4) {
      interstialadCountForPhotoOpen++;
    } else {
      interstialadCountForPhotoOpen=0;
    }
    //    print('count after change${interstialadCount}');
  }


  ///interstial ad for video
  int interstialadCountForVideos =0;
  void adCountForVideos()
  {
    //   print('count pefore change${interstialadCount}');
    if(interstialadCountForVideos<=4) {
      interstialadCountForVideos++;
    } else {
      interstialadCountForVideos=0;
    }
    //    print('count after change${interstialadCount}');
  }


  ///interstial ad for videoOpen
  int interstialadCountForVideoOpen =0;
  void adCountForVideoOpen()
  {
    //   print('count pefore change${interstialadCount}');
    if(interstialadCountForVideoOpen<=4) {
      interstialadCountForVideoOpen++;
    } else {
      interstialadCountForVideoOpen=0;
    }
    //    print('count after change${interstialadCount}');
  }

 int changeArabicText =0;
  ChangeTextForArabic() {
    print(changeArabicText);
    if (changeArabicText == 5) {
      changeArabicText = 0;
    } else {
      changeArabicText++;
    }
    print(changeArabicText);
    //  emit(GetImagesState());
  }

  List<String>arabicTexts = [
    'ElMessiri',
    'Amiri',
    'ArefRuqaa',
    'Change',
    'Gulzar',
    'Lalezar',
  ];

  List<DocumentSnapshot> _products = [];
}


