// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace

import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../colors.dart';
import 'show_error_dialog.dart';
import 'showdialog.dart';

String postifOrNegatif = "Positif or negatif";

// ignore: must_be_immutable
class DocInformations extends StatefulWidget {
  const DocInformations({Key? key}) : super(key: key);

  @override
  State<DocInformations> createState() => _DocInformationsState();
}

class _DocInformationsState extends State<DocInformations> {
  late final TextEditingController _doctornum;
  late final TextEditingController _specialite;
  late final TextEditingController _location;
  PlatformFile? pickedFile;
  UploadTask? uploadtask;

  Future selectFile()async{
  final result=await FilePicker.platform.pickFiles();
  if (result == null)return;
  setState(() {
    pickedFile = result.files.first;
  });
  }

  Future uploadfile(user)async{
    final path = 'docpic/${pickedFile!.name}';
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadtask = ref.putFile(file);
    final snapshot = await uploadtask!.whenComplete((){});
    final urldownload = await snapshot.ref.getDownloadURL();
    FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
      'imgURL' : urldownload,
    });
  }

  // void _openPicker()async{
  //   final result;
  //   result = await FilePicker.platform.pickFiles();
  //   if(result!=null){
  //     Uint8List uploadFile = result.files.single.bytes;
  //     String fileName=result.files.single.name;
  //     Reference refrence=FirebaseStorage.instance.ref().child('lnfzf');
  //     final UploadTask uploadTask = refrence.putData(uploadFile);
  //   }

  // }

    @override
  void initState() {
    _doctornum = TextEditingController();
    _specialite = TextEditingController();
    _location = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _doctornum.dispose();
    _specialite.dispose();
    _location.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.7,
      color: bgcolor,
      child: Padding(
        padding: EdgeInsets.only(
            top: 0.10 * size.height,
            bottom:0.30 *  size.height,
            right: 0.15 * size.width,
            left: 0.15 * size.width,
            ),
        child: Container(
          width: size.width * 0.7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              iconTheme: const IconThemeData(color: bluefnc),
              toolbarHeight: size.height * 0.1,
              shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              title: const FittedBox(
                child: Text(
                  "General Doctor informations",
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: bluefnc,
                  ),
                ),
              ),
              centerTitle: true,
            ),
            body: Center(
              child: Container(
                width: size.width * 0.7,
                margin: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    //this row is for general user informations row

                    //first infos line

                    SizedBox(
                      height: 0.001 * size.height,
                    ),
                    Container(
                      height: 0.046 * size.height,
                      width: 525,
                      child: TextFormField(
                        controller: _doctornum,
                        decoration: InputDecoration(
                          fillColor:
                              const Color.fromARGB(253, 209, 209, 209),
                          // border: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(10),

                          // ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(253, 209, 209, 209),
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(253, 209, 209, 209),
                              width: 1.5,
                            ),
                          ),
                          hintText: "Specefic number of the doctor",

                          hintStyle: const TextStyle(
                            color: bluefnc,
                            fontFamily: 'poppins',
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 11,
                    ),

                    const SizedBox(height: 11),
                    Container(
                      height: 0.046 * size.height,
                      width: 525,
                      child: TextFormField(
                        controller: _specialite,
                        decoration: InputDecoration(
                          fillColor:
                              const Color.fromARGB(253, 209, 209, 209),
                          // border: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(10),

                          // ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(253, 209, 209, 209),
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(253, 209, 209, 209),
                              width: 1.5,
                            ),
                          ),
                          hintText: "Specialite",

                          hintStyle: const TextStyle(
                            color: Color(0xff406083),
                            fontSize: 13,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 11,
                    ),

                    const SizedBox(height: 11),
                    Container(
                      height: 0.046 * size.height,
                      width: 525,
                      child: TextFormField(
                        controller: _location,
                        decoration: InputDecoration(
                          fillColor:
                              const Color.fromARGB(253, 209, 209, 209),
                          // border: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(10),

                          // ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(253, 209, 209, 209),
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(253, 209, 209, 209),
                              width: 1.5,
                            ),
                          ),
                          hintText: "Localisation",
                          suffixIcon:
                              const Icon(Icons.location_on_rounded),

                          hintStyle: const TextStyle(
                            color: Color(0xff406083),
                            fontSize: 13,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.02 * size.width,
                    ),
                    Container(
                      child: InkWell(
                        onTap: () async{
                          await selectFile();
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(
                                    253, 209, 209, 209),
                              ),
                              child: Row(
                                crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  SizedBox(width: 10),
                                  FittedBox(
                                    child: Text(
                                      "Upload a picture",
                                      style: TextStyle(
                                        color: Color(0xff406083),
                                        fontSize: 15,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 0.001,
                                  ),
                                  FittedBox(
                                    child: Icon(
                                      Icons.upload_rounded,
                                      color: Color(0xff406083),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 103,
                          height: 0.045 * size.height,
                          child: ElevatedButton(
                            onPressed: () async{
                              if (_doctornum.text.isEmpty || _specialite.text.isEmpty || _location.text.isEmpty ){
                                await showErrorDialog(context, "please enter all the information");
                              }else{
                                try{
                                  final user = FirebaseAuth.instance.currentUser;
                                  FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
                                    'code du docteur' : _doctornum.text,
                                    'specialite' : _specialite.text,
                                    'localisation' : _location.text,
                                  });
                                  await uploadfile(user);
                                  // ignore: use_build_context_synchronously
                                  showdialog(context, 'Doctor acount has been created succefuly');
                                  
                                }catch (e){
                                  await showErrorDialog(context, 'Error: ${e.toString()}');
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                shadowColor: blueclr,
                                elevation: 4,
                                primary: blueclr,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(10))),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment:
                                  CrossAxisAlignment.center,
                              children: const [
                                Text(
                                  "Next",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Icon(Icons.arrow_right),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


