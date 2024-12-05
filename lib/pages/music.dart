import 'package:bmusic/components/bottom_panel.dart';
import 'package:bmusic/pages/music/albums.dart';
import 'package:bmusic/pages/music/artist.dart';
import 'package:bmusic/pages/music/playlists.dart';
import 'package:bmusic/pages/music/songs.dart';
import 'package:bmusic/components/playing.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Music extends StatelessWidget{
  const Music({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;

    return SlidingUpPanel(maxHeight: 550, minHeight: 70, backdropEnabled: true,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            collapsed: const BottomPanel(),
            panel: const Playing(),
            body: DefaultTabController( length: 4, 
                child: NestedScrollView(floatHeaderSlivers: true, physics: const NeverScrollableScrollPhysics(),
                    headerSliverBuilder: (context, value) => [
                        SliverAppBar(backgroundColor: theme.surface, elevation: 0,
                            title: Text("Music Player", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: theme.primary),),
                            leading: Icon(Icons.speaker, color: theme.primary, size: 34,),
                            actions: [ IconButton( icon: const Icon(Icons.search), onPressed: ()=>Navigator.pushNamed(context, "/search") ) ],
                            leadingWidth: 30,
                            floating: true, pinned: true,
                            bottom: TabBar(labelStyle: const TextStyle(fontSize: 12), indicatorColor: theme.primary, labelColor: theme.primary, unselectedLabelColor: theme.onSurfaceVariant,
                                tabs: const [
                                    Tab(icon: Icon(Icons.music_note_outlined), iconMargin: EdgeInsets.only(bottom: 6), child: Text("Songs", style: TextStyle(letterSpacing: 1.2),)),
                                    Tab(icon: Icon(Icons.album), iconMargin: EdgeInsets.only(bottom: 6),child: Text("Albums", style: TextStyle(letterSpacing: 1.2),),),
                                    Tab(icon: Icon(Icons.people_alt), iconMargin: EdgeInsets.only(bottom: 6), child: Text("Artists", style: TextStyle(letterSpacing: 1.2),)),
                                    Tab(icon: Icon(Icons.dashboard),  iconMargin: EdgeInsets.only(bottom: 6), child: Text("Playlists", style: TextStyle(letterSpacing: 1.2),)),
                                ],
                            ),
                        )
                    ],
                    body: const TabBarView( children: [ Songs(), Albums(), Artists(), Playlists() ])))
      );
  }
}