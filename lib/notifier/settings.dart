import 'dart:convert';
import 'dart:developer';

import 'package:bmusic/utils/objectio.dart';
import 'package:flutter/material.dart';

class Settings {
    String themeMode;

    Settings({ this.themeMode = "auto" });

    factory Settings.fromJson(dynamic json) {
        return Settings( themeMode: json["themeMode"] as String);
    }

    Map toJson() => { "themeMode" : themeMode };

    String serialize() => jsonEncode(toJson());
}

class SettingsNotifier extends ChangeNotifier{
    Settings __settings = Settings();

    String get themeMode => __settings.themeMode;
    ThemeMode get themeModeValue{
        switch(__settings.themeMode){
            case "light":
                return ThemeMode.light;
            case "dark":
                return ThemeMode.dark;
        }
        return ThemeMode.system;
    }

    SettingsNotifier(){
        find().then((value){
            __settings = value;
            notifyListeners();
        });
    }

    void setThemeMode(String mode){
        if(__settings.themeMode != mode){
            __settings.themeMode = mode;
            notifyListeners();
            save();
        }
    }

    static Future<Settings> find() async{
        try{
            ObjectIO objectIO = ObjectIO(folder: "data");
            String savedObject = await objectIO.readFromFile("settings");

            return Settings.fromJson(jsonDecode(savedObject));
        }catch(error){
            log("retrieving saved setting exception:", error: error);
            //throw Exception("encountered an error when retrieving saved settings");
        }
        return Settings();
    }

    Future<void> save() async{
        try{
            ObjectIO objectIO = ObjectIO(folder: "data");
            objectIO.writeToFile("settings", jsonEncode(__settings));
        }catch(error){
            log("Settings save error:", error: error);
        }
    }
}