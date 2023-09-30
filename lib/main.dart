import 'package:eduproject/view_models/registration_view_model.dart';
import 'package:eduproject/views/registration_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegistrationViewModel(),
      child: MaterialApp(
        title: 'EDU Project',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const RegistrationView(),
      ),
    );
  }
}
