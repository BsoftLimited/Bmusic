import 'package:bmusic/components/login.dart';
import 'package:bmusic/components/sign_up.dart';
import 'package:bmusic/components/switch_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
    const SignIn({super.key});

    @override
    State<SignIn> createState() => __SignInState();
}

class __SignInState extends State<SignIn> {
    int index = 0;

    void signup(){
        if(index == 0){
            setState(() { index = 1; });
        }
    }

    void login(){
        if(index == 1){
            setState(() { index = 0; });
        }
    }

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;

        return CustomScrollView(slivers: [
            SliverAppBar(elevation: 0,
                title: Text("Sign in", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: theme.primary),),
                leading: Icon(Icons.account_circle, color: theme.primary, size: 34,),
                leadingWidth: 30,
                floating: true, pinned: true,
            ),
            SliverList.list(children: [
                Padding(padding: const EdgeInsets.only(left: 20, right: 20, top: 150),
                    child: IndexedStack(index: index, alignment: Alignment.topCenter, children: [ LoginForm(register: signup), SignUp(login: login) ]),
                )
            ])
        ]);
    }
}