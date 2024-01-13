import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

enum PlayMode{ single, sequence, shuffle }

class PlayingStateNotifier extends ChangeNotifier {
    final List<SongModel> __songs = [];
    List<SongModel> get songs => __songs;

    final player = AudioPlayer();

    Function? onLoadingfinished;

    
    bool get playing => player.state == PlayerState.playing ;
    bool get repeat => player.releaseMode == ReleaseMode.loop;

    Duration __duration = Duration.zero, __position = Duration.zero;
    Duration get duration => __duration;
    Duration get position => __position; 

    int __curentIndex = 0;
    int get curentIndex => __curentIndex;

    SongModel get current => __songs[__curentIndex];
    void setCurrent(int index){
      if(index > 0 && index < __songs.length - 1 ){
        player.play(UrlSource(__songs[__curentIndex].uri!)).then((value){
            notifyListeners();
        }).catchError((error){
            log(error);
        });
      }
    }

    PlayMode __playMode = PlayMode.sequence;
    PlayMode get playMode => __playMode;
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
        notifyListeners();
    }

    final Map<int, SongModel> __favourites = {};
    Map<int, SongModel> get favourite => __favourites;
    bool isFavourite(SongModel songModel) => __favourites.containsKey(songModel.id);
    void toggleFavourite(SongModel songModel){
      if(__favourites.containsKey(songModel.id)){
          __favourites.remove(songModel.id);
      }else{
          __favourites[songModel.id] = songModel;
      }
      notifyListeners();
    }

    PlayingStateNotifier(){
        OnAudioQuery audioQuery = OnAudioQuery();
    		audioQuery.permissionsStatus().then((permissionStatus) {
		        if (!permissionStatus) {
		            audioQuery.permissionsRequest();
		        }
		        find(audioQuery);
		    });
    }

    void find(OnAudioQuery audioQuery){
        audioQuery.querySongs( sortType: SongSortType.DISPLAY_NAME, orderType: OrderType.ASC_OR_SMALLER, uriType: UriType.EXTERNAL, ignoreCase: true).then((songs){
            __songs.addAll(songs);
        }).catchError((error){
            log('Error: $error');
        }).whenComplete((){
            init();
            if(onLoadingfinished != null){
              onLoadingfinished!();
            }
        });
    }

    void init(){
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
    }

    void togglePlay(){
        if(player.state == PlayerState.playing){
            player.pause();
        }else{
            player.resume();
        }
        notifyListeners();
    }

    void next(){
      if(player.releaseMode != ReleaseMode.loop && __curentIndex + 1 < __songs.length){
          __curentIndex+= 1;
          player.play(DeviceFileSource(__songs[__curentIndex].uri!));
      }
      notifyListeners();
    }

    void prev(){
      if(__curentIndex - 1 > 0){
          __curentIndex-= 1;
          player.play(DeviceFileSource(__songs[__curentIndex].uri!));
      }
      notifyListeners();
    }

    @override
    void dispose() {
      player.dispose();
      super.dispose();
    }
}