// import 'dart:developer' show log;
import 'package:admin/colors.dart';
import 'package:admin/show_error_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'const/routes.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;

   @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }  

  bool isPasswordVisible = false;
  int value = 0;
  bool positive = false;
  String bro = 'bro';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgcolor,
      body: Center(
        child: Padding(
        padding: const EdgeInsets.only(top: 90.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              width: 200,
              child: Center(
                child: Image.asset(
                  'assets/logo_1.png',
                  fit: BoxFit.cover,
                  ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              'Welcome Back !',
              style: TextStyle(
                fontSize: 30.0,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: bluefnc,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 40.0),
              child: Text(
                'We wish that you are in good Health',
                style: TextStyle(
                  fontSize: 25.0,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.normal,
                  color: bluefnc,
                ),
              ),
            ),
            const SizedBox(height: 13),
            SizedBox(
              width: 294,
              height: 224,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 68,
                    width: 294,
                    child: TextField(
                      controller: _email,
                      decoration: InputDecoration(
                        labelText: "Enter your email",
                        labelStyle: const TextStyle(fontSize: 15),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: blueclr, width: 2,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: blueclr, width: 2,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        /*suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 9.0),
                          child: IconButton(
                            icon: const Icon(Icons.email),
                          color: Color(0x55828B),
                          onPressed: () {},
                          ),
                        ),*/
                        hintMaxLines: 1,
                        ),
                        keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                  height: 52,
                  width: 294,
                  child: TextField(
                  controller: _password,
                  obscureText: isPasswordVisible ? false : true,
                  decoration: InputDecoration(
                        labelText: "enter your Password",
                        labelStyle: const TextStyle(fontSize: 15),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                          color: blueclr,
                          width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: blueclr, width: 2,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          icon: Icon(isPasswordVisible ? Icons.visibility: Icons.visibility_off),
                          ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: 294,
                    height: 52,
                    child: ElevatedButton(                /////////////////////////
                      onPressed: () async{
                        final email = _email.text;
                        final password = _password.text;
                        try{
                          await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: email,  
                            password: password,
                          );
                          final user = FirebaseAuth.instance.currentUser;
                          if (user!.emailVerified){
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              registerRoute, 
                              (route) => false
                            );
                          }else{
                            showDialog(
                              context: context, 
                              builder: (context){
                                return AlertDialog(
                                  title: const Text('An error occured'),
                                  content: const Text("you didn't verify your email"),
                                  actions:[
                                    TextButton(
                                      onPressed: () async{
                                        await user.sendEmailVerification();
                                        // ignore: use_build_context_synchronously
                                        Navigator.of(context).pop();
                                      }, 
                                      child: const Text('send email verification')
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      }, 
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        } on FirebaseAuthException catch(e){
                          if (e.code == 'user-not-found'){
                            await showErrorDialog(context, 'user not found');
                          } else if (e.code == 'wrong-password'){
                            await showErrorDialog(context, 'wrong credentials');
                          }else{
                            await showErrorDialog(context, 'Error: ${e.code}');
                          }
                        }catch (e){
                          await showErrorDialog(context, e.toString());
                          // log(e.toString());
                        }                      
                      },                        
                      style: ElevatedButton.styleFrom(
                        shadowColor: blueclr,
                        elevation: 10,
                        primary: blueclr,
                        shape: RoundedRectangleBorder(
                          borderRadius:BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        "Continue",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}
