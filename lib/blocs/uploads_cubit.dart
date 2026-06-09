import 'dart:developer';

import 'package:bmusic/blocs/states/uploads_state.dart';
import 'package:bmusic/repositories/models/music.dart';
import 'package:bmusic/repositories/models/user.dart';
import 'package:bmusic/repositories/online_music_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class UploadsCubit extends HydratedCubit<UploadsState>{
    final OnlineMusicRepository __onlineMusicRepository = OnlineMusicRepository();

    UploadsCubit(): super(UploadsState());

    Upload __replaceUpload({ required int index, required Upload upload }){
        List<Upload> initList = List.from(state.uploads);
        initList.removeAt(index);
        initList.insert(index, upload);
        emit(state.copy(uploads: initList));

        return upload;
    }

    Future<OnlineMusic?> __upload({ required int index, required User user, required Upload upload }) async{
        try{
            upload = __replaceUpload(index: index, upload: upload.copy(status: UploadStatus.uploading));

            final response = await __onlineMusicRepository.upload(music: upload.music, user: user, isPrivate: upload.isPrivate);

            __replaceUpload(index: index, upload: upload.copy(status: UploadStatus.complete));

            return response;
        }catch(error){
            log("uploading ${upload.music.name} failed", error: error);
            __replaceUpload(index: index,upload: upload.copy(status: UploadStatus.failed));
        }
        return null;
    }

    void add({ required User user, required LocalMusic music, bool isPrivate = false }){
        Upload upload = Upload(music: music, isPrivate: isPrivate);

        List<Upload> init = List.from(state.uploads);
        init.add(upload);
        emit(state.copy(uploads: init));

        __upload(upload: upload, user: user, index: init.length - 1);
    }

    @override
    UploadsState? fromJson(Map<String, dynamic> json) {
        try{
            return UploadsState.fromJson(json);
        }catch(err){
            log("Uploads State deserialization error", error: err);
        }
        return null;
    }

    @override
    Map<String, dynamic>? toJson(UploadsState state) {
        try{
            return state.toJson();
        }catch(err){
            log("Uploads State serialization error", error: err);
        }
        return null;
    }
}