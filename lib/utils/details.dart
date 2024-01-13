import 'dart:convert' show json;

import 'package:bmusic/utils/objectio.dart';

class LoginDetail {
    String phone, password;
    bool auto = false;

    LoginDetail.__new({required this.phone, required this.password} );
    LoginDetail.__fromJson(dynamic json): auto = json["auto"], phone = json["phone"], password = json["password"];

    String serialize() => json.encode({ "phone" : phone, "password" : password });

    static LoginDetail? __detail;
    static bool get hasInstance=> __detail != null;
    static LoginDetail get instance => __detail!;

    static LoginDetail create({required String phone, required password}){
        __detail = LoginDetail.__new(phone: phone, password: password);
        return __detail!;
    }

    static Future<LoginDetail> find() async{
        ObjectIO objectIO = ObjectIO(folder: "user");
        String savedObject = await objectIO.readFromFile("details");
        __detail = LoginDetail.__fromJson(json.decode(savedObject));
        
        return __detail!;
    }

    static Future<void> save() async{
        if(__detail != null){
            ObjectIO objectIO = ObjectIO(folder: "user");
            objectIO.writeToFile("details", __detail!.serialize());
        }
    }
}
