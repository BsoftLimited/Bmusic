import 'package:bmusic/components/bottom_panel.dart';
import 'package:bmusic/pages/music/albums.dart';
import 'package:bmusic/pages/music/artist.dart';
import 'package:bmusic/pages/music/playlists.dart';
import 'package:bmusic/pages/music/songs.dart';
import 'package:bmusic/components/playing.dart';
import 'package:bmusic/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MusicPlayer extends StatefulWidget {
    const MusicPlayer({super.key});

    @override
    State<StatefulWidget> createState() => __MusicPlayerState();
}

class __MusicPlayerState extends State<MusicPlayer> with SingleTickerProviderStateMixin {
    late TabController _tabController;
    final ScrollController _scrollController = ScrollController();
    double _scrollOffset = 0;
    final double _maxOffset = 120;
    final int _tabCount = 4;

    int tabIndex = 0;

    void _onScroll() => setState(() {
        _scrollOffset = _scrollController.offset.clamp(0, _maxOffset).toDouble();
    });

    Color get _appBarColor {
        final opacity = (_scrollOffset / _maxOffset).clamp(0, 1) * 255;
        return Colors.white.withAlpha(opacity.ceil());
    }
    
    Color _songIconColor(Color activeColor){
        if(tabIndex == 0){
            return activeColor;
        }
        return _scrollOffset > _maxOffset * 0.5 ? Colors.grey : Colors.white;
    }

    @override
    void initState() {
        super.initState();
        _tabController = TabController(length: _tabCount, vsync: this);
        _scrollController.addListener(_onScroll);
    }

    @override
    Widget build(BuildContext context) {
      final ColorScheme theme = Theme.of(context).colorScheme;

      return SlidingUpPanel(backdropEnabled: true, minHeight: 90,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          collapsed: const BottomPanel(),
          panel: const Playing(),
          body: NestedScrollView(floatHeaderSlivers: false, physics: const NeverScrollableScrollPhysics(),
              controller: _scrollController,
              headerSliverBuilder: (context, value) => [
                  SliverAppBar(backgroundColor: _appBarColor,
                      title: AnimatedOpacity(
                          duration: const Duration(milliseconds: 150),
                          opacity: _scrollOffset < _maxOffset * 0.5 ? 1 : 0,
                          child: Text("B-Music", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: theme.onPrimary),)),
                      leading: Icon(Icons.speaker, color: theme.onPrimary, size: 28,),
                      actions: [ IconButton( icon: const Icon(Icons.search), color: theme.onPrimary, onPressed: ()=>Navigator.pushNamed(context, Search.routeName) ) ],
                      leadingWidth: 30,
                      floating: true, pinned: true, snap: true,
                      bottom: TabBar(labelStyle: const TextStyle(fontSize: 12), indicatorColor: theme.primaryContainer, labelColor: theme.primaryContainer,
                          controller: _tabController,
                          unselectedLabelColor: _scrollOffset > _maxOffset * 0.5 ? Colors.grey : Colors.white,
                          tabs: [
                              Tab(icon: SvgPicture.asset("files/vectors/glyphs--music-list-bold.svg", colorFilter: ColorFilter.mode(_songIconColor(theme.primaryContainer), BlendMode.srcIn), width: 32, height: 32), child: Text("Songs", style: TextStyle(letterSpacing: 1.2),)),
                              Tab(icon: Icon(Icons.album), iconMargin: EdgeInsets.only(bottom: 6),child: Text("Albums", style: TextStyle(letterSpacing: 1.2),),),
                              Tab(icon: Icon(Icons.people_alt), iconMargin: EdgeInsets.only(bottom: 6), child: Text("Artists", style: TextStyle(letterSpacing: 1.2),)),
                              Tab(icon: Icon(Icons.dashboard),  iconMargin: EdgeInsets.only(bottom: 6), child: Text("Playlists", style: TextStyle(letterSpacing: 1.2),)),
                          ],
                          onTap: (index){
                              setState(() { tabIndex = index; });
                          }
                      ),
                  )
              ],
              body: Padding(padding: const EdgeInsets.only(bottom: 30, top: 0),
                  child: TabBarView(controller: _tabController, children: [ Songs(), Albums(), Artists(), Playlists() ]),
              ))
      );
  }
}