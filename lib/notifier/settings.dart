import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:bmusic/utils/objectio.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallpaper_handler/wallpaper_handler.dart';

Future<bool> __storagePermission() async {
    final DeviceInfoPlugin info = DeviceInfoPlugin(); // import 'package:device_info_plus/device_info_plus.dart';
    final AndroidDeviceInfo androidInfo = await info.androidInfo;
        
    debugPrint('releaseVersion : ${androidInfo.version.release}');
    final int androidVersion = int.parse(androidInfo.version.release);
    bool havePermission = false;

    if (androidVersion >= 13) {
        final request = await [ Permission.audio, Permission.manageExternalStorage ].request();

        havePermission = request.values.every((status) => status == PermissionStatus.granted);
    } else {
        final request = await [Permission.storage, Permission.manageExternalStorage ].request(); 

        havePermission = request.values.every((status) => status == PermissionStatus.granted);
    }

    if (!havePermission) {
        await openAppSettings();
    }
    return havePermission;
}

Future<Iterable<SongModel>> __find(OnAudioQuery audioQuery) async{
    try{
        List<SongModel> initList = await audioQuery.querySongs( 
            sortType: SongSortType.TITLE, 
            orderType: OrderType.ASC_OR_SMALLER, 
            uriType: UriType.EXTERNAL, ignoreCase: true);

        return initList;
    }catch(error){
        log('Error: $error');
        throw Exception(error);
    }
}

Future<Image> __getBackgroundImage() async{
    try{ 
        Uint8List? imgBytes =  await WallpaperHandler.instance.getWallpaper(WallpaperLocation.homeScreen);
        if(imgBytes != null){
            return Image.memory(Uint8List.fromList(imgBytes.toList()), fit: BoxFit.fitHeight,);
        }
    }catch(error){
        return Future.error(error);
    }
    return Future.error(Exception("unable to retrieve wallpater"));
}

Future<Iterable<SongModel>> __fetchSongs() async{
    bool permissionStatus = await __storagePermission();
    if(!permissionStatus){
        exit(0);
    }
    
    OnAudioQuery audioQuery = OnAudioQuery();
    permissionStatus = await audioQuery.permissionsStatus();
    if (!permissionStatus) {
        if(! await audioQuery.permissionsRequest()){
            await openAppSettings();
        }
    }
    return await __find(audioQuery);
}

class Settings {
    String themeMode;

    Settings({ this.themeMode = "auto" });

    factory Settings.fromJson(dynamic json) {
        return Settings( themeMode: json["themeMode"] as String);
    }

    Map toJson() => { "themeMode" : themeMode };

    String serialize() => jsonEncode(toJson());
}

Future<Settings> __findSettings() async{
    try{
        ObjectIO objectIO = ObjectIO(folder: "data");
        String savedObject = await objectIO.readFromFile("settings");

        return Settings.fromJson(jsonDecode(savedObject));
    }catch(error){
        log("retrieving saved setting exception:", error: error);
        //throw Exception("encountered an error when retrieving saved settings");
    }
    return Settings();
}

class SettingsNotifier extends ChangeNotifier{
    late Settings __settings;

    late Image __background;
    Image get background => __background;

    final List<SongModel> __songs = [];
    List<SongModel> get songs => __songs;

    bool __initialized = false;
    bool get initialized => __initialized;

    String __message = "initializing, please wait";
    String get message => __message; 

    String get themeMode => __settings.themeMode;
    ThemeMode get themeModeValue{
        switch(__settings.themeMode){
            case "light":
                return ThemeMode.light;
            case "dark":
                return ThemeMode.dark;
        }
        return ThemeMode.system;
    }

    SettingsNotifier(){
        initialize().then((permitted){
          if(!permitted){
              exit(0);
          }
        }).whenComplete((){
            __initialized = true;
            notifyListeners();
        });
    }

    Future<bool> initialize() async{
        try{
            bool permission = await __storagePermission();
            if(permission){
                __message = "fetching songs, please wait";
                notifyListeners();
                Iterable<SongModel> songs = await __fetchSongs();
                __songs.addAll(songs);

                __message = "loading settings";
                notifyListeners();
                __settings = await __findSettings();

                __message = "getting phone wallpaer";
                notifyListeners();
                __background = await __getBackgroundImage();
            }
            return permission;
        }catch(error){
            return Future.error(error);
        }
    }

    void setThemeMode(String mode){
        if(__settings.themeMode != mode){
            __settings.themeMode = mode;
            notifyListeners();
            save();
        }
    }

    Future<void> save() async{
        try{
            ObjectIO objectIO = ObjectIO(folder: "data");
            objectIO.writeToFile("settings", jsonEncode(__settings));
        }catch(error){
            log("Settings save error:", error: error);
        }
    }
}