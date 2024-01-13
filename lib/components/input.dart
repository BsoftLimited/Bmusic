import 'package:flutter/material.dart';

class Input extends StatefulWidget{
    final String hint;
    final IconData icon;
    final Color color;
    final TextInputType inputType;
    final TextEditingController controller;

    const Input({super.key, required this.hint, required this.icon, required this.controller, this.color = Colors.blue, this.inputType = TextInputType.text });

    @override
    State<StatefulWidget> createState()=> InputState();
}

class InputState extends State<Input>{
    late bool __hide;

    @override
    void initState() {
      __hide = widget.inputType == TextInputType.visiblePassword;
      super.initState();
    }

    OutlineInputBorder __getBorder(Color color){
        return OutlineInputBorder(
            borderSide: BorderSide(width: 2, style: BorderStyle.solid, color: color),
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(8), bottomLeft: Radius.circular(8), bottomRight: Radius.circular(20))
        );
    }

    TextStyle __getStyle()=> TextStyle( fontSize: 14.0, color: widget.color );

    InputDecoration __getDecoration(){
        IconButton? suffixIcon = widget.inputType != TextInputType.visiblePassword ? null : IconButton(
            icon: Icon(__hide ? Icons.remove_red_eye : Icons.visibility_off , size: 20),
            color: widget.color,
            onPressed: (){ setState(()=> __hide = !__hide );});
        return InputDecoration(
            labelText: widget.hint,
            labelStyle: TextStyle( fontSize: 14.0, color: widget.color ),
            focusColor: widget.color,
            border: __getBorder(widget.color),
            enabledBorder: __getBorder(Colors.grey),
            prefixIcon : Icon(widget.icon, size: 20, color: widget.color),
            suffixIcon: suffixIcon
        );
    }

    @override
    Widget build(BuildContext context) {
        return TextFormField(keyboardType: widget.inputType, controller: widget.controller, decoration: __getDecoration(), obscureText: __hide, style: __getStyle());
    }
}