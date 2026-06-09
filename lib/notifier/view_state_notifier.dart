import 'package:bmusic/utils/view_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:uno/uno.dart';

class ViewStateNotifier with ChangeNotifier{
    bool __disposed = false;

    ViewStateError? __viewStateError;
    ViewStateError? get viewStateError => __viewStateError;

    ViewState __viewState;
    ViewState get viewState => __viewState;
    bool get idle => __viewState == ViewState.idle;
    bool get busy => __viewState == ViewState.busy;
    bool get error => __viewState == ViewState.error;
    bool get empty => __viewState == ViewState.emty;
    bool get unAuthorized => __viewState == ViewState.unAuthorized;
    set viewState(ViewState viewState){
        __viewStateError = null;
        __viewState = viewState;
        notifyListeners();
    }

    String get errorMessage => __viewStateError!.message;

    ViewStateNotifier({ ViewState viewState = ViewState.idle }): __viewState = viewState;

    void setIdle() => viewState = ViewState.idle;
    void setBusy() => viewState = ViewState.busy;
    void setEmty() => viewState = ViewState.emty;
    void setUnAuthorized() => viewState = ViewState.unAuthorized;
    void setError(e, StackTrace stackTrace, {  String? message }){
        ErrorType errorType = ErrorType.defaultError;
        if(e is DioException || e is UnoError){
            e = e is DioException ? e.error : error;

            errorType = ErrorType.networkError;
        }

        viewState = ViewState.error;
        __viewStateError = ViewStateError(errorMessage: e.toString(), errorType: errorType, message: message);
        printErrorStack(e, stackTrace);
    }

    void showErrorMessage(BuildContext context, { String? message }){
        if(viewStateError != null || message != null){
            if(viewStateError!.isNetworkError){
                message ??= "conection error, check your internet connection and try again";
            }else{
                message ??= viewStateError!.message;
            }

            Future.microtask((){
                showToast(message!, context: context);
            });
        }
    }

    @override
    String toString() {
        return "NaseNotifier{__ViewState: $viewState, __viewStateError: $__viewStateError  }";
    }

    @override
    void notifyListeners() {
        if(!__disposed){
            super.notifyListeners();
        }
    }

    @override
    void dispose() {
        __disposed = true;
        debugPrint("ViewStateNotifier disposed --> $runtimeType");
        super.dispose();
    }
}

printErrorStack(e, s){
    debugPrint("Error: $e");
    debugPrintStack(stackTrace: s);
}