import 'package:bmusic/components/form.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget{
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Align(alignment: Alignment.topRight, child: SafeArea(minimum: const EdgeInsets.all(10),
              child: SizedBox(width: 34, height: 34,
                  child: FloatingActionButton( mini: true, elevation: 2, onPressed: () {},
                      child: const Icon(Icons.question_mark_rounded, color: Colors.white))))),
      Expanded(child: Image.asset("files/ic_splash.png")),
      const LoginForm(),
    ]);
  }
}