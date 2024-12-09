import 'package:audioplayers/audioplayers.dart';
import 'package:bmusic/blocs/states/playing_state.dart';
import 'package:bmusic/blocs/states/settings_state.dart';
import 'package:bmusic/blocs/states/status.dart';
import 'package:bmusic/utils/util.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class PlayingBloc extends HydratedCubit<PlayingState>{
    final SettingsState settingsState;
    final player = AudioPlayer();

    bool get hasExistingData => HydratedBloc.storage.read(runtimeType.toString()) != null;

    PlayingBloc(this.settingsState): super(const PlayingState()){
        player.onPlayerStateChanged.listen((s) {
            switch(s){
                case PlayerState.playing:
                  emit(state.copy(playing: true));
                  break;
                case PlayerState.completed:
                  emit(state.copy(playing: false));
                  if(state.repeatMode != RepeatMode.off){
                      next();
                  }
                  break;
                case PlayerState.paused:
                  emit(state.copy(playing: false));
                  break;
                case PlayerState.stopped:
                  emit(state.copy(playing: false));
                  break;
                case PlayerState.disposed:
                  emit(state.copy(playing: false));
                  break;
            }
        });

        player.onDurationChanged.listen((event) => emit(state.copy(duration: event)));
        player.onPositionChanged.listen((event) => emit(state.copy(position: event)));
    }

    Future<Map<String, List<int>>> __sortByAlbum() async{
        Map<String, List<int>> init ={};
        for (final model in settingsState.songs.entries) {
            if(init.containsKey(model.value.album)){
                init[model.value.album ?? "unknown"]?.add(model.key);
            }else{
                init[model.value.album ?? "unknown"] = [model.key];
            }
        }
        return init;
    }

    Future<Map<String, List<int>>> __sortByArtist() async{
        Map<String, List<int>> init ={};
        for (final model in settingsState.songs.entries) {
            if(init.containsKey(model.value.artist)){
                init[model.value.artist ?? "unknown"]?.add(model.key);
            }else{
                init[model.value.artist ?? "unknown"] = [model.key];
            }
        }
        return init;
    }

    Future<Map<String, List<int>>> __sortByFolder() async{
        Map<String, List<int>> init ={};
        for (final model in settingsState.songs.entries) {
            String folderName = Util.folder(model.value.uri!);
            if(init.containsKey(folderName)){
                init[folderName]?.add(model.key);
            }else{
                init[folderName] = [model.key];
            }
        }
        return init;
    }

    Future<void> init() async {
        emit(state.copy(message: "Initializing playlist", status: StateStatus.loading));

        emit(state.copy(message: "sorting songs by albums"));
        emit(state.copy(albums: await __sortByAlbum()));

        emit(state.copy(message: "sorting songs by artist"));
        emit(state.copy(albums: await __sortByArtist()));

        emit(state.copy(message: "sorting songs by folders"));
        emit(state.copy(albums: await __sortByFolder()));

        if(settingsState.songs.isNotEmpty){
            await player.setSource((DeviceFileSource((settingsState.songs[state.current])!.data)));
            __initShuffleMode();
        }

        emit(state.copy(status: StateStatus.success));
    }

    set seek(int seconds){
        Duration position = Duration(seconds: seconds);
        player.seek(position).then((value){
            emit(state.copy(position: position));
        });
    }

    set current(int? song){
        if(song != null){
            int curentIndex = settingsState.songs.keys.toList().indexOf(song);
            emit(state.copy(index: curentIndex));
            __initShuffleMode();
            __play();
        }
    }

    void setFromPlaylist(int song){
        emit(state.copy(index: state.playList.indexOf(song)));
        __play();
    }

    void toggleRepeatMode(){
        switch(state.repeatMode){
            case RepeatMode.single:
                emit(state.copy(repeatMode: RepeatMode.all));
                break;
            case RepeatMode.all:
                emit(state.copy(repeatMode: RepeatMode.off));
              break;
            case RepeatMode.off:
                emit(state.copy(repeatMode: RepeatMode.single));
              break;
        }
    }

    void __initShuffleMode(){
        switch(state.shuffleMode){
            case ShuffleMode.off:
                List<int> playList = settingsState.songs.keys.toList();
                emit(state.copy(playList: playList, index: playList.indexOf(state.current!)));
                break;
            case ShuffleMode.on:
                Util.shuffle(settingsState.songs.keys.toList(), state.current!).then((list){
                    emit(state.copy(playList: list, index: 0));
                });
                break;
        }
    }

    void toggleShuffleMode(){
        emit(state.copy(shuffleMode: state.shuffleMode == ShuffleMode.off ? ShuffleMode.on : ShuffleMode.off));
        __initShuffleMode();
    }

    Future<void> togglePlay() async{
        if(player.state == PlayerState.playing){
            await player.pause();
        }else {
            await player.resume();
        }
        emit(state.copy(playing: player.state == PlayerState.playing));
    }

    bool isFavourite(int? songID){
        return state.favourites.contains(songID);
    }

    void toggleFavourite(int? songID){  
        if(songID != null){
            if(state.favourites.contains(songID)){
                emit(state.copy(favourites: [...state.favourites]..remove(songID)));
            }else{
                emit(state.copy(favourites: [...state.favourites, songID]));
            }
        }
    }

    Future<void> __play() async{
        if(state.current != null){
            await player.stop();
            await player.play(DeviceFileSource((settingsState.songs[state.current])!.data));
            emit(state.copy(playing: player.state == PlayerState.playing));
        }
    }

    void next(){
        if(state.repeatMode != RepeatMode.single){
            if(state.index + 1 < state.playList.length){
                emit(state.copy(index: state.index + 1));
            }else{
                emit(state.copy(index: 0));
            }
        }
        __play();
    }

    void prev(){
        if(state.repeatMode != RepeatMode.single){
              if(state.index - 1 > 0){
                  emit(state.copy(index: state.index - 1));
              }else{
                  emit(state.copy(index: state.playList.length - 1));
              }
        }
        __play();
    }
    
    @override
    PlayingState? fromJson(Map<String, dynamic> json) {
        return PlayingState.fromJson(json);
    }
    
    @override
    Map<String, dynamic>? toJson(PlayingState state) {
        return state.toJson();
    }
}