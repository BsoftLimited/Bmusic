import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget{
    final bool enabled, loading;
    final String label;
    final void Function() onClicked;

    const SubmitButton({ super.key, required this.label, required this.onClicked, this.enabled = true, this.loading = false });

    @override
    Widget build(BuildContext context) {
        ColorScheme theme = Theme.of(context).colorScheme;

        return Row(children: [
            Expanded(child: MaterialButton(color: theme.secondary,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                onPressed: enabled || !loading ? onClicked : null,
                child: Padding(padding: EdgeInsets.only(top: 14, bottom: 14),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                        Expanded(child: Text('Sign Up', style: TextStyle(color: theme.onSecondary))),
                        if (loading) ...[ const CircularProgressIndicator() ]
                    ])
                )
            )),
        ]);
    }
}