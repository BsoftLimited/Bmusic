import 'dart:developer';

import 'package:bmusic/repositories/models/music.dart';
import 'package:on_audio_query_pluse/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class LocalMusicRepository {
    Future<Iterable<LocalMusic>> __find(OnAudioQuery audioQuery) async{
        try{
            List<SongModel> initList = await audioQuery.querySongs(
                sortType: SongSortType.TITLE,
                orderType: OrderType.ASC_OR_SMALLER,
                uriType: UriType.EXTERNAL, ignoreCase: true);

            return initList.map((song)=> LocalMusic(id: song.id, added: song.dateAdded!, name: song.displayName, title: song.title, artist: song.artist, album: song.album, data: song.data));
        }catch(error){
            log('Error: $error');
            throw Exception(error);
        }
    }

    Future<Iterable<LocalMusic>> __fetchSongs() async{
        OnAudioQuery audioQuery = OnAudioQuery();
        bool permissionStatus = await audioQuery.permissionsStatus();
        if (!permissionStatus) {
            if(!await audioQuery.permissionsRequest()){
                await openAppSettings();
            }
        }
        return await __find(audioQuery);
    }

    Future<Map<int,LocalMusic>> fetchMusics() async {
        Map<int, LocalMusic> init = {};
        for (var music in (await __fetchSongs())) {
            init.putIfAbsent(music.id, ()=> music );
        }
        return init;
    }
}