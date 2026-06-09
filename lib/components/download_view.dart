import 'package:bmusic/blocs/states/downloads_state.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DownloadView extends StatelessWidget{
    final Download download;

    const DownloadView({ super.key, required this.download });

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;

        return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            if (download.status.isDownloading) ...[
                LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width - 100, lineHeight: 20.0,
                    center: Text("Downloading"),
                    barRadius: const Radius.circular(10),
                    progressColor: theme.primary,
                ),
                const SizedBox(height: 20),
                Text('Downloading ${download.music.name}...', style: const TextStyle(fontSize: 16)),
            ] else if (download.status.isComplete) ...[
                const Icon(Icons.check_circle, color: Colors.green, size: 50),
                const SizedBox(height: 20),
                Text('Download complete!', style: const TextStyle(fontSize: 18)),
                Text('Saved to: ${ download.localPath }', style: const TextStyle(fontSize: 14), textAlign: TextAlign.center),
            ] else ...[
                ElevatedButton( onPressed: (){}, child: const Text('Start Download')),
            ],
        ]);
    }
}