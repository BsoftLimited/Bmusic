import 'package:bmusic/components/bottom_panel.dart';
import 'package:bmusic/pages/music/albums.dart';
import 'package:bmusic/pages/music/artist.dart';
import 'package:bmusic/pages/music/playlists.dart';
import 'package:bmusic/pages/music/songs.dart';
import 'package:bmusic/components/playing.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Music extends StatefulWidget{
  const Music({super.key});

  @override
  State<StatefulWidget> createState() => __MusicState();
}

class __MusicState extends State<Music>{
  final PanelController panelController = PanelController();

  void openSearch()=> Navigator.pushNamed(context, "/search");

  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;

    return DefaultTabController( length: 4,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(backgroundColor: theme.surface, elevation: 0,
              title: Text('Music', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: theme.primary),),
              leading: Icon(Icons.playlist_play_rounded, color: theme.primary, size: 34,),
              actions: [ IconButton( icon: const Icon(Icons.search), onPressed: openSearch ) ],
          leadingWidth: 30,
          bottom: TabBar( labelStyle: const TextStyle(fontSize: 12), indicatorColor: theme.primary, labelColor: theme.primary,
              unselectedLabelColor: theme.onSurfaceVariant,
              tabs: const [
                Tab(icon: Icon(Icons.music_note_outlined), iconMargin: EdgeInsets.only(bottom: 6), child: Text("Songss", style: TextStyle(letterSpacing: 1.2),)),
                Tab(icon: Icon(Icons.album), iconMargin: EdgeInsets.only(bottom: 6),child: Text("Albums", style: TextStyle(letterSpacing: 1.2),),),
                Tab(icon: Icon(Icons.people_alt), iconMargin: EdgeInsets.only(bottom: 6), child: Text("Artists", style: TextStyle(letterSpacing: 1.2),)),
                Tab(icon: Icon(Icons.dashboard),  iconMargin: EdgeInsets.only(bottom: 6), child: Text("Playlists", style: TextStyle(letterSpacing: 1.2),)),
              ],
          ),
        ),
        body: SlidingUpPanel(
            maxHeight: 600, minHeight: 70, backdropEnabled: true,
            controller: panelController,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            body: Container(
                padding: const EdgeInsets.only(bottom: 245),
                color: Colors.black.withOpacity(0.5),
                child: const TabBarView( children: [ Songs(), Albums(), Artists(), Playlists() ]),
              ),
              collapsed: const BottomPanel(),
              panel: const Playing(),
            ),
        ),
    );
  }
}