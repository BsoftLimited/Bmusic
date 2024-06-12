import 'dart:io';
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
}

class Category{
    final SongModel __songModel;
    SongModel get songModel => __songModel;

    final int __index;
    int get index => __index;

    Category({ required int index, required SongModel songModel }): __index = index, __songModel = songModel;
}