import 'package:bmusic/blocs/auth/auth_bloc.dart';
import 'package:bmusic/components/input.dart';
import 'package:bmusic/components/submit_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatefulWidget {
    final void Function() login;

    const SignUp({super.key, required this.login });

    @override
    State<SignUp> createState() => __SignUpState();
}

class __SignUpState extends State<SignUp> {
    final _formKey = GlobalKey<FormState>();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _firstNameController = TextEditingController();
    final _lastNameController = TextEditingController();
    final _usernameController = TextEditingController();

    @override
    void dispose() {
        _emailController.dispose();
        _passwordController.dispose();
        _firstNameController.dispose();
        _lastNameController.dispose();
        _usernameController.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;

        return BlocListener<AuthBloc, AuthState>(listener: (context, state) {
            if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)),);
            }
        },
        child: Form(key: _formKey,
            child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text("Register", style: TextStyle( fontSize: 20.0, fontWeight: FontWeight.bold, color: theme.primary), textAlign: TextAlign.left),
                    IconButton(color: theme.secondary, onPressed: () {},
                        icon: DecoratedBox(decoration: BoxDecoration(shape: BoxShape.circle, color: theme.secondary),
                            child: Padding(padding: const EdgeInsets.all(4.0),
                              child: Icon(Icons.question_mark_rounded, size: 18, color: theme.onSecondary),
                            )))
                ]),
                const SizedBox(height: 10),
                Input( hint: 'First Name', controller: _firstNameController, icon: Icons.account_circle,
                    validate: (value) {
                        if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                        }
                        return null;
                }),
                const SizedBox(height: 10),
                Input(controller: _lastNameController, icon: Icons.account_circle, hint: 'Last Name',
                    validate: (value) {
                        if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                        }
                        return null;
                }),
                const SizedBox(height: 10),
                Input(controller: _usernameController, icon: Icons.person, hint: 'Username',
                    validate: (value) {
                        if (value == null || value.isEmpty) {
                            return 'Please choose a username';
                        }else if (value.length < 3) {
                            return 'Username must be at least 3 characters';
                        }
                        return null;
                }),
                const SizedBox(height: 10),
                Input(controller: _emailController, hint: 'Email', icon: Icons.email, inputType: TextInputType.emailAddress,
                    validate: (value) {
                        if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                        }else if (!value.contains('@')) {
                            return 'Please enter a valid email';
                        }
                        return null;
                }),
                const SizedBox(height: 10),
                Input(controller: _passwordController, icon: Icons.lock, hint: 'Password', inputType: TextInputType.visiblePassword,
                    validate: (value) {
                        if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                        }else if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                        }
                        return null;
                }),
                const SizedBox(height: 20),
                BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                    return SubmitButton(label: 'Sign Up', loading: state is AuthLoading, onClicked: () {
                        if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                SignUpWithEmail(
                                    email: _emailController.text.trim(), password: _passwordController.text.trim(),
                                    firstName: _firstNameController.text.trim(), lastName: _lastNameController.text.trim(), username: _usernameController.text.trim()),
                            );
                        }
                    });
                }),
                const SizedBox(height: 10),
                RichText(text: TextSpan(text: "Already have an account ? ",  style: TextStyle(color: theme.primary), children: [
                    TextSpan(text: "Login", style: TextStyle(fontWeight: FontWeight.bold), recognizer: TapGestureRecognizer()..onTap = widget.login)
                ]))
            ])
        ));
    }
}