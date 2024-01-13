import 'package:bmusic/notifier/playing.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class GenreNotifier extends ChangeNotifier{
    Map<String, List<SongModel>> __genre ={};
    Map<String, List<SongModel>> get genre =>__genre;
    List<String> get genreNames  => __genre.keys.toList();
    List songs(String folder) => __genre[folder]!;

    final PlayingStateNotifier __songNotifier;

    GenreNotifier({required PlayingStateNotifier songNotifier}): __songNotifier = songNotifier{
      init();
    }

    Future<void> init() async{
        __genre=  await Future<Map<String, List<SongModel>>>((){
            Map<String, List<SongModel>> init ={};
            for (var model in __songNotifier.songs) {
              if(init.containsKey(model.genre)){
                init[model.genre ?? "unknown"]?.add(model);
              }else{
                init[model.genre ?? "unknown"] = [model];
              }
            }
            return init;
        });
        notifyListeners();
    }
}