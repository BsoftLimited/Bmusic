part of "music.dart";

class OnlineMusic extends Music{
    final String owner, path;
    final DateTime created_at;
    final bool is_private;

    const OnlineMusic({ required super.id, required super.name, super.artist, super.album, required this.path, required this.owner, required this.created_at, this.is_private = false, required super.title });

    factory OnlineMusic.fromJson(dynamic json) {
        return OnlineMusic(
            id: json["id"], name: json["name"], owner: json["owner"], created_at: json["created_at"],
            is_private: json["is_private"], path: json["path"], title: json["title"], artist: json["artist"], album: json["album"]
        );
    }

    @override
    Map<String, dynamic> toJson() => {
        "id": id, "name": name, "owner": owner, "created_at": created_at,
        "is_private": is_private, "path": path, "title": title, "artist": artist, "album": album
    };


    @override
    List<Object?> get props => [ id, name, title, artist, album, path, owner, created_at, is_private ];
}