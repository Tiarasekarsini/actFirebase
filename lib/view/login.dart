import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String? email;
    String? password;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
            child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              onChanged: (value) {
                email = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Password'),
              onChanged: (value) {
                password = value;
              },
            )
          ],
        )),
      ),
    );
  }
}
