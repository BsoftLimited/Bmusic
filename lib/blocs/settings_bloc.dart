import 'dart:developer';

import 'package:bmusic/blocs/states/settings_state.dart';
import 'package:bmusic/blocs/states/status.dart';
import 'package:bmusic/repositories/local_music_repository.dart';
import 'package:bmusic/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wallpaper_handler/wallpaper_handler.dart';

/*Future<Uint8List?> __getBackgroundImage() async{
    try{ 
        return await WallpaperHandler.instance.getWallpaper(WallpaperLocation.homeScreen);
    }catch(error){
        log("unable to retrieve wallpaper", error: error);
        return Future.error(Exception("unable to retrieve wallpaper"));
    }
}*/

class SettingsCubit extends HydratedCubit<SettingsState>{
    final LocalMusicRepository __localMusicRepository = LocalMusicRepository();

    bool get hasExistingData => HydratedBloc.storage.read(runtimeType.toString()) != null;
    
    SettingsCubit(): super(const SettingsState());

    set themeMode(ThemeMode mode) => emit(state.copy(themeMode: mode));

    Future<void> initialize(void Function() done) async{
        emit(state.copy(message: "fetching songs, please wait", status: StateStatus.loading));
        try{
            bool permission = await Util.storagePermission();
            if(permission){
                emit(state.copy(status: StateStatus.success, songs: await __localMusicRepository.fetchMusics()));
                
                /*Uint8List? background = await __getBackgroundImage();*/
                //emit(state.copy(status: StateStatus.success, message: "done"));
                done();
            }else{
                emit(state.copy(status: StateStatus.failure, message: "kindly restart and give the required permissions"));
            }
        }catch(error){
            log("unable to retrieve required metadata", error: error);
            emit(state.copy(status: StateStatus.failure, message: "something went wrong, check your permissions"));
        }
    }
    
    @override
    SettingsState? fromJson(Map<String, dynamic> json) {
        try{
            return SettingsState.fromJson(json);
        }catch(err){
            log("Settings State deserialization error", error: err);
        }
        return null;
    }
    
    @override
    Map<String, dynamic>? toJson(SettingsState state) {
        try{
            return state.toJson();
        }catch(err){
            log("Settings State serialization error", error: err);
        }
        return null;
    }
}