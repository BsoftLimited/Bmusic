import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlaylistItem extends StatelessWidget{
    final String label, icon;
    final void Function(String)? selected;

    const PlaylistItem({ super.key, required this.icon, required this.label, this.selected });

    @override
    Widget build(BuildContext context) {
        ColorScheme theme = Theme.of(context).colorScheme;

        return TextButton(onPressed: (){ selected?.call(label); },
            style: ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.zero)),
            child: Container(width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: theme.surface, width: 2),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                    SvgPicture.asset("files/vectors/$icon", width: 36, height: 36, colorFilter: ColorFilter.mode(theme.onPrimary, BlendMode.srcIn)),
                    SizedBox(height: 4),
                    Text(label, style: TextStyle(color: theme.onPrimary, fontSize: 12, fontWeight: FontWeight.w600)),
                ])
            ),
        );
    }
}

class PlaylistContainer extends StatelessWidget{
    final List<PlaylistItem> list;
    const PlaylistContainer({ super.key, required this.list });

    @override
    Widget build(BuildContext context) {
        return GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 1),
          children: list,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
        );
    }
}