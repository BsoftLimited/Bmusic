import 'package:bmusic/blocs/library_bloc.dart';
import 'package:bmusic/blocs/playing_bloc.dart';
import 'package:bmusic/blocs/settings_bloc.dart';
import 'package:bmusic/blocs/states/library_state.dart';
import 'package:bmusic/blocs/states/playing_state.dart';
import 'package:bmusic/blocs/states/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mini_music_visualizer/mini_music_visualizer.dart';

class SongView extends StatefulWidget{
    final int? songId, count, index;
    final void Function(int) picked;
    final void Function(int)? options;

    const SongView({super.key, this.songId, this.count, required this.picked, this.options, this.index });

    @override
    State<StatefulWidget> createState() => __SongViewState();
}

class __SongViewState extends State<SongView>{
    void select()=> widget.picked(widget.songId!);

    @override
    Widget build(BuildContext context) {
        final SettingsState settingsState = context.read<SettingsCubit>().state;

        String title = (settingsState.songs[widget.songId])?.title ?? "----";
        String artist = (settingsState.songs[widget.songId])?.artist ?? "--";
        String album = (settingsState.songs[widget.songId])?.album ?? "--";
        
        return IconButton(onPressed: select, splashRadius: 1, padding: EdgeInsets.only(top: 4),
          icon: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start,  mainAxisAlignment: MainAxisAlignment.start, children: [
                  Padding(padding: const EdgeInsets.only(right: 10, left: 10),
                      child: SvgPicture.asset("files/vectors/material-symbols-light--library-music-outline.svg", width: 32, height: 32, colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn))),
                  Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text( title, maxLines: 1, softWrap: true, textAlign: TextAlign.start, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: Colors.white)),
                      const SizedBox(height: 5,),
                      Text("Artist : $artist", maxLines: 1, textAlign: TextAlign.start, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 1.2, color: Colors.white),),
                      const SizedBox(height: 2,),
                      Text("Album : $album", maxLines: 1, textAlign: TextAlign.start, style: const TextStyle(fontSize: 12, color: Colors.white)),
                      if(widget.count != null) ...[
                          const SizedBox(height: 2),
                          Text("Played : ${widget.count}", maxLines: 1, textAlign: TextAlign.start, style: const TextStyle(fontSize: 12, color: Colors.white)),
                      ]
                  ])),
                  Padding(padding: const EdgeInsets.only(right: 8, left: 4),
                      child: BlocBuilder<PlayingBloc, PlayingState>(builder: (context, state){
                          return Row(children:[
                              BlocBuilder<LibraryBloc, LibraryState>(builder: (context, libraryState){
                                  final init = widget.songId != null && state.current != widget.songId && context.read<LibraryBloc>().isFavourite(widget.songId);

                                  return Visibility(visible: init, child: Icon(Icons.favorite, size: 20, color: Colors.white));
                              }),
                              Visibility(visible: widget.songId != null && state.current == widget.songId,
                                  child: MiniMusicVisualizer( color: Colors.white, width: 4, height: 15, animate: state.playing))
                          ]);
                      })
                  )],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  if(widget.options != null) ...[
                      SizedBox(width: 30, height: 30,
                          child: IconButton(padding: EdgeInsets.zero, color: Colors.white, onPressed: (){ widget.options!.call(widget.songId!); },
                              icon: Icon(Icons.menu_sharp, size: 24,)),
                      )
                  ],
                  if(widget.index != null) ...[
                      ReorderableDragStartListener( index: widget.index!,
                          child: Icon(Icons.swap_vert, size: 24, color: Colors.white))
                  ],
              ]),
              SizedBox(height: 4),
              const Divider(thickness: 0.5, height: 1)
          ]),
        );
    }
}