import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:bmusic/repositories/models/music.dart';
import 'package:bmusic/repositories/models/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show Bucket, FileOptions, Supabase, SupabaseClient;

class OnlineMusicRepository{
    final SupabaseClient __supabase = Supabase.instance.client;
    late Bucket __bucket;

    OnlineMusicRepository(){
        __init().then((bucket){
            __bucket = bucket;
        }).catchError((error){
            throw error;
        });
    }

    Future<Bucket> __init() async{
        final results = await __supabase.storage.listBuckets();
        if(results.isEmpty){
            final id = await __supabase.storage.createBucket(dotenv.env["SUPABASE_BUKET"] ?? "");
            return await __supabase.storage.getBucket(id);
        }
        return results.first;
    }

    Future<bool> __isEnoughSpace(Uint8List data) async {
        try {
            final directory = await getApplicationDocumentsDirectory();
            final stat = await FileStat.stat(directory.path);
            return stat.size > data.length;
        } catch (e) {
            return false;
        }
    }

    Future<File> __saveToDownloads(Uint8List data, String fileName) async {
        try {
            Directory? downloadsDir;
            // Check available space
            if (!await __isEnoughSpace(data)) {
                throw Exception('Not enough storage space');
            }

            if (Platform.isAndroid) {
                // For Android 10+, use the downloads directory
                downloadsDir = await getDownloadsDirectory();
            } else {
                // For other platforms, use documents directory
                downloadsDir = await getApplicationDocumentsDirectory();
            }

            if (downloadsDir == null){
                throw Exception("unable to get download folder");
            }

            final filePath = '${downloadsDir.path}/$fileName';
            final file = File(filePath);

            final sink = file.openWrite(); // Open the file for writing
            // Write in chunks (e.g., 1MB at a time)
            const chunkSize = 1024 * 1024; // 1MB
            for (var i = 0; i < data.length; i += chunkSize) {
                final end = (i + chunkSize) > data.length ? data.length : i + chunkSize;
                sink.add(data.sublist(i, end));
            }
            await sink.close(); // Close the file

            return file;
        } catch (e) {
            log('Error saving file:', error: e);
            rethrow;
        }
    }

    Future<File> download({ required OnlineMusic music }) async{
        final response = await __supabase.storage.from(__bucket.id).download(music.path);
        return __saveToDownloads(response, "${music.name}.mp3");
    }

    Future<OnlineMusic> upload({ required LocalMusic music, required User user, bool isPrivate = false }) async{
        final onlinePath = '${user.username}/${music.name.replaceAll(" ", "_")}';

        final fileSource = DeviceFileSource((music.data));
        final file = File(fileSource.path);
        final String fullPath = await __supabase.storage.from(__bucket.id).upload(onlinePath, file,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
        );

        final init = await __supabase.from("musics").insert({
            "name": music.name, "title": music.title, "artist": music.artist, "album": music.album,
            "owner": user.id, "path": fullPath, "is_private": isPrivate
        }).single();

        return OnlineMusic.fromJson(init);
    }
}