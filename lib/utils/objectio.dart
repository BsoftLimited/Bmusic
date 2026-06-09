 import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';


class ObjectIO {
    String folder;

    ObjectIO({this.folder = "", });

    Future<String> get __localPath async {
        Directory directory = await getApplicationDocumentsDirectory();
        return directory.path;
    }

    Future<File> __file(String fileName) async{
        String init = folder.isEmpty ? fileName : "$folder/$fileName";
        String path = await __localPath;
        File file = File("$path/$init");
        return file.exists().then<File>((value) async{
            if(value){
                return file;
            }
            return await file.create(recursive: true);
        });
    }

    Future<File> writeToFile(String file, String contents) async{
        File init = await __file(file);
        return init.writeAsString(contents);
    }

    Future<String> readFromFile(String file) async{
        try{
            File init = await __file(file);
            return init.readAsString();
        }catch(e){
            log(e.toString());
            return "";
        }
    }
}