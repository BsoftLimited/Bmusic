import 'dart:developer';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:bmusic/utils/util.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

enum PlayMode{ single, sequence, shuffle }

class PlayingStateNotifier extends ChangeNotifier {
    final List<SongModel> __songs = [];
    List<SongModel> __playList = [];

    List<SongModel> get songs => __songs;
    List<SongModel> get playList => __playList;

    final player = AudioPlayer();

    Function? onLoadingfinished;

    
    bool get playing => player.state == PlayerState.playing ;

    Duration __duration = Duration.zero, __position = Duration.zero;
    Duration get duration => __duration;
    Duration get position => __position;
    set seek(int seconds){
        Duration position = Duration(seconds: seconds);
        player.seek(position).then((value){
            notifyListeners();
        });
    }

    int __curentIndex = 0;
    int get curentIndex => __curentIndex;

    SongModel? get current{
        if(__curentIndex < __playList.length){
            return __playList[__curentIndex];
        }
        return null;
    }

    set current(SongModel? songModel){
        if(songModel != null){
            __curentIndex = __playList.indexOf(songModel);
            __initPlayMode();
            __play();
        }
    }

    PlayMode __playMode = PlayMode.sequence;
    PlayMode get playMode => __playMode;

    void __initPlayMode(){
        switch(__playMode){
            case PlayMode.sequence:
                __curentIndex = __songs.indexOf(current!);
                __playList = __songs;
                notifyListeners();
                break;
            case PlayMode.shuffle:
              Util.shuffle(__songs, current!).then((list){
                  __playList = list;
                  __curentIndex = 0;
                  notifyListeners();
              });
              break;
            case PlayMode.single:
              __playList = [current!];
              __curentIndex = 0;
              notifyListeners();
              break;
        }
    }
    void togglePlayMode(){
        switch(__playMode){
            case PlayMode.single:
                __playMode = PlayMode.sequence;
                break;
            case PlayMode.sequence:
              __playMode = PlayMode.shuffle;
              break;
            case PlayMode.shuffle:
              __playMode = PlayMode.single;
              break;
        }
        __initPlayMode();
    }

    final Map<int, SongModel> __favourites = {};
    Map<int, SongModel> get favourite => __favourites;
    bool isFavourite(SongModel? songModel){
        if(songModel != null){
            return __favourites.containsKey(songModel.id);
        }
        return false;
    }
    void toggleFavourite(SongModel? songModel){
        if(songModel != null){
            if(__favourites.containsKey(songModel.id)){
                __favourites.remove(songModel.id);
            }else{
                __favourites[songModel.id] = songModel;
            }
            notifyListeners();
        }
    }

    PlayingStateNotifier(){        
        __fetchSongs().then((songs){
            __songs.addAll(songs);
            __playList = __songs;
            init();
        }).whenComplete((){
            notifyListeners();
            if(onLoadingfinished != null){
                onLoadingfinished!();
            }
        });
    }

    Future<bool> storagePermission() async {
        final DeviceInfoPlugin info = DeviceInfoPlugin(); // import 'package:device_info_plus/device_info_plus.dart';
        final AndroidDeviceInfo androidInfo = await info.androidInfo;
        
        debugPrint('releaseVersion : ${androidInfo.version.release}');
        final int androidVersion = int.parse(androidInfo.version.release);
        bool havePermission = false;

        if (androidVersion >= 13) {
          final request = await [
            Permission.audio,
          ].request(); //import 'package:permission_handler/permission_handler.dart';

          havePermission = request.values.every((status) => status == PermissionStatus.granted);
        } else {
          final status = await Permission.storage.request();
          havePermission = status.isGranted;
        }

        if (!havePermission) {
          // if no permission then open app-setting
          havePermission = await openAppSettings();
        }

        return havePermission;
    }

    Future<Iterable<SongModel>> __fetchSongs() async{
        bool permissionStatus = await storagePermission();
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
		    
        return await find(audioQuery);
    }

    Future<Iterable<SongModel>> find(OnAudioQuery audioQuery) async{
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

    Future<void> init() async {
        player.onPlayerStateChanged.listen((state) {
            switch(state){
                case PlayerState.playing:
                  break;
                case PlayerState.completed:
                  next();
                  break;
                case PlayerState.paused:
                  break;
                case PlayerState.stopped:
                  break;
                case PlayerState.disposed:
                  break;
            }
            notifyListeners();
        });

        player.onDurationChanged.listen((event) { 
            __duration = event;
            notifyListeners();
        });

        player.onPositionChanged.listen((event) {
            __position = event;
            notifyListeners();
        });

        if(__songs.isNotEmpty){
            await player.setSource((DeviceFileSource((current as SongModel).data)));
            __initPlayMode();
        }
    }

    Future<void> togglePlay() async{
        if(player.state == PlayerState.playing){
            await player.pause();
        }else {
            await player.resume();
        }
        notifyListeners();
    }

    Future<void> __play() async{
        if(current != null){
            await player.stop();
            await player.play(DeviceFileSource((current as SongModel).data));
            notifyListeners();
        }
    }

    void next(){
        if(playMode != PlayMode.single && __curentIndex + 1 < __playList.length){
            __curentIndex+= 1;
        }
        __play();
    }

    void prev(){
        if(playMode != PlayMode.single && __curentIndex - 1 > 0){
            __curentIndex -= 1;
        }
        __play();
    }

    @override
    void dispose() {
        player.dispose();
        super.dispose();
    }
}