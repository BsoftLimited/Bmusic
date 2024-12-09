import 'dart:developer';
import 'dart:io';

import 'package:bmusic/blocs/states/settings_state.dart';
import 'package:bmusic/blocs/states/status.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallpaper_handler/wallpaper_handler.dart';

Future<bool> __storagePermission() async {
    final DeviceInfoPlugin info = DeviceInfoPlugin(); 
    final AndroidDeviceInfo androidInfo = await info.androidInfo;
        
    log('releaseVersion : ${androidInfo.version.release}');
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

Future<Uint8List?> __getBackgroundImage() async{
    try{ 
        return await WallpaperHandler.instance.getWallpaper(WallpaperLocation.homeScreen);
    }catch(error){
        log("unable to retrieve wallpaper", error: error);
        return Future.error(Exception("unable to retrieve wallpaper"));
    }
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

class SettingsCubit extends HydratedCubit<SettingsState>{
    bool get hasExistingData => HydratedBloc.storage.read(runtimeType.toString()) != null;
    
    SettingsCubit(): super(const SettingsState()){
        initialize().then((permitted){
            if(!permitted){
                exit(0);
            }
        });
    }

    set themeMode(ThemeMode mode) => emit(state.copy(themeMode: mode));

    Future<bool> initialize() async{
        emit(state.copy(message: "fetching songs, please wait", status: StateStatus.loading));
        try{
            bool permission = await __storagePermission();
            if(permission){
                Map<int, SongModel> init = {};
                for (var song in (await __fetchSongs())) {
                    init.putIfAbsent(song.id, ()=> song);
                }
                emit(state.copy(message: "getting phone wallpaer", songs: init));
                
                Uint8List? background = await __getBackgroundImage();
                emit(state.copy(background: background, status: StateStatus.success));
            }
            return permission;
        }catch(error){
            log("unable to retrieve required metadata", error: error);
            return Future.error(Exception("unable to retrieve required metadata"));
        }
    }
    
    @override
    SettingsState? fromJson(Map<String, dynamic> json) {
        return SettingsState.fromJson(json);
    }
    
    @override
    Map<String, dynamic>? toJson(SettingsState state) {
        return state.toJson();
    }
}