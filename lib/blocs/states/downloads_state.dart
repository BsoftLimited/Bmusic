import 'dart:convert';

import 'package:bmusic/repositories/models/music.dart';
import 'package:equatable/equatable.dart';

enum DownloadStatus { downloading, stopped, paused, failed, complete }

extension DownloadStatusX on DownloadStatus {
    bool get isDownloading => this == DownloadStatus.downloading;
    bool get hasStopped => this == DownloadStatus.stopped;
    bool get isPaused => this == DownloadStatus.paused;
    bool get hasFailed => this == DownloadStatus.failed;
    bool get isComplete => this == DownloadStatus.complete;

    String get serialize{
        switch(this){
            case DownloadStatus.downloading:
                return "downloading";
            case DownloadStatus.stopped:
                return "stopped";
            case DownloadStatus.paused:
                return "paused";
            case DownloadStatus.failed:
                return "failed";
            case DownloadStatus.complete:
                return "complete";
        }
    }
}

extension DownloadStatusString on String {
    DownloadStatus get toDownloadStatus{
        switch(toLowerCase()){
            case "downloading":
                return DownloadStatus.downloading;
            case "stopped":
                return DownloadStatus.stopped;
            case "paused":
                return DownloadStatus.paused;
            case "failed":
                return DownloadStatus.failed;
            case "complete":
                return DownloadStatus.complete;
            default:
                throw Exception("$this is not valid download status");
        }
    }
}

class Download extends Equatable{
    final double progress;
    final DownloadStatus status;
    final OnlineMusic music;
    final String? localPath;
    final String? message;

    const Download({
        required this.music, this.localPath, this.progress = 0, this.status = DownloadStatus.downloading,
        this.message
    });

    factory Download.fromJson(dynamic json) {
        return Download(
            localPath: json["localPath"], status: (json["status"] as String).toDownloadStatus,
            progress: json["progress"], message: json["message"], music: OnlineMusic.fromJson(json["music"])
        );
    }

    Download copy({ OnlineMusic? music, String? localPath, double? progress, DownloadStatus? status, String? message }){
        return Download(
            music: music ?? this.music,
            localPath: localPath ?? this.localPath,
            progress: progress ?? this.progress,
            status: status ?? this.status,
            message: message ?? this.message
        );
    }

    Map<String, dynamic> toJson() => {
        "music": music.toJson(), "localPath": localPath, "progress": progress, "status": status.serialize, "message": message
    };

    String serialize() => jsonEncode(toJson());

    @override
    List<Object?> get props => [ music, progress, localPath, status, message ];
}

class DownloadsState extends Equatable{
    final List<Download> downloads ;

    const DownloadsState({ this.downloads = const [] });

    factory DownloadsState.fromJson(dynamic json) {
        return DownloadsState(
            downloads: (json["downloads"] as List<dynamic>).map((init)=> Download.fromJson(init)).toList()
        );
    }

    DownloadsState copy({ List<Download>? downloads }){
        return DownloadsState( downloads: downloads ?? this.downloads);
    }

    Map<String, dynamic> toJson() => {
        "downloads": downloads.map((init)=> init.toJson()).toList()
    };

    String serialize() => jsonEncode(toJson());

    @override
    List<Object?> get props => [ downloads ];
}