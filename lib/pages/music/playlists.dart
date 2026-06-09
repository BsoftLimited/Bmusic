import 'package:bmusic/blocs/library_bloc.dart';
import 'package:bmusic/blocs/states/library_state.dart';
import 'package:bmusic/components/add_playlist.dart';
import 'package:bmusic/components/custom_playlist.dart';
import 'package:bmusic/components/playlist_item.dart';
import 'package:bmusic/screens/playlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum PlaylistOptions{
    favorites, recentlyAdded, mostPlayed, recentlyPlayed, downloaded
}

extension PlaylistOptionsX on PlaylistOptions {
    String get serialize{
        switch(this){
            case PlaylistOptions.favorites:
                return "Favorites";
            case PlaylistOptions.downloaded:
                return "Downloaded";
            case PlaylistOptions.mostPlayed:
                return "Most played";
            case PlaylistOptions.recentlyAdded:
                return "Recently Added";
            case PlaylistOptions.recentlyPlayed:
                return "Recently Played";
        }
    }
}

extension PlaylistOptionsString on String {
    PlaylistOptions get toPlaylistOptions{
        switch(toLowerCase()){
            case "recently played":
                return PlaylistOptions.recentlyPlayed;
            case "recently added":
                return PlaylistOptions.recentlyAdded;
            case "most played":
                return PlaylistOptions.mostPlayed;
            case "favorites":
                return PlaylistOptions.favorites;
            case "downloaded":
                return PlaylistOptions.downloaded;
            default:
                throw Exception("$this is not valid download status");
        }
    }

    bool get isPlaylistOptions{
        final init = [
            PlaylistOptions.recentlyPlayed.serialize.toLowerCase(),
            PlaylistOptions.recentlyAdded.serialize.toLowerCase(),
            PlaylistOptions.mostPlayed.serialize.toLowerCase(),
            PlaylistOptions.favorites.serialize.toLowerCase(),
            PlaylistOptions.downloaded.serialize.toLowerCase()
        ];

        return init.contains(toLowerCase());
    }
}

class __PlaylistOption{
    final String icon;
    final PlaylistOptions label;

    const __PlaylistOption({ required this.label, required this.icon });
}

List<__PlaylistOption> __options = [
    __PlaylistOption(label: PlaylistOptions.favorites, icon: "ph--list-heart-thin.svg"),
    __PlaylistOption(label: PlaylistOptions.recentlyAdded, icon: "arcticons--folder-music.svg"),
    __PlaylistOption(label: PlaylistOptions.mostPlayed, icon: "arcticons--vibe-music.svg"),
    __PlaylistOption(label: PlaylistOptions.recentlyPlayed, icon: "arcticons--niagara-launcher-recently-installed.svg"),
    //__PlaylistOption(label: PlaylistOptions.downloaded, icon: "arcticons--music-downloader.svg")
];

class Playlists extends StatelessWidget{
    const Playlists({super.key});

    @override
    Widget build(BuildContext context) {
        return Padding(padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: ListView(padding: EdgeInsets.zero,
              children: [
                  //AddPlaylist(create: (name){ context.read<LibraryBloc>().createPlaylist(name); }),
                  SizedBox(height: 10),
                  PlaylistContainer(list: __options.map((option){
                      return PlaylistItem(icon: option.icon, label: option.label.serialize, selected: (name){
                          Navigator.pushNamed(context, Playlist.routeName, arguments: name);
                      });
                  }).toList()),
                  BlocBuilder<LibraryBloc, LibraryState>(builder: (context, state){
                      Iterable<String> init = state.playlists.keys.skipWhile((name)=> name.isPlaylistOptions);
                      return ListView.builder(padding: EdgeInsets.symmetric(horizontal: 10),
                          shrinkWrap: true, physics: BouncingScrollPhysics(), itemCount: init.length,
                          itemBuilder: (context, index) => CustomPlaylist(name: init.elementAt(index)),
                      );
                  })
              ],
          ),
        );
    }
}