import 'package:flutter/material.dart';

class AddPlaylist extends StatefulWidget{
    final void Function(String) create;

    const AddPlaylist({ super.key, required this.create });

    @override
    State<StatefulWidget> createState() => __AddPlaylistState();
}

class __AddPlaylistState extends State<AddPlaylist>{
    TextEditingController controller = TextEditingController();

    void save(){
        if(controller.text.isNotEmpty){
            widget.create(controller.text);
            controller.clear();
        }
    }

    @override
    Widget build(BuildContext context) {
        ColorScheme theme = Theme.of(context).colorScheme;

        final textStyle = TextStyle(fontSize: 14, color: theme.onPrimary);

        final inputDecoration = InputDecoration(
            labelText: "Create Playlist",
            labelStyle: TextStyle(color: theme.onPrimary),
            hintText: "specify name of playlist",
            hintStyle: TextStyle(color: theme.onPrimary.withAlpha(176)),
            border: OutlineInputBorder(
                borderSide: BorderSide(width: 2, style: BorderStyle.solid, color: theme.onPrimary),
                borderRadius: BorderRadius.circular(10)
            )
        );

        return SizedBox(height: 50,
            child: Row(children: [
                Expanded(child: TextFormField(controller: controller, style: textStyle, decoration: inputDecoration)),
                SizedBox(width: 4),
                SizedBox(width: 50, height: 50,
                  child: MaterialButton(onPressed: save, color: theme.onPrimary,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Icon(Icons.add, size: 24, color: theme.primary)),
                )
            ]),
        );
    }

}