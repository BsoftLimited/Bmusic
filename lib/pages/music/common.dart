import 'dart:math';

import 'package:flutter/material.dart';

SliverAppBar showSliverAppBar({ required BuildContext context, required String screenTitle }) {
    final ColorScheme theme = Theme.of(context).colorScheme;

    return SliverAppBar(backgroundColor: theme.surface,
        floating: true, pinned: true, snap: false,
        title: Text(screenTitle),
        bottom: TabBar(labelStyle: const TextStyle(fontSize: 12), indicatorColor: theme.primary, labelColor: theme.primary, unselectedLabelColor: theme.onSurfaceVariant,
            tabs: const [
                Tab(icon: Icon(Icons.music_note_outlined), iconMargin: EdgeInsets.only(bottom: 6), child: Text("Songs", style: TextStyle(letterSpacing: 1.2),)),
                Tab(icon: Icon(Icons.album), iconMargin: EdgeInsets.only(bottom: 6),child: Text("Albums", style: TextStyle(letterSpacing: 1.2),),),
                Tab(icon: Icon(Icons.people_alt), iconMargin: EdgeInsets.only(bottom: 6), child: Text("Artists", style: TextStyle(letterSpacing: 1.2),)),
                Tab(icon: Icon(Icons.dashboard),  iconMargin: EdgeInsets.only(bottom: 6), child: Text("Playlists", style: TextStyle(letterSpacing: 1.2),)),
            ],
      ),
    );
}


/*SliverList seperatedSilverList({ required int itemCount, required Widget Function(int itemIndex) itemBuilder, required Widget seperator }){
    return SliverList(
        delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
                final int itemIndex = index ~/ 2;
                if (index.isEven) {
                  return itemBuilder(itemIndex);
                }
                return seperator.;
            },
            semanticIndexCallback: (Widget widget, int localIndex) {
                  if (localIndex.isEven) {
                    return localIndex ~/ 2;
                  }
                  return null;
            },
            childCount: max(0, itemCount * 2 - 1),
        ),
      );
}*/