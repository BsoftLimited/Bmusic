import 'package:bmusic/notifier/playing.dart';
import 'package:bmusic/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
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
      IconData iconData;
      switch(playingNotifier.repeatMode){
          case RepeatMode.single:
              iconData = Icons.repeat_one_rounded;
              break;
          default:
              iconData = Icons.repeat_rounded;
      }
      return Icon(iconData, color: theme.primary.withOpacity(playingNotifier.repeatMode == RepeatMode.off ? 0.4 : 1),);
  }

  Widget initSuffle(){
      IconData iconData = Icons.shuffle;
      return Icon(iconData, color:  theme.primary.withOpacity(playingNotifier.shuffleMode == ShuffleMode.off ? 0.4 : 1));
  }

  @override
  Widget build(BuildContext context) {
      playingNotifier = context.watch<PlayingStateNotifier>();
      theme = Theme.of(context).colorScheme;

      String title = playingNotifier.current != null ? (playingNotifier.current as SongModel).title : "----";
      String? artist = playingNotifier.current != null ? (playingNotifier.current as SongModel).artist : "--";

      void seek(double value) => playingNotifier.seek = value.floor();
      void next() => playingNotifier.next();
      void prev() => playingNotifier.prev();
      void fastForward() => playingNotifier.seek = playingNotifier.position.inSeconds + 10;
      void rewind() => playingNotifier.seek = playingNotifier.position.inSeconds - 10;

      return Stack(fit: StackFit.expand,
          children: [
              DecoratedBox( position: DecorationPosition.foreground,
                  decoration: BoxDecoration(gradient: LinearGradient(
                    colors: [Colors.transparent, theme.surface.withOpacity(0.6), theme.surface, theme.surface],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0, 0.28, 0.46, 1]
                  ),),
                  child: Column(
                    children: [
                      ClipRRect(borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                  child: Image.asset("files/lady.jpeg", fit: BoxFit.fitHeight, height: 300,)),
                      Expanded(child: Container())
                    ],
                  ),
              ),
              Column(children:[
                  Container(height: 250, alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: IconButton(onPressed: (){playingNotifier.toggleFavourite(playingNotifier.current); }, 
                        icon: Icon(playingNotifier.isFavourite(playingNotifier.current) ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,), iconSize: 24, color: theme.onSurfaceVariant,),
                      ),),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.center,  children: [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            IconButton(onPressed: playingNotifier.toggleShuffleMode, icon: initSuffle(), iconSize: 24, color: theme.onSurfaceVariant,),
                            Row(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                IconButton(onPressed: playingNotifier.toggleRepeatMode,
                                      icon: initRepeat(),
                                      iconSize: 24, color: theme.onSurfaceVariant,),
                                IconButton(onPressed: (){ Navigator.pushNamed(context, "/playlist");},
                                    icon: const Icon(Icons.queue_music_sharp), iconSize: 28, color: theme.onSurfaceVariant,),
                            ],),
                        ],),
                        Padding(
                          padding: const EdgeInsets.symmetric( vertical: 10, horizontal: 10),
                          child: Text(title, maxLines: 1,
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, letterSpacing: 1.2, color: theme.primary),),
                        ),
                        Text("$artist - $artist", maxLines: 1, style: TextStyle(fontSize: 14, letterSpacing: 1.2, color: theme.secondary),),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FloatingActionButton.small(onPressed: prev, backgroundColor: Colors.white, elevation: 3, child: Icon(Icons.skip_previous_rounded, color: theme.onSurfaceVariant, size: 20,) ),
                              const SizedBox(width: 8,),
                              FloatingActionButton.small(onPressed: rewind, backgroundColor: Colors.white, elevation: 3, child: Icon(Icons.fast_rewind_rounded, color: theme.onSurfaceVariant, size: 20,)),
                              const SizedBox(width: 8,),
                              SizedBox(width: 70, height: 70,
                                child: FloatingActionButton(
                                  backgroundColor: Colors.white, onPressed: (){ playingNotifier.togglePlay(); }, 
                                  shape: const CircleBorder(),
                                  //extendedPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
                                child: Icon(playingNotifier.playing ? Icons.pause_rounded : Icons.play_arrow_rounded, color: theme.primary, size: 45,),
                                  //label: Text( playingNotifier.playing ? "Pause" : "Play ", 
                                      //style: TextStyle(color: theme.primary, fontSize: 18, letterSpacing: 1.2,),),)
                                ),
                              ),
                              const SizedBox(width: 8,),
                              FloatingActionButton.small(onPressed: fastForward, backgroundColor: Colors.white, elevation: 3, child: Icon(Icons.fast_forward, color: theme.onSurfaceVariant, size: 20,)),
                              const SizedBox(width: 8,),
                              FloatingActionButton.small(onPressed: next, backgroundColor: Colors.white, elevation: 3, child: Icon(Icons.skip_next_rounded, color: theme.onSurfaceVariant, size: 20,),),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            SliderTheme(data: SliderTheme.of(context).copyWith( trackHeight: 2, thumbColor: theme.primaryFixedDim, overlayColor: theme.primary,
                                thumbShape: const RoundSliderThumbShape( disabledThumbRadius: 5, enabledThumbRadius: 5),
                                overlayShape: const RoundSliderOverlayShape(overlayRadius: 10),
                                activeTrackColor: theme.primary, inactiveTrackColor: theme.onSurfaceVariant),
                                child: Slider(
                                    value: playingNotifier.position.inSeconds.toDouble(),
                                    min: 0, max: playingNotifier.duration.inSeconds.toDouble(),  onChanged: seek,)),
                            Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                    Text(Util.displayDuration(playingNotifier.position), style: TextStyle(fontSize: 14, letterSpacing: 1.2, color: theme.onSurfaceVariant),),
                                    Text(Util.displayDuration(playingNotifier.duration), style: TextStyle(fontSize: 14, letterSpacing: 1.2, color: theme.onSurfaceVariant),),
                                ],),
                            )
                          ],
                        )
                          ],),
                    )
                  )    
            ]), 
      ]);
  }
}