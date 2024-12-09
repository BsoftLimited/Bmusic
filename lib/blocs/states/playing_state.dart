import 'dart:convert';

import 'package:bmusic/blocs/states/status.dart';
import 'package:equatable/equatable.dart';

enum RepeatMode{ single, all, off }
extension RepeatModeX on RepeatMode {
    String get serialize{
        switch(this){
            case RepeatMode.single:
                return "single";
            case RepeatMode.all:
                return "all";
            case RepeatMode.off:
                return "off";
        }
    }
}

extension RepeatModesString on String {
    RepeatMode get toRepeatMode{
        switch(toLowerCase()){
            case "single":
                return RepeatMode.single;
            case "all":
                return RepeatMode.all;
            default:
                return RepeatMode.off;
        }
    }
}

enum ShuffleMode{ on, off }
extension ShuffleModeX on ShuffleMode {
    String get serialize{
        switch(this){
            case ShuffleMode.on:
                return "on";
            case ShuffleMode.off:
                return "off";
        }
    }
}

extension ShuffleModeString on String {
    ShuffleMode get toShuffleMode{
        switch(toLowerCase()){
            case "on":
                return ShuffleMode.on;
            default:
                return ShuffleMode.off;
        }
    }
}

class PlayingState extends Equatable{
    final List<int> playList, favourites;
    final RepeatMode repeatMode;
    final ShuffleMode shuffleMode;
    final Duration duration, position;
    final bool playing;
    final Map<String, List<int>> albums;
    final Map<String, List<int>> artists;
    final Map<String, List<int>> folders;

    final StateStatus status;
    final String message;

    List<String> get artistNames  => artists.keys.toList();
    List<String> get albumsTitles  => albums.keys.toList();
    List<String> get folderNames  => folders.keys.toList();

    final int index;
    int? get current{
        if(index < playList.length){
            return playList[index];
        }
        return null;
    }

    const PlayingState({
        this.favourites = const[], this.playList = const [], this.index = 0, this.playing = false, 
        this.albums = const {}, this.artists = const {}, this.folders = const {}, this.status = StateStatus.initial, this.message = "",
        this.duration = Duration.zero, this.position = Duration.zero, this.repeatMode = RepeatMode.all, this.shuffleMode = ShuffleMode.off });

    factory PlayingState.fromJson(dynamic json) {
        return PlayingState(favourites: json["favourites"], index: json["index"], duration: Duration.zero, position: Duration.zero, repeatMode: json["repeatMode"].toString().toRepeatMode, shuffleMode: json["shuffleMode"].toString().toShuffleMode);
    }
    
    PlayingState copy({ String? message, List<int>? playList, List<int>? favourites, Map<String, List<int>>? albums, Map<String, List<int>>? artists, StateStatus? status, bool? playing,  int? index, RepeatMode? repeatMode, ShuffleMode? shuffleMode, Duration? duration, Duration? position }){
        return PlayingState(
            message: message ?? this.message,
            playList: playList ?? this.playList,
            albums: albums ?? this.albums,
            artists: artists ?? this.artists,
            favourites: favourites ?? this.favourites,
            playing: playing ?? this.playing,
            index: index ?? this.index,
            status: status ?? this.status,
            repeatMode: repeatMode ?? this.repeatMode,
            shuffleMode: shuffleMode ?? this.shuffleMode,
            duration: duration ?? this.duration,
            position: position ?? this.position
        );
    }

    Map<String, dynamic> toJson() => { "favourites": favourites, "index": index, "repeatMode": repeatMode.serialize, "shuffleMode": shuffleMode.serialize };

    String serialize() => jsonEncode(toJson());

    @override
    List<Object?> get props => [ playList, playing, albums, artists, favourites, index, repeatMode, shuffleMode, duration, position ];
}