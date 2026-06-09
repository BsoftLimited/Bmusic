import 'dart:developer';
import 'dart:io';

import 'package:bmusic/blocs/states/downloads_state.dart';
import 'package:bmusic/repositories/models/music.dart';
import 'package:bmusic/repositories/online_music_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

class DownloadsCubit extends HydratedCubit<DownloadsState>{
    final OnlineMusicRepository __onlineMusicRepository = OnlineMusicRepository();

    DownloadsCubit(): super(DownloadsState());

    Download __replaceDownload({ required int index, required Download download }){
        List<Download> initList = List.from(state.downloads);
        initList.removeAt(index);
        initList.insert(index, download);
        emit(state.copy(downloads: initList));

        return download;
    }

    Future<void> __download({ required int index, required Download download }) async{
        try{
            // Get local directory for saving
            final dir = await getApplicationDocumentsDirectory();
            final file = File('${dir.path}/${download.music.name}');

            download = __replaceDownload(index: index, download: download.copy(localPath: file.path, status: DownloadStatus.downloading));

          // Download with progress tracking
          await __onlineMusicRepository.download(music: download.music);
          // save the music file from Uint8List

          __replaceDownload(index: index, download: download.copy(status: DownloadStatus.complete));
        }catch(error){
            log("downloading ${download.music.name} failed", error: error);
            __replaceDownload(index: index, download: download.copy(status: DownloadStatus.failed));
        }
    }

    void add(OnlineMusic music){
        Download download = Download(music: music);

        List<Download> init = List.from(state.downloads);
        init.add(download);
        emit(state.copy(downloads: init));

        __download(download: download, index: init.length - 1);
    }

    @override
    DownloadsState? fromJson(Map<String, dynamic> json) {
        try{
            return DownloadsState.fromJson(json);
        }catch(err){
            log("Downloads State deserialization error", error: err);
        }
        return null;
    }

    @override
    Map<String, dynamic>? toJson(DownloadsState state) {
        try{
            return state.toJson();
        }catch(err){
            log("Downloads State serialization error", error: err);
        }
        return null;
    }
}