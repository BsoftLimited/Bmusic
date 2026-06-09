import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SwitchButton extends StatelessWidget{
    final String label;
    final void Function() onClicked;
    final bool active;

    const SwitchButton({ super.key, this.active = false, required this.label, required this.onClicked });

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;

        final color = active ? theme.surface : theme.primary;
        final textColor = active ? theme.onSurface : theme.onPrimary;

        return SizedBox( width: 150, height: 50,
            child: MaterialButton(onPressed: onClicked, color: color,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                child: Text(label, style: GoogleFonts.acme(color: textColor, fontSize: 16))),
        );
    }
}