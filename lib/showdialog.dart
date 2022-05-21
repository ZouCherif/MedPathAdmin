import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'const/routes.dart';

showdialog(BuildContext context, String text){
  return showDialog(
    context: context, 
    builder: (context){
      return AlertDialog(
        content: Text(text),
        actions:[
          TextButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pop();
              Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
            }, 
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}