import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:bmusic/blocs/auth/auth_bloc.dart';
import 'package:bmusic/blocs/settings_bloc.dart';
import 'package:bmusic/blocs/states/settings_state.dart';
import 'package:bmusic/components/input.dart';
import 'package:bmusic/components/submit_button.dart';
import 'package:bmusic/repositories/models/details.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
    final void Function() register;

    const LoginForm({super.key, required this.register });

    @override
    State<StatefulWidget> createState() => __LoginFormState();
}

class __LoginFormState extends State<LoginForm> with AfterLayoutMixin {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final __formKey = GlobalKey<FormState>();

    @override
    FutureOr<void> afterFirstLayout(BuildContext context) {
        SettingsState settingsState = context.read<SettingsCubit>().state;
        if(settingsState.detail != null){
            emailController.text = settingsState.detail!.email;
            passwordController.text = settingsState.detail!.password;
        }
    }

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;

        return BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
                if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)),);
                }
            },
            child: Form(key: __formKey, child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min,
                children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.end, children: [
                        Text("Login", style: TextStyle( fontSize: 20.0, fontWeight: FontWeight.bold, color: theme.primary), textAlign: TextAlign.left),
                        IconButton(color: theme.secondary, onPressed: () {},
                            icon: DecoratedBox(decoration: BoxDecoration(shape: BoxShape.circle, color: theme.secondary),
                                child: Padding(padding: const EdgeInsets.all(4.0),
                                    child: Icon(Icons.question_mark_rounded, size: 18, color: theme.onSecondary),
                                )))
                    ]),
                    const SizedBox(height: 10),
                    Input(hint: "Email Address", icon: Icons.email, controller: emailController, inputType: TextInputType.emailAddress),
                    const SizedBox(height: 15),
                    Input(hint: "password", icon: Icons.lock, inputType: TextInputType.visiblePassword, controller: passwordController),
                    Container(alignment: Alignment.centerRight, child: TextButton(onPressed: () {},
                        child: const Text("Forgotten Password", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)))),
                    BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                        return SubmitButton(label: 'Login', loading: state is AuthLoading, onClicked: () {
                            if (__formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(LoginWithEmail(email: emailController.text.trim(), password: passwordController.text.trim()));
                            }
                        });
                    }),
                    const SizedBox(height: 10),
                    RichText(text: TextSpan(text: "Don't have an account ? ", style: TextStyle(color: theme.primary), children: [
                        TextSpan(text: "Register", style: TextStyle(fontWeight: FontWeight.bold), recognizer: TapGestureRecognizer()..onTap = widget.register)
                    ]))
                ]),
            )
        );
    }

    @override
    void dispose() {

        super.dispose();
    }
}
