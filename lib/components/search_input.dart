import 'package:flutter/material.dart';

class SearchInput extends StatefulWidget{
    final TextEditingController controller;
    final IconData iconData;
    final String hint;

    const SearchInput({super.key, required this.controller, this.iconData = Icons.search_outlined, this.hint = "search songs"});

    @override
    State<StatefulWidget> createState() => SeachInputState();
}

class SeachInputState extends State<SearchInput>{
    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;
        
        return DecoratedBox(decoration: BoxDecoration( border: Border.fromBorderSide(BorderSide(color: theme.onPrimary, width: 2.0)), borderRadius: BorderRadius.circular(24)),
            child: Row(mainAxisSize: MainAxisSize.max,  children: [
                Padding(padding: const EdgeInsets.only(left: 4),
                    child: SizedBox(width: 40, height: 40,
                        child: DecoratedBox(decoration: BoxDecoration(color: theme.onPrimary, borderRadius: BorderRadius.circular(20)),
                            child: Center( child: Icon( widget.iconData, color: theme.primary, size: 20)),
                        ),
                    ),
                ),
                const SizedBox(width: 5,),
                Expanded(child: TextFormField(controller: widget.controller, style: TextStyle(color: theme.onPrimary), decoration: InputDecoration(hintText: widget.hint, hintStyle: TextStyle(color: theme.onPrimary.withAlpha(176)), border: InputBorder.none),))
            ])
        );
    }

}