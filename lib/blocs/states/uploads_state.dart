import 'dart:convert';

import 'package:bmusic/repositories/models/music.dart';
import 'package:equatable/equatable.dart';

enum UploadStatus { uploading, stopped, paused, failed, complete }

extension UploadStatusX on UploadStatus {
    bool get isUploading => this == UploadStatus.uploading;
    bool get hasStopped => this == UploadStatus.stopped;
    bool get isPaused => this == UploadStatus.paused;
    bool get hasFailed => this == UploadStatus.failed;
    bool get isComplete => this == UploadStatus.complete;

    String get serialize{
        switch(this){
            case UploadStatus.uploading:
                return "downloading";
            case UploadStatus.stopped:
                return "stopped";
            case UploadStatus.paused:
                return "paused";
            case UploadStatus.failed:
                return "failed";
            case UploadStatus.complete:
                return "complete";
        }
    }
}

extension UploadStatusString on String {
    UploadStatus get toUploadStatus{
        switch(toLowerCase()){
            case "uploading":
                return UploadStatus.uploading;
            case "stopped":
                return UploadStatus.stopped;
            case "paused":
                return UploadStatus.paused;
            case "failed":
                return UploadStatus.failed;
            case "complete":
                return UploadStatus.complete;
            default:
                throw Exception("$this is not valid upload status");
        }
    }
}

class Upload extends Equatable {
    final UploadStatus status;
    final String? message;
    final LocalMusic music;
    final bool isPrivate;

    const Upload({ this.status = UploadStatus.uploading, required this.music, this.isPrivate = false, this.message });

    factory Upload.fromJson(dynamic json) {
        return Upload(
            status: (json["status"] as String).toUploadStatus, isPrivate: json["isPrivate"],
            message: json["message"], music: LocalMusic.fromJson(json["music"])
        );
    }

    Upload copy({ LocalMusic? music, bool? isPrivate, UploadStatus? status, String? message }){
        return Upload(
            isPrivate: isPrivate ?? this.isPrivate,
            music: music ?? this.music,
            status: status ?? this.status,
            message: message ?? this.message
        );
    }

    Map<String, dynamic> toJson() => {
        "music": music.toJson(), "status": status.serialize, "message": message, "isPrivate": isPrivate
    };

    String serialize() => jsonEncode(toJson());

    @override
    List<Object?> get props => [ music, isPrivate, status, message ];
}

class UploadsState extends Equatable{
    final List<Upload> uploads ;

    const UploadsState({ this.uploads = const [] });

    factory UploadsState.fromJson(dynamic json) {
        return UploadsState(
            uploads: (json["uploads"] as List<dynamic>).map((init)=> Upload.fromJson(init)).toList()
        );
    }

    UploadsState copy({ List<Upload>? uploads }){
        return UploadsState( uploads: uploads ?? this.uploads);
    }

    Map<String, dynamic> toJson() => {
        "downloads": uploads.map((init)=> init.toJson()).toList()
    };

    String serialize() => jsonEncode(toJson());

    @override
    List<Object?> get props => [ uploads ];
}