import 'package:bmusic/notifier/playing.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AlbumsNotifier extends ChangeNotifier{
    Map<String, List<SongModel>> __albums ={};
    Map<String, List<SongModel>> get albums =>__albums;
    List<String> get albumsTitles  => __albums.keys.toList();
    List songs(String album) => __albums[album]!;

    final PlayingStateNotifier __songNotifier;

    AlbumsNotifier({required PlayingStateNotifier songNotifier}): __songNotifier = songNotifier{
      init();
    }

    Future<void> init() async{
        __albums=  await Future<Map<String, List<SongModel>>>((){
            Map<String, List<SongModel>> init ={};
            __songNotifier.songs.forEach((model) {
              if(init.containsKey(model.album)){
                init[model.album ?? "unknown"]?.add(model);
              }else{
                init[model.album ?? "unknown"] = [model];
              }
            });
            return init;
        });
        notifyListeners();
    }
}