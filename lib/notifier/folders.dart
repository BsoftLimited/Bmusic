import 'package:bmusic/notifier/playing.dart';
import 'package:bmusic/utils/util.dart';
import 'package:flutter/material.dart';

class FoldersNotifier extends ChangeNotifier{
    Map<String, List<Category>> __folders ={};
    Map<String, List<Category>> get folders =>__folders;
    List<String> get folderNames  => __folders.keys.toList();

    List<Category> songs(String folder) => __folders[folder]!;

    FoldersNotifier({required PlayingStateNotifier songNotifier}){
        Future<Map<String, List<Category>>>((){
            Map<String, List<Category>> init ={};
            for (final model in songNotifier.songs.indexed) {
                String folderName = Util.folder(model.$2.uri!);
                if(init.containsKey(folderName)){
                    init[folderName]?.add(Category(index: model.$1, songModel: model.$2));
                }else{
                    init[folderName] = [Category(index: model.$1, songModel: model.$2)];
                }
            }
            return init;
        }).then((folders)=> __folders = folders).whenComplete(()=> notifyListeners());
    }
}