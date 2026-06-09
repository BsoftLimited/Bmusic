import 'package:flutter/material.dart';

OutlineInputBorder __getBorder(Color color){
    return OutlineInputBorder(
        borderSide: BorderSide(width: 2, style: BorderStyle.solid, color: color),
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(8), bottomLeft: Radius.circular(8), bottomRight: Radius.circular(20))
    );
}

TextStyle __getStyle(Color color)=> TextStyle( fontSize: 14.0, color: color );

InputDecoration __getDecoration({ required IconData icon, required TextInputType inputType, required String hint, required Color color, required Color enabledColor, bool hide = false, void Function()? toggleHide }){
    IconButton? suffixIcon = inputType != TextInputType.visiblePassword ? null : IconButton(
        icon: Icon(hide ? Icons.remove_red_eye : Icons.visibility_off ),
        color: color,
        onPressed: (){
            if(toggleHide != null){
                toggleHide();
            }
        });
    return InputDecoration(
        labelText: hint,
        labelStyle: TextStyle( fontSize: 14.0),
        focusColor: color,
        border: __getBorder(color),
        enabledBorder: __getBorder(enabledColor),
        prefixIcon : Icon(icon, color: color),
        suffixIcon: suffixIcon
    );
}

class Input extends StatefulWidget{
    final String hint;
    final IconData icon;
    final Color? color;
    final TextInputType inputType;
    final TextEditingController controller;
    final String? Function(String?)? validate;

    const Input({super.key, required this.hint, required this.icon, required this.controller, this.validate, this.color, this.inputType = TextInputType.text });

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

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;
        final decoration = __getDecoration(icon: widget.icon, hint: widget.hint, inputType: widget.inputType, enabledColor: theme.onSurfaceVariant, color: widget.color ?? theme.primary, hide: __hide, toggleHide: (){
            if(widget.inputType == TextInputType.visiblePassword){
                setState(() {
                    __hide = !__hide;
                });
            }
        });
        return TextFormField(keyboardType: widget.inputType, controller: widget.controller, validator: widget.validate, decoration: decoration, obscureText: __hide, style: __getStyle( widget.color ?? theme.primary));
    }
}