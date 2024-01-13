import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:googleapis/drive/v3.dart' as ga;

class GoogleHttpClient extends IOClient {
  final Map<String, String> _headers;
  GoogleHttpClient(this._headers) : super();

  @override
  Future<IOStreamedResponse> send(http.BaseRequest request) => super.send(request..headers.addAll(_headers));
  
  @override
  Future<http.Response> head(Uri url, {Map<String, String>? headers}) {
    if(headers != null){
      headers.addAll(_headers);
    }
    return super.head(url, headers: headers);
  }
}

class GoogleNotifier extends ChangeNotifier{
  final GoogleSignIn __googleSignIn = GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/drive.file',
  ]);
  GoogleSignInAccount? __googleSignInAccount;
  GoogleSignInAccount? get googleSignInAccount => __googleSignInAccount;

  bool __isAuthorized  = false;
  bool get isAuthorized => __isAuthorized;

  bool __isLoading = false;
  bool get isLoading => __isLoading;

  List<ga.File> __files = [];
  List<ga.File> get files => __files;

  GoogleNotifier(){
    __googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) async {
      // #docregion CanAccessScopes
        // In mobile, being authenticated means being authorized...
        __isAuthorized = account != null;
        // #enddocregion CanAccessScopes
        
        __googleSignInAccount = account;
        __isLoading = __isAuthorized;

        notifyListeners();
        if(__isAuthorized){
          await __listGoogleDriveFiles();
        }
    });
  }

  void signIn() => __googleSignIn.signIn().onError((error, stackTrace) {
      log("${error.toString()}-$stackTrace");
  });

  void signOut() => __googleSignIn.signOut().onError((error, stackTrace) {
      log("${error.toString()}-$stackTrace");
  });


  Future<void> __listGoogleDriveFiles() async {
    var client = GoogleHttpClient(await __googleSignInAccount!.authHeaders);
    var drive = ga.DriveApi(client);
    
    drive.files.list(spaces: 'appDataFolder').then((value) {
        __files = value.files ?? [];
    }).catchError((error){
      log(error);
    }).whenComplete((){
      __isLoading = false;
      notifyListeners();
    });
  }
}