import 'package:uno/uno.dart';

const apiKey = "5339176bef3c8725c8a9c64ccb7d985f";

class Connections{
    static String imageSrc(String name) => "https://openweathermap.org/img/wn/${name}@2x.png";

    final Uno __openWeatherAPI = Uno(
        baseURL: "https://api.openweathermap.org",
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded' 
        }
    );

    Uno get openWeatherAPI { return __openWeatherAPI; } 
        
    final Uno __openWeatherImages =  Uno(
        headers: { 
            'Content-Type': 'application/x-www-form-urlencoded' 
        },
        baseURL: "https://openweathermap.org/img/wn");
    
    Uno get openWeatherImages { return __openWeatherImages; }

    static final Connections __connections = Connections.__internal();

    factory Connections(){
      return __connections;
    }

    Connections.__internal();
}