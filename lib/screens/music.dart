import 'package:bmusic/components/bottom_panel.dart';
import 'package:bmusic/pages/music/albums.dart';
import 'package:bmusic/pages/music/artist.dart';
import 'package:bmusic/pages/music/genre.dart';
import 'package:bmusic/pages/music/songs.dart';
import 'package:bmusic/pages/playing.dart';
import 'package:bmusic/notifier/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Music extends StatefulWidget{
  const Music({super.key});

  @override
  State<StatefulWidget> createState() => __MusicState();
}

class __MusicState extends State<Music>{
  final PanelController panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    ThemeNotifier themeNotifier = context.watch<ThemeNotifier>();

    return DefaultTabController( length: 4,
      child: Scaffold(
          appBar: AppBar(backgroundColor: themeNotifier.current.light, elevation: 0,
              title: Text('Music', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: themeNotifier.current.primary),),
              leading: Icon(Icons.playlist_play_rounded, color: themeNotifier.current.primary, size: 34,),
              actions: [ IconButton( icon: const Icon(Icons.search), onPressed: (){} ) ],
          leadingWidth: 30,
          bottom: TabBar( labelStyle: const TextStyle(fontSize: 12), indicatorColor: themeNotifier.current.primary, labelColor: themeNotifier.current.primary,
              unselectedLabelColor: themeNotifier.current.dark,
              tabs: const [
                Tab(icon: Icon(Icons.music_note_outlined), iconMargin: EdgeInsets.only(bottom: 6), child: Text("Songss", style: TextStyle(letterSpacing: 1.2),)),
                Tab(icon: Icon(Icons.album), iconMargin: EdgeInsets.only(bottom: 6),child: Text("Albums", style: TextStyle(letterSpacing: 1.2),),),
                Tab(icon: Icon(Icons.people_alt), iconMargin: EdgeInsets.only(bottom: 6), child: Text("Artists", style: TextStyle(letterSpacing: 1.2),)),
                Tab(icon: Icon(Icons.mic),  iconMargin: EdgeInsets.only(bottom: 6), child: Text("Genre", style: TextStyle(letterSpacing: 1.2),)),
              ],
          ),
        ),
        body: SlidingUpPanel(
              maxHeight: 600, minHeight: 70, backdropEnabled: true,
              controller: panelController,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              body: TabBarView( children: [ Songs(), const Albums(), const Artists(), const Genre() ]),
              collapsed: const BottomPanel(),
              panel: const Playing(),
            ),
        ),
    );
  }
}