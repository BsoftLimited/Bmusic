import 'dart:convert';
import 'dart:typed_data';

import 'package:bmusic/blocs/states/status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

extension ThemeModeX on ThemeMode{
    String get serialize{
        switch(this){
            case ThemeMode.light:
                return "light";
            case ThemeMode.dark:
                return "dark";
            case ThemeMode.system:
                return "system";
        }
    }
}

extension ThemeModeXString on String{
    ThemeMode get toThemeMode{
        switch(toLowerCase()){
            case "light":
                return ThemeMode.light;
            case "dark":
                return ThemeMode.dark;
            default:
                return ThemeMode.system;
        }
    }
}

class SettingsState extends Equatable{
    final ThemeMode themeMode;
    final int? lastSong;
    final Map<int, SongModel> songs;
    final StateStatus status;
    final Uint8List? background;
    final String message;

    const SettingsState({ this.background, this.message = "", this.themeMode = ThemeMode.system, this.lastSong, this.songs = const {}, this.status = StateStatus.initial });

    factory SettingsState.fromJson(dynamic json) {
        return SettingsState(message: json["message"], background: json["background"], themeMode: json["themeMode"].toString().toThemeMode, lastSong: json["lastSong"], status: json["status"].toString().toStatus);
    }

    SettingsState copy({ StateStatus? status, String? message, Uint8List? background, ThemeMode? themeMode, int? lastSong, Map<int,SongModel>? songs }){
        return SettingsState(
            themeMode: themeMode ?? this.themeMode,
            lastSong: lastSong ?? this.lastSong ,
            songs: songs ?? this.songs,
            message: message ?? this.message,
            background: background ?? this.background,
            status: status ?? this.status
        );
    }

    Map<String, dynamic> toJson() => { "message": message, "background": background, "themeMode" : themeMode.serialize, "lastSong": lastSong, "status": status.serialize };

    String serialize() => jsonEncode(toJson());

    @override
    List<Object?> get props => [themeMode, lastSong, songs, status, background, message ];
}