import 'package:bmusic/blocs/downloads_cubit.dart';
import 'package:bmusic/blocs/states/downloads_state.dart';
import 'package:bmusic/components/download_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FileDownloads extends StatefulWidget {

    const FileDownloads({ super.key });

    @override
    State<FileDownloads> createState() => __FileDownloads();
}

class __FileDownloads extends State<FileDownloads> {
    @override
    Widget build(BuildContext context) {
        return BlocBuilder<DownloadsCubit, DownloadsState>(
            builder: (buildContext, state){
                return ListView.separated(itemCount: state.downloads.length, padding: const EdgeInsets.only(bottom: 140),
                    itemBuilder: (BuildContext context, int index) => DownloadView(download: state.downloads[index]),
                    separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 8)
                );
            });
    }
}