import 'package:bmusic/notifier/playing.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ArtistNotifier extends ChangeNotifier{
    Map<String, List<SongModel>> __artists ={};
    Map<String, List<SongModel>> get artists =>__artists;
    List<String> get artistNames  => __artists.keys.toList();
    List songs(String artist) => __artists[artist]!;

    final PlayingStateNotifier __songNotifier;

    ArtistNotifier({required PlayingStateNotifier songNotifier}): __songNotifier = songNotifier{
      init();
    }

    Future<void> init() async{
        __artists=  await Future<Map<String, List<SongModel>>>((){
            Map<String, List<SongModel>> init ={};
            for (var model in __songNotifier.songs) {
              if(init.containsKey(model.artist ?? "unknown")){
                init[model.artist]?.add(model);
              }else{
                init[model.artist ?? "unknown"] = [model];
              }
            }
            return init;
        });
        notifyListeners();
    }
}