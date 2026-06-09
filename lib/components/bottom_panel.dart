import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:bmusic/blocs/playing_bloc.dart';
import 'package:bmusic/blocs/settings_bloc.dart';
import 'package:bmusic/blocs/states/playing_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class BottomPanel extends StatefulWidget{
    const BottomPanel({super.key});

    @override
    State<StatefulWidget> createState() => __BottomPanelState();
}

class __BottomPanelState extends State<BottomPanel> with AfterLayoutMixin<BottomPanel>{
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

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;

        return BlocBuilder<PlayingBloc, PlayingState>(
            builder: (context, state) {
                SettingsCubit settingsCubit = context.read<SettingsCubit>();

                String title = (settingsCubit.state.songs[state.current])?.title ?? "----";
                String? artist = (settingsCubit.state.songs[state.current])?.artist ?? "--";
                
                return Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: theme.surfaceContainerLowest, borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                    child: Column(children: [
                        Container(alignment: Alignment.topCenter, padding: const EdgeInsets.only(top: 3),
                            child: SizedBox( width: 50, height: 5, child: Divider(color: theme.onSurfaceVariant,  thickness: 2))),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(children: [
                                Padding(padding: const EdgeInsets.only(left: 8, right: 8),
                                    child: Container(
                                        decoration: BoxDecoration(color: theme.surfaceContainerHighest, borderRadius: BorderRadius.circular(10)),
                                        child: Padding(padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                                            child: SvgPicture.asset("files/vectors/arcticons--musicplayer.svg", width: 40, height: 40, colorFilter: ColorFilter.mode(theme.primary, BlendMode.srcIn),),
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
                                    onPressed: () => context.read<PlayingBloc>().togglePlay(),
                                    icon: Icon(state.playing ? Icons.pause_rounded : Icons.play_arrow_rounded),
                                    iconSize: 30,
                                ),
                                IconButton(
                                  onPressed: () => context.read<PlayingBloc>().next(),
                                  icon: const Icon(Icons.skip_next),
                                  iconSize: 30,
                                ),
                            ]),
                        ),
                        SliderTheme(data: SliderTheme.of(context).copyWith( trackHeight: 0.5, thumbColor: theme.primaryFixedDim,
                            thumbShape: const RoundSliderThumbShape( disabledThumbRadius: 0.5, enabledThumbRadius: 0.5),
                            overlayShape: const RoundSliderOverlayShape(overlayRadius: 0.5),
                            activeTrackColor: theme.primary, inactiveTrackColor: Colors.transparent),
                            child: Slider(
                              value: position.toDouble(),
                              min: 0, max: duration.toDouble(),  onChanged: (value){})),
                    ]),
                );
            }
        );
    }
}