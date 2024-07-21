import 'package:bmusic/notifier/playing.dart';
import 'package:bmusic/utils/util.dart';
import 'package:flutter/material.dart';

class AlbumsNotifier extends ChangeNotifier{
    Map<String, List<Category>> __albums ={};
    Map<String, List<Category>> get albums =>__albums;
    List<String> get albumsTitles  => __albums.keys.toList();

    List<Category> songs(String album) => __albums[album]!;

    bool __loading = true;
    bool get loading => __loading;

    AlbumsNotifier({required PlayingStateNotifier songNotifier}){
        Future<Map<String, List<Category>>>((){
            Map<String, List<Category>> init ={};
            for (final model in songNotifier.songs.indexed) {
                if(init.containsKey(model.$2.album)){
                    init[model.$2.album ?? "unknown"]?.add(Category(index: model.$1, songModel: model.$2));
                }else{
                    init[model.$2.album ?? "unknown"] = [Category(index: model.$1, songModel: model.$2)];
                }
            }
            return init;
        }).then((albums)=> __albums = albums).whenComplete((){
            __loading = false;
            notifyListeners();
        });
    }
}