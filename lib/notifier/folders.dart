import 'package:bmusic/notifier/playing.dart';
import 'package:bmusic/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FoldersNotifier extends ChangeNotifier{
    Map<String, List<SongModel>> __folders ={};
    Map<String, List<SongModel>> get folders =>__folders;
    List<String> get folderNames  => __folders.keys.toList();
    List songs(String folder) => __folders[folder]!;

    PlayingStateNotifier __songNotifier;

    FoldersNotifier({required PlayingStateNotifier songNotifier}): __songNotifier = songNotifier{
      init();
    }

    Future<void> init() async{
        __folders=  await Future<Map<String, List<SongModel>>>((){
            Map<String, List<SongModel>> init ={};
            for (var model in __songNotifier.songs) {
              String folderName = Util.folder(model.uri!);
              if(init.containsKey(folderName)){
                init[folderName]?.add(model);
              }else{
                init[folderName] = [model];
              }
            }
            return init;
        });
        notifyListeners();
    }
}