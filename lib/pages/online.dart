import 'package:bmusic/blocs/auth/auth_bloc.dart';
import 'package:bmusic/pages/online/downloads.dart';
import 'package:bmusic/pages/online/files.dart';
import 'package:bmusic/pages/online/sign_in.dart';
import 'package:bmusic/pages/online/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Online extends StatelessWidget{
    const Online({ super.key });

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;

        return Container(color: theme.surfaceContainerLowest,
            child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                if (state is Authenticated) {
                    return DefaultTabController(length: 3, child: NestedScrollView(floatHeaderSlivers: true, physics: const NeverScrollableScrollPhysics(),
                        headerSliverBuilder: (context, value) => [
                            SliverAppBar(elevation: 0,
                                title: Text("Music Drive", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: theme.primary),),
                            leading: Icon(Icons.cloud, color: theme.primary, size: 34,),
                            actions: [ IconButton( icon: const Icon(Icons.person_2_outlined), onPressed: (){}) ],
                            leadingWidth: 30,
                            floating: true, pinned: true,
                            bottom: TabBar(labelStyle: const TextStyle(fontSize: 12), indicatorColor: theme.primary, labelColor: theme.primary, unselectedLabelColor: theme.onSurfaceVariant,
                                tabs: const [
                                    Tab(icon: Icon(Icons.file_copy_outlined), iconMargin: EdgeInsets.only(bottom: 6),child: Text("Albums", style: TextStyle(letterSpacing: 1.2),),),
                                    Tab(icon: Icon(Icons.cloud_download_outlined), iconMargin: EdgeInsets.only(bottom: 6), child: Text("Artists", style: TextStyle(letterSpacing: 1.2),)),
                                    Tab(icon: Icon(Icons.person_2_outlined),  iconMargin: EdgeInsets.only(bottom: 6), child: Text("Playlists", style: TextStyle(letterSpacing: 1.2),)),
                                ],
                            ),
                          )
                        ],
                        body: Padding(padding: const EdgeInsets.only(bottom: 120),
                          child: TabBarView( children: [ Files(), FileDownloads(), UserPage() ]),
                        ))
                    );
                }
                return SignIn();
            }),
        );
    }
}