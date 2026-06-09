import 'dart:io';
import 'package:bmusic/blocs/states/uploads_state.dart';
import 'package:bmusic/blocs/uploads_cubit.dart';
import 'package:bmusic/components/upload_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FileUploadPage extends StatelessWidget {
    const FileUploadPage({ super.key });

    @override
    Widget build(BuildContext context) {
        return BlocBuilder<UploadsCubit, UploadsState>(
            builder: (buildContext, state){
                return ListView.separated(itemCount: state.uploads.length, padding: const EdgeInsets.only(bottom: 140),
                    itemBuilder: (BuildContext context, int index) => UploadView(upload: state.uploads[index]),
                    separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 8)
                );
            });
    }
}