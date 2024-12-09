import "dart:developer";

import "package:flutter_bloc/flutter_bloc.dart";

class SimpleBlocObserver extends BlocObserver {
    const SimpleBlocObserver();
    
    @override
    void onCreate(BlocBase<dynamic> bloc) {
        super.onCreate(bloc);
        log('onCreate -- bloc: ${bloc.runtimeType}');
    }
    
    @override
    void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
        super.onEvent(bloc, event);
        log('onEvent -- bloc: ${bloc.runtimeType}, event: $event');
    }
    
    @override
    void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
        super.onChange(bloc, change);
        log('onChange -- bloc: ${bloc.runtimeType}, change: $change');
    }
    
    @override
    void onTransition(Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
        super.onTransition(bloc, transition);
        log('onTransition -- bloc: ${bloc.runtimeType}, transition: $transition');
    }
    
    @override
    void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
        log('onError -- bloc: ${bloc.runtimeType}, error: $error');
        super.onError(bloc, error, stackTrace);
    }
    
    @override
    void onClose(BlocBase<dynamic> bloc) {
        super.onClose(bloc);
        log('onClose -- bloc: ${bloc.runtimeType}');
    }
}