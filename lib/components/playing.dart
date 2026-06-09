import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:bmusic/blocs/library_bloc.dart';
import 'package:bmusic/blocs/playing_bloc.dart';
import 'package:bmusic/blocs/settings_bloc.dart';
import 'package:bmusic/blocs/states/library_state.dart';
import 'package:bmusic/blocs/states/playing_state.dart';
import 'package:bmusic/utils/util.dart';
import 'package:flutter/material.dart' hide RepeatMode;
import 'package:flutter_bloc/flutter_bloc.dart';

class Playing extends StatefulWidget{
    const Playing({super.key});

    @override
    State<Playing> createState() => __PlayingState();
}

class __PlayingState extends State<Playing> with AfterLayoutMixin<Playing> {
    late ColorScheme theme;
    int duration = 0, position = 0;

    @override
    FutureOr<void> afterFirstLayout(BuildContext context) {
        context.read<PlayingBloc>().addDurationListener((duration){
            setState(()=> this.duration = duration);
        });

        context.read<PlayingBloc>().addPositionListener((position){
            setState(()=> this.position = position);
        });
    }

    Widget initRepeat(){
        IconData iconData;
        switch(context.read<PlayingBloc>().state.repeatMode){
            case RepeatMode.single:
                iconData = Icons.repeat_one_rounded;
                break;
            default:
                iconData = Icons.repeat_rounded;
        }
        return Icon(iconData, color: theme.primary.withValues( alpha: context.read<PlayingBloc>().state.repeatMode == RepeatMode.off ? 0.4 : 1),);
    }

    Widget initSurffle(){
        IconData iconData = Icons.shuffle;
        return Icon(iconData, color:  theme.primary.withValues( alpha: context.read<PlayingBloc>().state.shuffleMode == ShuffleMode.off ? 0.4 : 1));
    }

    void seek(double value) => context.read<PlayingBloc>().seek = value.floor();
    void next() => context.read<PlayingBloc>().next();
    void prev() => context.read<PlayingBloc>().prev();
    void fastForward() => context.read<PlayingBloc>().seek = position + 10;
    void rewind() => context.read<PlayingBloc>().seek = position - 10;

    @override
    Widget build(BuildContext context) {
        theme = Theme.of(context).colorScheme;
        LibraryBloc libraryBloc = context.read<LibraryBloc>();
        
        final songs = context.read<SettingsCubit>().state.songs;

        return BlocBuilder<PlayingBloc, PlayingState>(
            builder: (context, state) {
                String title = songs[state.current]?.title ?? "----";
                String artist = songs[state.current]?.artist ?? "--";

                return Stack(fit: StackFit.expand,
                    children: [
                        DecoratedBox( position: DecorationPosition.foreground,
                            decoration: BoxDecoration(gradient: LinearGradient(
                              colors: [Colors.transparent, theme.surfaceContainerLowest.withValues(alpha: 0.6), theme.surfaceContainerLowest, theme.surfaceContainerLowest],
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
                                    child: IconButton(onPressed: (){ libraryBloc.toggleFavourite(state.current); },
                                    icon: BlocBuilder<LibraryBloc, LibraryState>(builder: (context, libraryState){
                                        return Icon(libraryBloc.isFavourite(state.current) ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined);
                                    }),
                                    iconSize: 24, color: theme.onSurfaceVariant,),
                                ),),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.center,  children: [
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                      IconButton(onPressed: context.read<PlayingBloc>().toggleShuffleMode, icon: initSurffle(), iconSize: 24, color: theme.onSurfaceVariant,),
                                      Row(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                          IconButton(onPressed: context.read<PlayingBloc>().toggleRepeatMode,
                                                icon: initRepeat(),
                                                iconSize: 24, color: theme.onSurfaceVariant,),
                                          IconButton(onPressed: (){ Navigator.pushNamed(context, "playlist");},
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
                                        FloatingActionButton.small(onPressed: prev, backgroundColor: theme.surfaceContainerHighest, elevation: 3, child: Icon(Icons.skip_previous_rounded, color: theme.onSurfaceVariant, size: 20,) ),
                                        const SizedBox(width: 8,),
                                        FloatingActionButton.small(onPressed: rewind, backgroundColor: theme.surfaceContainerHighest, elevation: 3, child: Icon(Icons.fast_rewind_rounded, color: theme.onSurfaceVariant, size: 20,)),
                                        const SizedBox(width: 8,),
                                        SizedBox(width: 70, height: 70,
                                          child: FloatingActionButton(
                                            backgroundColor: theme.surfaceContainerHighest, onPressed: context.read<PlayingBloc>().togglePlay,
                                            shape: const CircleBorder(),
                                            //extendedPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
                                          child: Icon(state.playing ? Icons.pause_rounded : Icons.play_arrow_rounded, color: theme.primary, size: 45,),
                                            //label: Text( playingNotifier.playing ? "Pause" : "Play ", 
                                                //style: TextStyle(color: theme.primary, fontSize: 18, letterSpacing: 1.2,),),)
                                          ),
                                        ),
                                        const SizedBox(width: 8,),
                                        FloatingActionButton.small(onPressed: fastForward, backgroundColor: theme.surfaceContainerHighest, elevation: 3, child: Icon(Icons.fast_forward, color: theme.onSurfaceVariant, size: 20,)),
                                        const SizedBox(width: 8,),
                                        FloatingActionButton.small(onPressed: next, backgroundColor: theme.surfaceContainerHighest, elevation: 3, child: Icon(Icons.skip_next_rounded, color: theme.onSurfaceVariant, size: 20,),),
                                      ],
                                    ), 
                                  ),
                                  Column(
                                      children: [
                                          SliderTheme(data: SliderTheme.of(context).copyWith( trackHeight: 1, thumbColor: theme.primaryFixedDim, overlayColor: theme.primary,
                                              thumbShape: const RoundSliderThumbShape( disabledThumbRadius: 3, enabledThumbRadius: 3),
                                              overlayShape: const RoundSliderOverlayShape(overlayRadius: 10),
                                              activeTrackColor: theme.primary, inactiveTrackColor: theme.onSurfaceVariant),
                                              child: Slider(value: position.toDouble(), min: 0, max: duration.toDouble(),  onChanged: seek,)),
                                          Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                  Text(Util.displayDuration(position), style: TextStyle(fontSize: 14, letterSpacing: 1.2, color: theme.onSurfaceVariant),),
                                                  Text(Util.displayDuration(duration), style: TextStyle(fontSize: 14, letterSpacing: 1.2, color: theme.onSurfaceVariant),),
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
        );
    }
}