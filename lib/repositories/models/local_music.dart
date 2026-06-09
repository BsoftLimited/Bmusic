part of "music.dart";

class LocalMusic extends Music{
    final int added;
    final String data;

    const LocalMusic({ required super.id, required super.name, required super.title, super.artist, super.album, required this.added, required this.data });

    factory LocalMusic.fromJson(dynamic json) {
        return LocalMusic(
            id: json["id"], added: json["added"], name: json["name"], title: json["title"],
            data: json["data"], artist: json["artist"], album: json["album"]
        );
    }

    @override
    Map<String, dynamic> toJson() => {
        "id": id, "added": added, "name": name, "artist": artist, "data": data, "album": album, "title": title
    };

    @override
    List<Object?> get props => [ id, added, name, artist, data, album, title ];
}