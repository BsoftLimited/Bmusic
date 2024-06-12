import 'package:bmusic/notifier/playing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Playing extends StatefulWidget{

  const Playing({super.key});

  @override
  State<Playing> createState() => __PlayingState();
}

class __PlayingState extends State<Playing> {
  late PlayingStateNotifier playingNotifier;
  late ColorScheme theme;

  Widget initRepeat(){
    IconData iconData = playingNotifier.playMode == PlayMode.sequence ? Icons.repeat_one_rounded : Icons.repeat_rounded;
    Color color = playingNotifier.playMode == PlayMode.sequence ? theme.onSurfaceVariant : theme.primary;

    return Icon(iconData, color: color,);
  }

  @override
  Widget build(BuildContext context) {
    playingNotifier = context.watch<PlayingStateNotifier>();
     theme = Theme.of(context).colorScheme;

    return Column(children:[
      SizedBox( height: 280, child: Stack(
        children: [
          Center( child: Image.asset("files/dance.png", width: 280,),),
          Container( alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: IconButton(onPressed: (){playingNotifier.toggleFavourite(playingNotifier.current); }, 
              icon: Icon(playingNotifier.isFavourite(playingNotifier.current) ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,), iconSize: 24, color: theme.onSurfaceVariant,),
            ),)
        ],
      )),
      const Divider(),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,  children: [
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 8),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text("playing:", style: TextStyle(fontSize: 14, letterSpacing: 1.2, color: theme.onSurfaceVariant, fontWeight: FontWeight.w500),),
                  IconButton(onPressed: (){
                    Navigator.pushNamed(context, "/playlist");
                  }, icon: const Icon(Icons.queue_music_sharp), iconSize: 30, color: theme.onSurfaceVariant,),
              ],),
            ),
            Padding(
              padding: const EdgeInsets.symmetric( vertical: 10, horizontal: 10),
              child: Text(playingNotifier.current.title, maxLines: 1,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, letterSpacing: 1.2, color: theme.primaryFixedDim),),
            ),
            Text("${playingNotifier.current.artist} - ${playingNotifier.current.artist}", style: TextStyle(fontSize: 14, letterSpacing: 1.2, color: theme.secondaryFixedDim),),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FloatingActionButton.small(onPressed: (){ playingNotifier.prev(); }, backgroundColor: Colors.white, elevation: 3, child: Icon(Icons.skip_previous_rounded, color: theme.onSurfaceVariant, size: 20,) ),
                  const SizedBox(width: 8,),
                  FloatingActionButton.small(onPressed: (){}, backgroundColor: Colors.white, elevation: 3, child: Icon(Icons.fast_rewind_rounded, color: theme.onSurfaceVariant, size: 20,)),
                  const SizedBox(width: 8,),
                  Expanded(child: FloatingActionButton.extended(
                    backgroundColor: Colors.white, onPressed: (){ playingNotifier.togglePlay(); }, 
                    extendedPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50), icon: Icon(playingNotifier.playing ? Icons.pause_rounded : Icons.play_arrow_rounded, color: theme.primary, size: 36,),
                    label: Text( playingNotifier.playing ? "Pause" : "Play ", 
                        style: TextStyle(color: theme.primary, fontSize: 18, letterSpacing: 1.2,),),)),
                  const SizedBox(width: 8,),
                  FloatingActionButton.small(onPressed: (){}, backgroundColor: Colors.white, elevation: 3, child: Icon(Icons.fast_forward, color: theme.onSurfaceVariant, size: 20,)),
                  const SizedBox(width: 8,),
                  FloatingActionButton.small(onPressed: (){ playingNotifier.next(); }, backgroundColor: Colors.white, elevation: 3, child: Icon(Icons.skip_next_rounded, color: theme.onSurfaceVariant, size: 20,),),
                ],
              ),
            ),
            Column(
              children: [
                SliderTheme(data: SliderTheme.of(context).copyWith( trackHeight: 2, thumbColor: theme.primaryFixedDim, overlayColor: theme.primary,
                    thumbShape: const RoundSliderThumbShape( disabledThumbRadius: 5, enabledThumbRadius: 5),
                    overlayShape: const RoundSliderOverlayShape(overlayRadius: 10),
                    activeTrackColor: theme.primary, inactiveTrackColor: theme.onSurfaceVariant),
                    child: Slider(value: 0,  onChanged: (double value) {  },)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text("00:00", style: TextStyle(fontSize: 14, letterSpacing: 1.2, color: theme.onSurfaceVariant),),
                      IconButton(onPressed: (){ playingNotifier.togglePlayMode(); },
                          icon: initRepeat(),
                          iconSize: 24, color: theme.onSurfaceVariant,),
                  ],),
                )
              ],
            )
              ],),
        )
      )    
    ]);
  }
}