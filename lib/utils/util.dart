import 'dart:async';
import 'dart:io';
import 'dart:developer' show log;
import 'dart:math' show Random;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query_pluse/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

TextTheme createTextTheme(
    BuildContext context, String bodyFontString, String displayFontString) {
      TextTheme baseTextTheme = Theme.of(context).textTheme;
      TextTheme bodyTextTheme = GoogleFonts.getTextTheme(bodyFontString, baseTextTheme);
      TextTheme displayTextTheme = GoogleFonts.getTextTheme(displayFontString, baseTextTheme);
      TextTheme textTheme = displayTextTheme.copyWith(
          bodyLarge: bodyTextTheme.bodyLarge, bodyMedium: bodyTextTheme.bodyMedium, bodySmall: bodyTextTheme.bodySmall,
          labelLarge: bodyTextTheme.labelLarge, labelMedium: bodyTextTheme.labelMedium,labelSmall: bodyTextTheme.labelSmall);
          
      return textTheme;
}

class Util{
    static String folderName(FileSystemEntity directory){
        List<String> init = directory.toString().split("/");
        return init.last;
    }

    static String folder(String path){
        List<String> inits = path.toString().split("/");

        return inits[inits.length - 2];
    }

    static String musicName(FileSystemEntity file){
        List<String> inits = file.toString().split("/");

        return inits.last.substring(0, inits.last.length - 5);
    }

    static String displayDuration(int duration){
        int seconds = duration % 60;
        int minutes = (duration / 60).floor();

        return "${minutes > 9 ? minutes : '0$minutes'}:${seconds > 9 ? seconds : '0$seconds'}";
    }

    static Future<List<T>> shuffle<T>(List<T> input, T? first ) async{
        List<T> init = [];
        List<T> clone = List.from(input);

        Random random = Random();

        int index = first != null ? input.indexOf(first) : random.nextInt(clone.length);
        do {
            init.add(clone[index]);
            clone.removeAt(index);

            index = clone.isNotEmpty ? random.nextInt(clone.length) : 0;
        } while (clone.isNotEmpty);

        return init;
    }

    static Future<bool> storagePermission() async {
        final DeviceInfoPlugin info = DeviceInfoPlugin();
        final AndroidDeviceInfo androidInfo = await info.androidInfo;

        log('releaseVersion : ${androidInfo.version.release}');
        final int androidVersion = int.parse(androidInfo.version.release);

        bool havePermission = false;
        if (androidVersion >= 13) {
            final request = await [ Permission.audio ].request();

            havePermission = request.values.every((status) => status == PermissionStatus.granted || status == PermissionStatus.limited || status == PermissionStatus.provisional);
        } else {
            final request = await [Permission.storage ].request();

            havePermission = request.values.every((status) => status == PermissionStatus.granted || status == PermissionStatus.limited || status == PermissionStatus.provisional);
        }

        if (!havePermission) {
            havePermission = await openAppSettings();
        }
        return havePermission;
    }
} 

class Category extends Equatable{
    final SongModel songModel;
    final int index;

    const Category({ required this.index, required this.songModel });
    
    @override
    List<Object?> get props => [ songModel, index ];
}