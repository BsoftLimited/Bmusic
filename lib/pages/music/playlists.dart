import 'package:bmusic/pages/music/common.dart';
import 'package:flutter/material.dart';

class Playlists extends StatelessWidget{
    const Playlists({super.key});

    @override
    Widget build(BuildContext context) {
        return CustomScrollView(
            slivers: [
                showSliverAppBar(context: context, screenTitle: "Playlist"),
            ],
        );
    }
}