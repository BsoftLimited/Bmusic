import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';

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
      List<String> inits = directory.toString().split("/");
      return inits.last; 
    }

    static String folder(String path){
      List<String> inits = path.toString().split("/");
      return inits[inits.length - 2]; 
    }

    static String musicName(FileSystemEntity file){
       List<String> inits = file.toString().split("/");
      return inits.last.substring(0, inits.last.length - 5); 
    }

    static String displayDuration(Duration duration){
        int totalSeconds = duration.inSeconds;

        int seconds = totalSeconds % 60;
        int minutes = (totalSeconds / 60).floor();

        return "${minutes > 9 ? minutes : '0$minutes'}:${seconds > 9 ? seconds : '0$seconds'}";
    }

    static Future<List<T>> shuffle<T>(List<T> input, T? first ) async{
        List<T> init = [];
        List<T> clone = List.from(input);

        Random random = Random();
        int index = first != null ? input.indexOf(first) : random.nextInt(clone.length);

        do {
            if(index >= 0){
                init.add(clone[index]);
                clone.removeAt(index);
            }
            index = clone.isNotEmpty ? random.nextInt(clone.length) : 0;
        } while (clone.isNotEmpty);

        return init;
    }
} 

class Category extends Equatable{
    final SongModel songModel;
    final int index;

    const Category({ required this.index, required this.songModel });
    
    @override
    List<Object?> get props => [ songModel, index ];
}