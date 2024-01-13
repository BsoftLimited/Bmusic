import 'package:flutter/material.dart';

class CustomTheme{
    late Color primary, primaryDark, secondary, secondaryDark, light, dark;
}

class LightTheme extends CustomTheme{
    LightTheme(){
        primary = const Color.fromRGBO(33, 150, 243, 1);
        primaryDark = const Color.fromRGBO(12, 98, 168, 1);
        secondary =  const Color.fromARGB(255, 245, 160, 94);
        secondaryDark =  const Color.fromARGB(255, 168, 81, 14);

        dark = Colors.black45;
        light = Colors.white10;
    }
}

class DarkTheme extends CustomTheme{
    DarkTheme(){
        primary = Colors.blue;
        primaryDark = const Color.fromARGB(255, 12, 98, 168);

        secondary =  const Color.fromARGB(255, 245, 160, 94);
        secondaryDark =  const Color.fromARGB(255, 168, 81, 14);

        light = Colors.black45;
        dark = Colors.white10;
    }
}

enum CustomThemeType{ Light, Dark }

class ThemeNotifier extends ChangeNotifier{
    final LightTheme __light = LightTheme();
    final DarkTheme __dark = DarkTheme();

    CustomThemeType __type = CustomThemeType.Light;

    void setTheme(CustomThemeType type){
        __type = type;
        notifyListeners();
    }
    CustomTheme get current   => __type == CustomThemeType.Light ? __light : __dark;
}