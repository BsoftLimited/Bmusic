import 'package:flutter/material.dart';

class Playlists extends StatelessWidget{
    const Playlists({super.key});

    @override
    Widget build(BuildContext context) {
        return Stack(
            children: [
                DecoratedBox(position: DecorationPosition.foreground,
                    decoration: BoxDecoration(color: Colors.black.withOpacity(0)),
                    child: ClipRRect(child: Image.asset("files/music_record.jpeg", fit: BoxFit.fitWidth,)),)
            ]
        );
    }
}