import 'dart:convert';
import 'dart:typed_data';

import 'package:bmusic/blocs/states/status.dart';
import 'package:bmusic/repositories/models/details.dart';
import 'package:bmusic/repositories/models/music.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
    final Map<int, Music> songs;
    final StateStatus status;
    final String message;
    final LoginDetail? detail;

    const SettingsState({ this.detail, this.message = "", this.themeMode = ThemeMode.system, this.songs = const {}, this.status = StateStatus.initial });

    factory SettingsState.fromJson(dynamic json) {
        return SettingsState(message: json["message"], detail: LoginDetail.fromJson(json["detail"]), themeMode: json["themeMode"].toString().toThemeMode);
    }

    SettingsState copy({ StateStatus? status, String? message, LoginDetail? detail, ThemeMode? themeMode, Map<int, Music>? songs }){
        return SettingsState(
            themeMode: themeMode ?? this.themeMode,
            detail: detail ?? this.detail,
            songs: songs ?? this.songs,
            message: message ?? this.message,
            //background: background ?? this.background,
            status: status ?? this.status
        );
    }

    Map<String, dynamic> toJson() => { "message": message, "detail": detail?.toJson(), "themeMode" : themeMode.serialize };

    String serialize() => jsonEncode(toJson());

    @override
    List<Object?> get props => [themeMode, detail, songs, status, message ];
}