import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:bmusic/blocs/states/playing_state.dart';
import 'package:bmusic/blocs/states/status.dart';
import 'package:bmusic/repositories/models/music.dart';
import 'package:bmusic/utils/util.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class PlayingBloc extends HydratedCubit<PlayingState>{
    Map<int, Music> __songs = {};
    late List<int> __playList;

    List<void Function(int)> durationListeners = [], positionListeners = [];
    int lastDuration = 0, lastPosition = 0;

    final player = AudioPlayer();

    void Function(int)? __finishedPlaying;
    set finishedPlaying(void Function(int)? init)=> __finishedPlaying = init;

    bool get hasExistingData => HydratedBloc.storage.read(runtimeType.toString()) != null;

    PlayingBloc(): super(const PlayingState()){
        player.onPlayerStateChanged.listen((s) {
            switch(s){
                case PlayerState.playing:
                  emit(state.copy(playing: true));
                  break;
                case PlayerState.completed:
                  emit(state.copy(playing: false));
                  __finishedPlaying?.call(state.current!);
                  if(state.repeatMode != RepeatMode.off){
                      next();
                  }
                  break;
                case PlayerState.paused:
                  emit(state.copy(playing: false));
                  break;
                case PlayerState.stopped:
                  emit(state.copy(playing: false));
                  break;
                case PlayerState.disposed:
                  emit(state.copy(playing: false));
                  break;
            }
        });

        player.onDurationChanged.listen((event){
            if(lastDuration != event.inSeconds){
                for(final listener in durationListeners){
                    listener(event.inSeconds);
                }
                lastDuration = event.inSeconds;
            }
        });

        player.onPositionChanged.listen((event){
            if(lastPosition != event.inSeconds){
                for(final listener in positionListeners){
                    listener(event.inSeconds);
                }
                lastPosition = event.inSeconds;
            }
        });
    }

    void init(Map<int, Music> songs){
        __songs = songs;
        if(songs.isNotEmpty){
            __playList = songs.keys.toList();
            emit(state.copy(message: "Initializing playlist", status: StateStatus.loading, playList: __playList));
            if(songs.isNotEmpty){
                final song = songs[state.current];
                if(song is LocalMusic){
                    player.setSource(DeviceFileSource(song.data));
                }else if(song is OnlineMusic){
                    player.setSource(UrlSource(song.path));
                }
                __initShuffleMode();
            }
            emit(state.copy(status: StateStatus.success));
        }
    }

    set seek(int seconds){
        Duration position = Duration(seconds: seconds);
        player.seek(position).then((value){
            for(final listener in positionListeners){
                listener(position.inSeconds);
            }
            lastPosition = position.inSeconds;
        });
    }

    Future<void> swap(int oldIndex, int newIndex) async {
        final playlist = List<int>.from(state.playList);
        int currentIndex = state.index;

        if (oldIndex < newIndex) {
            newIndex -= 1;
        }
        final song = playlist.removeAt(oldIndex);
        playlist.insert(newIndex, song);

        if (currentIndex == oldIndex) {
            // The playing song was moved - track its new position
            currentIndex = newIndex;
        } else if (oldIndex < currentIndex && newIndex >= currentIndex) {
            // Song was moved from before to after current - decrement
            currentIndex = currentIndex - 1;
        } else if (oldIndex > currentIndex && newIndex <= currentIndex) {
            // Song was moved from after to before current - increment
            currentIndex = currentIndex + 1;
        }

        emit(state.copy(playList: playlist, index: currentIndex));
    }

    void addDurationListener(void Function(int) listener){
        if(!durationListeners.contains(listener)){
            durationListeners.add(listener);
        }
    }

    void addPositionListener(void Function(int) listener){
        if(!positionListeners.contains(listener)){
            positionListeners.add(listener);
        }
    }

    void pick({ List<int>? playlist, required int song }){
        if(playlist != null){
            __playList = List.from(playlist);
            int currentIndex = __playList.indexOf(song);
            emit(state.copy(index: currentIndex, playList: __playList));
            __initShuffleMode(initialize: false);
        }else{
            emit(state.copy(index:  state.playList.indexOf(song)));
        }
        __play();
    }

    void toggleRepeatMode(){
        switch(state.repeatMode){
            case RepeatMode.single:
                emit(state.copy(repeatMode: RepeatMode.all));
                break;
            case RepeatMode.all:
                emit(state.copy(repeatMode: RepeatMode.off));
              break;
            case RepeatMode.off:
                emit(state.copy(repeatMode: RepeatMode.single));
              break;
        }
    }

    void __initShuffleMode({ bool initialize = true }){
        switch(state.shuffleMode){
            case ShuffleMode.off:
                if(initialize){
                    emit(state.copy(index: __playList.indexOf(state.current!), playList: __playList));
                }
                break;
            case ShuffleMode.on:
                Util.shuffle(__playList, state.current).then((list){
                    emit(state.copy(playList: list, index: 0));
                });
                break;
        }
    }

    void toggleShuffleMode(){
        emit(state.copy(shuffleMode: state.shuffleMode == ShuffleMode.off ? ShuffleMode.on : ShuffleMode.off));
        __initShuffleMode();
    }

    Future<void> togglePlay() async{
        if(player.state == PlayerState.playing){
            await player.pause();
        }else {
            await player.resume();
        }
        emit(state.copy(playing: player.state == PlayerState.playing));
    }

    Future<void> __play() async{
        if(state.current != null){
            await player.stop();

            final song = __songs[state.current];
            if(song is LocalMusic){
                player.play(DeviceFileSource(song.data));
            }else if(song is OnlineMusic){
                player.play(UrlSource(song.path));
            }
            emit(state.copy(playing: player.state == PlayerState.playing));
        }
    }

    void next(){
        if(state.repeatMode != RepeatMode.single){
            if(state.index + 1 < state.playList.length){
                emit(state.copy(index: state.index + 1));
            }else{
                emit(state.copy(index: 0));
            }
        }
        __play();
    }

    void prev(){
        if(state.repeatMode != RepeatMode.single){
              if(state.index - 1 > 0){
                  emit(state.copy(index: state.index - 1));
              }else{
                  emit(state.copy(index: state.playList.length - 1));
              }
        }
        __play();
    }
    
    @override
    PlayingState? fromJson(Map<String, dynamic> json) {
        try{
            return PlayingState.fromJson(json);
        }catch(err){
            log("Playing State deserialization error", error: err);
        }
        return null;
    }
    
    @override
    Map<String, dynamic>? toJson(PlayingState state) {
        try{
            return state.toJson();
        }catch(err){
            log("Playing State serialization error", error: err);
        }
        return null;

    }
}