import 'package:bmusic/notifier/playing.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AlbumsNotifier extends ChangeNotifier{
    Map<String, List<SongModel>> __albums ={};
    Map<String, List<SongModel>> get albums =>__albums;
    List<String> get albumsTitles  => __albums.keys.toList();

    List<SongModel> songs(String album) => __albums[album]!;

    bool __loading = true;
    bool get loading => __loading;

    AlbumsNotifier({required PlayingStateNotifier songNotifier}){
        Future<Map<String, List<SongModel>>>((){
            Map<String, List<SongModel>> init ={};
            for (final model in songNotifier.songs) {
                if(init.containsKey(model.album)){
                    init[model.album ?? "unknown"]?.add(model);
                }else{
                    init[model.album ?? "unknown"] = [model];
                }
            }
            return init;
        }).then((albums)=> __albums = albums).whenComplete((){
            __loading = false;
            notifyListeners();
        });
    }
}