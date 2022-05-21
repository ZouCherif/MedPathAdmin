
import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, dynamic>?> getData(user) async{
  final  userData = await FirebaseFirestore.instance.collection('users').doc(user).get();
  final data = userData.data();
  return data;
}