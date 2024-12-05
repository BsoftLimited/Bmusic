import 'package:bmusic/notifier/artists.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArtistView extends StatelessWidget{
    final int index;

    const ArtistView({super.key, required this.index });    

    @override
    Widget build(BuildContext context) {
        ArtistNotifier artistNotifier = context.watch<ArtistNotifier>();

        ColorScheme theme = Theme.of(context).colorScheme;

        void select(){}
        
        return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            TextButton( onPressed: select,
                child: Row(crossAxisAlignment: CrossAxisAlignment.start,  mainAxisAlignment: MainAxisAlignment.start, children: [
                    Padding(padding: const EdgeInsets.only(right: 10, left: 10), child: Icon(Icons.people_alt, size: 28, color: theme.primary,)),
                    Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text( artistNotifier.artistNames[index], maxLines: 1, textAlign: TextAlign.start, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 1.2, color: theme.primaryFixedDim,)),
                        const SizedBox(height: 5,),
                        Text("${artistNotifier.songs(artistNotifier.artistNames[index]).length} songs", maxLines: 1, textAlign: TextAlign.start, style: const TextStyle(fontSize: 12, color: Colors.white),)
                    ],))
                ]),
            ),
        ]);
    }
}