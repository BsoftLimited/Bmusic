import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:bmusic/components/input.dart';
import 'package:bmusic/utils/details.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});
  
  @override
  State<StatefulWidget> createState() => __LoginFormState();
}

class __LoginFormState extends State<LoginForm> with AfterLayoutMixin {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    Future<LoginDetail> detailFinder = LoginDetail.find();
    detailFinder.then((value) {
        phoneController.text = value.phone;
        passwordController.text = value.password;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme theme = Theme.of(context).colorScheme;
    
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min,
          children: [
            Text("LOGIN", style: TextStyle( fontSize: 16.0, fontWeight: FontWeight.bold, color: theme.primaryFixedDim), textAlign: TextAlign.left),
            const SizedBox(height: 10),
            Input(
                hint: "Email Address",
                icon: Icons.email_outlined,
                controller: phoneController,
                inputType: TextInputType.emailAddress),
            const SizedBox(height: 10),
            Input(
                hint: "password",
                icon: Icons.lock_outline,
                inputType: TextInputType.visiblePassword,
                controller: passwordController),
            Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {},
                    child: const Text("Forgotten Password", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)))),
            Row(children: [
              Expanded(
                  flex: 1,
                  child: MaterialButton(
                      textColor: Colors.white,
                      color: theme.primaryFixedDim,
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      onPressed: (){},
                      child: const Padding(
                          padding: EdgeInsets.only(top: 14, bottom: 14),
                          child: Text("Login"))))
            ]),
          ]),
    );
  }
}
