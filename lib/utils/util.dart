import 'dart:io';

class Util{
    static String folderName(FileSystemEntity directory){
      List<String> inits = directory.toString().split("/");
      return inits.last; 
    }

    static String folder(String path){
      List<String> inits = path.toString().split("/");
      return inits[inits.length - 2]; 
    }

    static String musicName(FileSystemEntity file){
       List<String> inits = file.toString().split("/");
      return inits.last.substring(0, inits.last.length - 5); 
    }
}