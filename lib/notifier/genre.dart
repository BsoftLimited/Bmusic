import 'package:bmusic/notifier/playing.dart';
import 'package:bmusic/utils/util.dart';
import 'package:flutter/material.dart';

class GenreNotifier extends ChangeNotifier{
    Map<String, List<Category>> __genre ={};
    Map<String, List<Category>> get genre =>__genre;
    List<String> get genreNames  => __genre.keys.toList();

    List<Category> songs(String folder) => __genre[folder]!;

    GenreNotifier({required PlayingStateNotifier songNotifier}){
        Future<Map<String, List<Category>>>((){
            Map<String, List<Category>> init ={};
            for (final model in songNotifier.songs.indexed) {
                if(init.containsKey(model.$2.artist)){
                    init[model.$2.genre ?? "unknown"]?.add(Category(index: model.$1, songModel: model.$2));
                }else{
                    init[model.$2.genre ?? "unknown"] = [Category(index: model.$1, songModel: model.$2)];
                }
            }
            return init;
        }).then((genres)=> __genre = genres).whenComplete(()=> notifyListeners());
    }
}