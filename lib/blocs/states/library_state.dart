import 'dart:convert';

import 'package:bmusic/blocs/states/status.dart';
import 'package:equatable/equatable.dart';

class LibraryState extends Equatable{
    final Map<String, List<int>> playlists, albums, artists;
    final Map<int, int> mostPlayed;

    final StateStatus status;
    final String message;

    List<String> get artistNames  => artists.keys.toList();
    List<String> get albumsTitles  => albums.keys.toList();

    const LibraryState({
        this.albums = const {}, this.artists = const {}, this.mostPlayed = const{},
        this.status = StateStatus.initial, this.message = "", this.playlists =  const {
            "favorites" : [], "recently added": [], "recently played": [], "most played": []
        }});

    factory LibraryState.fromJson(dynamic json) {
        return LibraryState(
            mostPlayed: (json["mostPlayed"] as Map<int, int>),
            playlists: (json["playlist"] as Map<String, dynamic>).map((name, list)=> MapEntry(name, list as List<int>))
        );
    }

    LibraryState copy({
        Map<String, List<int>>? playlists,
        Map<int, int>? mostPlayed, Map<String, List<int>>? albums,
        Map<String, List<int>>? artists, StateStatus? status, String? message }){

        return LibraryState(
            albums: albums ?? this.albums,
            playlists: playlists ?? this.playlists,
            mostPlayed: mostPlayed ?? this.mostPlayed,
            artists: artists ?? this.artists,
            status: status ?? this.status,
            message: message ?? this.message
        );
    }

    Map<String, dynamic> toJson() => { "mostPlayed": mostPlayed, "playlists": playlists };

    String serialize() => jsonEncode(toJson());
 
    @override
    List<Object?> get props => [ albums, artists, mostPlayed, message, playlists ];
}