import 'package:actfirebase/view/add_contact.dart';
import 'package:actfirebase/view/contact.dart';
import 'package:actfirebase/view/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
        // primarySwatch: Colors.pink,
      ),
      // home: const AddContact(),
      // home: const Contact(),
      home: Register(),
    );
  }
}
