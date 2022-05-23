import 'package:admin/doctor_informations.dart';
import 'package:admin/first_page.dart';
import 'package:admin/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'const/routes.dart';
import 'firebase_options.dart';
import 'general.dart';
import 'patient_informations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PatientInformations(),
      routes: {
        loginRoute : (context) => const LoginScreen(),
        registerRoute : (context) => const FirstPage(),
        generalinfo :(context) => const Userinfo(),
        docteurinfo :(context) => const DocInformations(),
        patientinfo :(context) => const PatientInformations(),
      }
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot){
        switch (snapshot.connectionState){
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null){
              return const FirstPage();
            }else{
              return const LoginScreen();
            }
          default:
            return const Scaffold(
              body: Center(child: CircularProgressIndicator())
            );
        }
      }
    );
  }
}
