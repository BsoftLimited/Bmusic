import 'package:bmusic/blocs/states/uploads_state.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class UploadView extends StatelessWidget{
    final Upload upload;

    const UploadView({ super.key, required this.upload });

    @override
    Widget build(BuildContext context) {
        return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('Selected file: ${upload.music.name}', style: const TextStyle(fontSize: 16),),
            const SizedBox(height: 20),
            if (upload.status.isUploading) ...[
                LinearPercentIndicator(width: MediaQuery.of(context).size.width - 100,
                    lineHeight: 20.0,
                    center: Text("Uploading"),
                    barRadius: const Radius.circular(10), progressColor: Colors.blue),
                    const SizedBox(height: 20),
                    const Text('Uploading to Supabase...', style: TextStyle(fontSize: 16)),
            ] else if (upload.status.isComplete) ...[
                const Icon(Icons.check_circle, color: Colors.green, size: 50),
                const SizedBox(height: 20),
                const Text('Upload complete!', style: TextStyle(fontSize: 18)),
            ],
          ],
        );
    }
}