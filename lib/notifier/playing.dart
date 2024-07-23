import 'package:audioplayers/audioplayers.dart';
import 'package:bmusic/notifier/settings.dart';
import 'package:bmusic/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

enum RepeatMode{ single, all, off }
enum ShuffleMode{ on, off }

class PlayingStateNotifier extends ChangeNotifier {
    final SettingsNotifier __settingsNotifier;
    List<SongModel> __playList = [];

    List<SongModel> get songs => __settingsNotifier.songs;
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
            __curentIndex = __settingsNotifier.songs.indexOf(songModel);
            __initShuffleMode();
            __play();
        }
    }

    void setFromPlaylist(SongModel songModel){
        __curentIndex = __playList.indexOf(songModel);
        __play();
    }

    RepeatMode __repeatMode = RepeatMode.all;
    RepeatMode get repeatMode => __repeatMode;
    void toggleRepeatMode(){
        switch(__repeatMode){
            case RepeatMode.single:
                __repeatMode = RepeatMode.all;
                break;
            case RepeatMode.all:
              __repeatMode = RepeatMode.off;
              break;
            case RepeatMode.off:
              __repeatMode = RepeatMode.single;
              break;
        }
        notifyListeners();
    }

    ShuffleMode __shuffleMode = ShuffleMode.off;
    ShuffleMode get shuffleMode => __shuffleMode;
    void __initShuffleMode(){
        switch(__shuffleMode){
            case ShuffleMode.off:
                __curentIndex = __settingsNotifier.songs.indexOf(current!);
                __playList = __settingsNotifier.songs;
                notifyListeners();
                break;
            case ShuffleMode.on:
              Util.shuffle(__settingsNotifier.songs, current!).then((list){
                  __playList = list;
                  __curentIndex = 0;
                  notifyListeners();
              });
              break;
        }
    }
    void toggleShuffleMode(){
        __shuffleMode = __shuffleMode == ShuffleMode.off ? ShuffleMode.on : ShuffleMode.off;
        __initShuffleMode();
        notifyListeners();
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

    PlayingStateNotifier({ required SettingsNotifier settingsNotifier }): __settingsNotifier = settingsNotifier{
        __playList = __settingsNotifier.songs;
        init().whenComplete(()=> notifyListeners());
    }

    Future<void> init() async {
        player.onPlayerStateChanged.listen((state) {
            switch(state){
                case PlayerState.playing:
                  break;
                case PlayerState.completed:
                  if(repeatMode != RepeatMode.off){
                      next();
                  }
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

        if(__settingsNotifier.songs.isNotEmpty){
            await player.setSource((DeviceFileSource((current as SongModel).data)));
            __initShuffleMode();
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
        if(repeatMode != RepeatMode.single){
            if(__curentIndex + 1 < __playList.length){
                __curentIndex+= 1;
            }else{
                __curentIndex = 0;
            }
        }
        __play();
    }

    void prev(){
        if(repeatMode != RepeatMode.single){
              if( __curentIndex - 1 > 0){
                  __curentIndex -= 1;
              }else{
                  __curentIndex = __playList.length - 1;
              }
        }
        __play();
    }

    @override
    void dispose() {
        player.dispose();
        super.dispose();
    }
}