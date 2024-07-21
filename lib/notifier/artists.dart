import 'package:bmusic/notifier/playing.dart';
import 'package:bmusic/utils/util.dart';
import 'package:flutter/material.dart';

class ArtistNotifier extends ChangeNotifier{
    Map<String, List<Category>> __artists ={};
    Map<String, List<Category>> get artists =>__artists;
    List<String> get artistNames  => __artists.keys.toList();
    List<Category> songs(String artist) => __artists[artist]!;

    bool __loading = true;
    bool get loading => __loading;

    ArtistNotifier({required PlayingStateNotifier songNotifier}){
        Future<Map<String, List<Category>>>((){
            Map<String, List<Category>> init ={};
            for (final model in songNotifier.songs.indexed) {
                if(init.containsKey(model.$2.artist)){
                    init[model.$2.artist ?? "unknown"]?.add(Category(index: model.$1, songModel: model.$2));
                }else{
                    init[model.$2.artist ?? "unknown"] = [Category(index: model.$1, songModel: model.$2)];
                }
            }
            return init;
        }).then((artists)=> __artists = artists).whenComplete((){
            __loading = false;
            notifyListeners();
        });
    }
}