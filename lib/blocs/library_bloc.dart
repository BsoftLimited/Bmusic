import 'dart:developer';

import 'package:bmusic/blocs/states/library_state.dart';
import 'package:bmusic/blocs/states/status.dart';
import 'package:bmusic/pages/music/playlists.dart';
import 'package:bmusic/repositories/models/music.dart';
import 'package:bmusic/utils/map_extentions.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class LibraryBloc extends HydratedCubit<LibraryState>{

    bool get hasExistingData => HydratedBloc.storage.read(runtimeType.toString()) != null;

    LibraryBloc(): super(const LibraryState());

    Future<Map<String, List<int>>> __sortByAlbum(Map<int, Music> songs) async{
        Map<String, List<int>> init ={};
        for (final model in songs.entries) {
            if(init.containsKey(model.value.album)){
                init[model.value.album ?? "unknown"]?.add(model.key);
            }else{
                init[model.value.album ?? "unknown"] = [model.key];
            }
        }
        return init;
    }

    Future<Map<String, List<int>>> __sortByArtist(Map<int, Music> songs) async{
        Map<String, List<int>> init ={};
        for (final model in songs.entries) {
            if(init.containsKey(model.value.artist)){
                init[model.value.artist ?? "unknown"]?.add(model.key);
            }else{
                init[model.value.artist ?? "unknown"] = [model.key];
            }
        }
        return init;
    }

    Future<List<int>> __sortByDate(Map<int, Music> songs) async{
        List<Music> init = List.from(songs.values);
        init.sort((first, second){
            final firstDate = first is LocalMusic ? first.added : (first as OnlineMusic).created_at.microsecondsSinceEpoch;
            final secondDate = second is LocalMusic ? second.added : (second as OnlineMusic).created_at.microsecondsSinceEpoch;

            return secondDate.compareTo(firstDate);
        });

        return (init.length > 20 ? init.sublist(0, 20) : init).map((song)=> song.id).toList();
    }

    Map<String, List<int>> __updatePlaylist(String name, List<int> list){
        final playlists = Map<String, List<int>>.from(state.playlists);
        playlists[name] = list;

        return playlists;
    }

    Future<void> swap(String playlist, int oldIndex, int newIndex) async {
        final playlists = Map<String, List<int>>.from(state.playlists);
        final songs = playlists[playlist]!;

        if (oldIndex < newIndex) {
            newIndex -= 1;
        }

        final song = songs.removeAt(oldIndex);
        songs.insert(newIndex, song);

        playlists[playlist] = songs;

        emit(state.copy(playlists: playlists));
    }

    Future<void> init(Map<int, Music> songs) async {
        emit(state.copy(message: "sorting songs by albums", status: StateStatus.loading ));
        emit(state.copy(albums: await __sortByAlbum(songs)));

        emit(state.copy(message: "sorting songs by artist"));
        emit(state.copy(artists: await __sortByArtist(songs)));

        emit(state.copy(message: "sorting songs by date"));
        emit(state.copy(playlists: __updatePlaylist(PlaylistOptions.recentlyAdded.serialize.toLowerCase(), await __sortByDate(songs))));

        emit(state.copy(status: StateStatus.success));
    }

    Future<void> played(int song) async{
        final recentlyPlayedLabel = PlaylistOptions.recentlyPlayed.serialize.toLowerCase();
        List<int> recentlyPlayed = List.from(state.playlists[recentlyPlayedLabel]!);
        if(recentlyPlayed.isEmpty){
            recentlyPlayed.add(song);
        } else if(recentlyPlayed.contains(song)){
            recentlyPlayed.remove(song);
        }else {
            recentlyPlayed.insert(0, song);
        }

        Map<int, int> mostPlayed = Map<int, int>.from(state.mostPlayed);
        if(mostPlayed.containsKey(song)){
            mostPlayed[song] = mostPlayed[song]! + 1;
        }else{
            mostPlayed[song] = mostPlayed[song]! + 1;
        }
        mostPlayed = mostPlayed.sortByValue((songA, songB)=> songB.compareTo(songA));

        emit(state.copy(playlists: __updatePlaylist(recentlyPlayedLabel, recentlyPlayed), mostPlayed: mostPlayed));
    }

    bool isFavourite(int? songID){
        if(songID == null){
            return false;
        }

        return state.playlists[PlaylistOptions.favorites.serialize.toLowerCase()]!.contains(songID);
    }

    void toggleFavourite(int? songID){
        final favouritesLabel = PlaylistOptions.favorites.serialize.toLowerCase();

        if(songID != null){
            final favourites = List<int>.from(state.playlists[favouritesLabel]!);
            if(favourites.contains(songID)){
                favourites.remove(songID);
            }else{
                favourites.add(songID);
            }
            emit(state.copy(playlists: __updatePlaylist(favouritesLabel, favourites)));
        }
    }

    Future createPlaylist(String name) async{
        if(!state.playlists.containsKey(name)){
            final init = Map<String, List<int>>.from(state.playlists);
            init[name] = [];

            emit(state.copy(playlists: init));
        }
    }

    Future addToPlaylist({ required String playlist, required List<int> songs }) async{
        if(state.playlists.containsKey(playlist)){
            final init = Map<String, List<int>>.from(state.playlists);
            final list = init[playlist]!;
            for(final song in songs){
                if(!list.contains(song)){
                    list.add(song);
                }
            }
            list.sort((songA, songB)=> songA.compareTo(songA));
            init[playlist] = list;

            emit(state.copy(playlists: init));
        }
    }

    @override
    LibraryState? fromJson(Map<String, dynamic> json) {
        try{
            return LibraryState.fromJson(json);
        }catch(err){
            log("Library State deserialization error", error: err);
        }
        return null;
    }

    @override
    Map<String, dynamic>? toJson(LibraryState state) {
        try{
            return state.toJson();
        }catch(err){
            log("Library State serialization error", error: err);
        }
        return null;
    }
}