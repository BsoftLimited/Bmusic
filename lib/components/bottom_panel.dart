import 'package:bmusic/blocs/playing_bloc.dart';
import 'package:bmusic/blocs/settings_bloc.dart';
import 'package:bmusic/blocs/states/playing_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomPanel extends StatefulWidget{
    const BottomPanel({super.key});

    @override
    State<StatefulWidget> createState() => __BottomPanelState();
}

class __BottomPanelState extends State<BottomPanel>{
    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;
        final SettingsCubit settingsCubit = context.read<SettingsCubit>();
        final PlayingBloc playingBloc = context.read<PlayingBloc>();
        
        return BlocBuilder<PlayingBloc, PlayingState>(
            builder: (context, state) {
                String title = (settingsCubit.state.songs[state.current])?.title ?? "----";
                String? artist = (settingsCubit.state.songs[state.current])?.artist ?? "--";
                
                return Container(decoration: BoxDecoration(color: theme.surface, borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                  child: Column(children: [
                      Container(alignment: Alignment.topCenter, padding: const EdgeInsets.only(top: 3),
                          child: SizedBox( width: 50, height: 5, child: Divider(color: theme.onSurfaceVariant,  thickness: 2))),
                      Row(children: [
                          Padding(padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Container(
                                  decoration: BoxDecoration(color: const Color.fromARGB(255, 218, 225, 230), borderRadius: BorderRadius.circular(10)),
                                  child: Padding(padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                                      child: Icon( Icons.music_note, size: 40, color: theme.primary),
                                  ),
                              ),
                          ),
                          Expanded( child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  Text(title, maxLines: 1, textAlign: TextAlign.start,
                                      style: const TextStyle( fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 1.2)),
                                  const SizedBox( height: 6),
                                  Text( "artist: $artist", textAlign: TextAlign.start, maxLines: 1,
                                      style: TextStyle( fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 1.2, color: theme.onSurfaceVariant)),
                                ],
                          )),
                          IconButton(
                              onPressed: () => playingBloc.togglePlay(),
                              icon: Icon(state.playing ? Icons.pause_rounded : Icons.play_arrow_rounded),
                              iconSize: 30,
                          ),
                          IconButton(
                            onPressed: () => playingBloc.next(),
                            icon: const Icon(Icons.skip_next),
                            iconSize: 30,
                          ),
                      ])
                  ]),
                );
            }
        );
    }
}