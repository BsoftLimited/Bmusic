import 'package:equatable/equatable.dart';
import 'dart:convert';

part "local_music.dart";
part "online_music.dart";

abstract class Music extends Equatable{
    final int id;
    final String title, name;
    final String? artist, album;

    const Music({ required this.id, required this.name, required this.title, this.artist, this.album });

    Map<String, dynamic> toJson();

    String get serialize => jsonEncode(toJson());
}