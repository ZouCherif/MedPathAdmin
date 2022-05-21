// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace

import 'dart:developer';


import 'package:admin/show_error_dialog.dart';
import 'package:admin/showdialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../colors.dart';


// ignore: must_be_immutable
class PatientInformations extends StatefulWidget {
   const PatientInformations({ Key? key}) : super(key: key);

  @override
  State<PatientInformations> createState() => _PatientInformationsState();
}

class _PatientInformationsState extends State<PatientInformations> {
  late final TextEditingController disease;
  late final TextEditingController allergy;
  late final TextEditingController numm;
  late final TextEditingController height;
  late final TextEditingController weight;
  // ignore: non_constant_identifier_names
  List diseases = [];
  List<Padding> diseasewidget = [];
  List allergies = [];
  List<Padding> allergiewidget = [];
  String dropdownvalue = 'O +';

  // List of items in our dropdown menu
  var items = [
    'O +',
    'O -',
    'A +',
    'A -',
    'B +',
    'B -',
    'AB +',
    'AB -',
  ];

  int id = 1;

   @override
  void initState() {
    disease = TextEditingController();
    allergy = TextEditingController();
    numm = TextEditingController();
    height = TextEditingController();
    weight = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    disease.dispose();
    allergy.dispose();
    numm.dispose();
    height.dispose();
    weight.dispose();
    super.dispose();
  }  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: bgcolor,
      child: Padding(
        padding: EdgeInsets.only(
            top: 0.09 * size.height,
            bottom: 0.25 * size.height,
            right: 0.15 * size.width,
            left: 0.15 * size.width),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              iconTheme: const IconThemeData(color: bluefnc),
              toolbarHeight: 100,
              shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              title: const Text(
                "General Patient informations",
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: bluefnc,
                ),
              ),
              centerTitle: true,
            ),
            body: SafeArea(
              child: Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  width: 0.5 * size.width,
                  child: Column(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            //this row is for general user informations row

                            //first infos line

                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 0.046 * size.height,
                              width: 440,
                              child: TextField(
                                controller: disease,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton
                              (onPressed: (){
                                setState(() {
                                  diseases.add(disease.text);
                                  diseasewidget.add(
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(disease.text),
                                    )
                                  );
                                });
                              }, 
                              icon: const Icon(Icons.add),
                              ),
                                  fillColor:
                                      const Color.fromARGB(253, 209, 209, 209),
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
                                  hintText: "chronic diseases",
                                  hintStyle: const TextStyle(
                                    color: bluefnc,
                                    fontFamily: 'poppins',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                               
                            ),
                            Container(
                              height: 30,
                              child: Row(
                                children: [
                                  Row(
                                    children: diseasewidget,
                                  ),
                                  IconButton(
                                    onPressed: (){
                                      setState(() {
                                        diseases.removeLast();
                                        diseasewidget.removeLast();
                                      });
                                    }, 
                                    icon: Icon(
                                      Icons.remove,
                                      color: Colors.grey.shade500,
                                    )
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 0.046 * size.height,
                              width: 440,
                              child: TextField(
                                controller: allergy,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: (){
                                    setState(() {
                                      allergies.add(allergy.text);
                                      log(allergies.toString());
                                      allergiewidget.add(
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(allergy.text),
                                        )
                                      );
                                    });
                                  }, 
                                  icon: const Icon(Icons.add),
                                  ),
                                  fillColor: const Color.fromARGB(
                                      253, 209, 209, 209),
                                  // border: OutlineInputBorder(
                                  //   borderRadius: BorderRadius.circular(10),

                                  // ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(
                                          253, 209, 209, 209),
                                      width: 1.5,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(
                                          253, 209, 209, 209),
                                      width: 1.5,
                                    ),
                                  ),
                                  hintText: "allergies",

                                  hintStyle: const TextStyle(
                                    color: bluefnc,
                                    fontFamily: 'poppins',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Row(
                                  children: allergiewidget,
                                ),
                                IconButton(
                                    onPressed: (){
                                      setState(() {
                                        allergies.removeLast();
                                        log(allergies.toString());
                                        allergiewidget.removeLast();
                                      });
                                    }, 
                                    icon: Icon(
                                      Icons.remove,
                                      color: Colors.grey.shade500,
                                    )
                                  ),
                              ],
                            ),
                            const SizedBox(height: 11),
                            Container(
                              height: 0.046 * size.height,
                              width: 440,
                              child: TextField(
                                controller: numm,
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
                                  hintText: "number",

                                  hintStyle: const TextStyle(
                                    color: Color(0xff406083),
                                    fontSize: 11,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 0.01 * size.height,
                            ),

                            Container(
                              height: 47,
                              width: 530,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 45.0, left: 45),
                                child: DropdownButtonFormField2(
                                  scrollbarRadius: const Radius.circular(10),
                                  focusColor: Colors.white,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color.fromRGBO(
                                                  253, 209, 209, 100),
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  value: dropdownvalue,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: items.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(
                                        items,
                                        style: const TextStyle(
                                          color: Color(0xff406083),
                                          fontSize: 12,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownvalue = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 0.02 * size.height,
                            ),
                            Container(
                              width: 0.45 * size.width,
                              height: 0.046 * size.height,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const FittedBox(
                                    child: Text(
                                      "Height(cm) :",
                                      style: TextStyle(
                                        color: Color(0xff406083),
                                        fontSize: 13,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 0.003),
                                  Container(
                                    width: 0.11 * size.width,
                                    height: 0.042 * size.height,
                                    child: TextField(
                                      controller: height,
                                      decoration: InputDecoration(
                                  fillColor:
                                      const Color.fromARGB(253, 209, 209, 209),
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
                                ),)
                                  ),
                                  SizedBox(
                                    width: 0.01 * size.width,
                                  ),
                                  const FittedBox(
                                    child: Text(
                                      "Weight(Kg) :",
                                      style: TextStyle(
                                        color: Color(0xff406083),
                                        fontSize: 13,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 0.006),
                                  Container(
                                    width: 0.11 * size.width,
                                    height: 0.042 * size.height,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: weight,
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
                                ),)
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 0.03 * size.height,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: 103,
                                  height: 0.040 * size.height,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if(numm.text.isNotEmpty & height.text.isNotEmpty & weight.text.isNotEmpty){
                                        try{
                                          final user = FirebaseAuth.instance.currentUser!.uid;
                                          FirebaseFirestore.instance.collection('users').doc(user).update({
                                            'diseases' : FieldValue.arrayUnion(diseases),
                                            'allergies' : FieldValue.arrayUnion(allergies),
                                            'number' : numm.text,
                                            'groupe sanguin' : dropdownvalue,
                                            'height' : height.text,
                                            'weight' : weight.text,
                                          });
                                          showdialog(context, 'patient account has been created succesfuly');
                                        }catch (e){
                                          showErrorDialog(context, e.toString());
                                        }
                                      }else{
                                        showErrorDialog(context, 'please enter all the informations');
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


