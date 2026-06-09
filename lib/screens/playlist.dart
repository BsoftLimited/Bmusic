import 'package:bmusic/blocs/library_bloc.dart';
import 'package:bmusic/blocs/playing_bloc.dart';
import 'package:bmusic/blocs/states/library_state.dart';
import 'package:bmusic/blocs/states/playing_state.dart';
import 'package:bmusic/components/background.dart';
import 'package:bmusic/components/song_options.dart';
import 'package:bmusic/components/song_view.dart';
import 'package:bmusic/pages/music/playlists.dart';
import 'package:bmusic/screens/search.dart';
import 'package:bmusic/screens/selection.dart';
import 'package:bmusic/utils/dual_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Playlist extends StatefulWidget{
    static const String routeName = "playlist";

    const Playlist({super.key });

    @override
    State<Playlist> createState() => __PlaylistState();
}

class __PlaylistState extends State<Playlist>{
    int? selectedSong;
    final PanelController panelController = PanelController();

    void onPick(BuildContext context, List<int> playlist, int song){
        context.read<PlayingBloc>().pick(playlist: playlist, song: song);
    }

    DualType<List<int>, Map<int, int>> initList({ required BuildContext context, String? args, required List<int> playlist }){
        if(args != null){
            LibraryBloc libraryBloc = context.read<LibraryBloc>();
            if(args.isPlaylistOptions){
                switch(args.toPlaylistOptions){
                    case PlaylistOptions.downloaded:
                        return DualType.first([]);
                    case PlaylistOptions.mostPlayed:
                        return DualType.second(libraryBloc.state.mostPlayed);
                    default:
                        return DualType.first(libraryBloc.state.playlists[args.toLowerCase()]);
                }
            }
            return DualType.first(libraryBloc.state.playlists[args]);
        }
        return DualType.first(playlist);
    }

    void select(int song){
        setState(() {
            selectedSong = song;
        });
        panelController.open();
    }

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;
        final args = ModalRoute.of(context)!.settings.arguments as String?;

        final needsTools = (args != null && !args.isPlaylistOptions) || args == PlaylistOptions.favorites.serialize;

        return Scaffold(
            body: Background(child: SlidingUpPanel(minHeight: 0,
                controller: panelController,
                panel: SongOptions(songID: selectedSong),
                body: NestedScrollView(floatHeaderSlivers: true, physics: const ClampingScrollPhysics(),
                    headerSliverBuilder: (context, value) => [
                        SliverAppBar(backgroundColor: Colors.transparent, elevation: 0, foregroundColor: theme.onPrimary,
                            title: Row(children: [
                                SvgPicture.asset("files/vectors/glyphs--music-list-bold.svg", width: 32, height: 32, colorFilter: ColorFilter.mode(theme.onPrimary, BlendMode.srcIn)),
                                SizedBox(width: 4),
                                Text(args ?? "Playlist", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: theme.onPrimary),),
                            ]),
                            actions: [ IconButton( icon: const Icon(Icons.search, size: 24), color: theme.onPrimary, onPressed: ()=>Navigator.pushNamed(context, Search.routeName) ) ],
                            leadingWidth: 30,
                            collapsedHeight: needsTools ? 100 : null,
                            flexibleSpace: needsTools ? Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                                Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                                        IconButton(padding: EdgeInsets.zero, iconSize: 28, color: theme.onPrimary, onPressed: (){
                                            Navigator.pushNamed(context, Selection.routeName, arguments: args);
                                        }, icon: Icon(Icons.add)),
                                        IconButton(padding: EdgeInsets.zero, iconSize: 28, color: theme.onPrimary, onPressed: (){}, icon: Icon(Icons.shuffle)),
                                        IconButton(padding: EdgeInsets.zero, iconSize: 28, color: theme.onPrimary, onPressed: (){}, icon: Icon(Icons.sort_by_alpha_rounded))
                                    ])
                                )
                            ]) : null,
                            floating: true, pinned: true),
                    ],
                    body: BlocBuilder<LibraryBloc, LibraryState>(builder: (context, libraryState) {
                        return BlocBuilder<PlayingBloc, PlayingState>(builder: (context, state) {
                            final list = initList(context: context, args: args, playlist: state.playList);
                            if(list.isFirst){
                                if(list.first.isEmpty){
                                    return Center(child: Text("No ${args ?? "Playlist"} found", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)));
                                }
                                return ReorderableListView.builder(itemCount: list.first.length, padding: const EdgeInsets.all(0),
                                    itemBuilder: (BuildContext context, int index) => SongView(key: Key("list: $index"), songId: list.first[index],
                                        picked: (songID){ onPick(context, list.first, songID); },
                                        index: needsTools || args == null ? index : null,
                                        options: needsTools ? select : null,
                                    ),
                                    proxyDecorator: (child, index, animation) {
                                        return Material(color: Colors.transparent, elevation: 8, child: child);
                                    },
                                    onReorder: (int oldIndex, int newIndex) {
                                        if(args == null){
                                            context.read<PlayingBloc>().swap(oldIndex, newIndex);
                                        }else{
                                            context.read<LibraryBloc>().swap(args.toLowerCase(), oldIndex, newIndex);
                                        }
                                    },
                                    physics: BouncingScrollPhysics(),
                                );
                            }

                            final playedList = list.second.entries.toList();
                            if(playedList.isEmpty){
                                return Center(child: Text("No ${args ?? "Playlist"} found", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)));
                            }
                            return ListView.builder(itemCount: playedList.length, padding: const EdgeInsets.all(0),
                                itemBuilder: (BuildContext context, int index){
                                    return SongView(songId: playedList[index].key, count: playedList[index].value,
                                        picked: (songID){
                                            onPick(context, playedList.map((init)=> init.key).toList(), songID);
                                        },
                                    );
                                },
                                physics: BouncingScrollPhysics(),
                            );
                        });
                    }),
                )),
            ),
        );
    }
}