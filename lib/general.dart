// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, use_build_context_synchronously

import 'package:admin/const/routes.dart';
import 'package:admin/get_role.dart';
import 'package:admin/show_error_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../colors.dart';

class Userinfo extends StatefulWidget {
  const Userinfo({Key? key}) : super(key: key);

  @override
  State<Userinfo> createState() => _UserinfoState();
}

class _UserinfoState extends State<Userinfo> {
  late final TextEditingController _firstname;
  late final TextEditingController _secondname;
  late final TextEditingController _placeofbirth;
  late final TextEditingController _phone;
  late final TextEditingController _fathername;
  String? formattedDate;
  int id = 1;
  String radioButtonItem = 'male';
  TextEditingController dateinput = TextEditingController();
  @override
  void initState() {
    _firstname = TextEditingController();
    _secondname = TextEditingController();
    _phone = TextEditingController();
    _placeofbirth = TextEditingController();
    _fathername = TextEditingController();
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  void dispose() {
    _fathername.dispose();
    _firstname.dispose();
    _secondname.dispose();
    _phone.dispose();
    _placeofbirth.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: bgcolor,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 0.15 * size.width, vertical: 0.08 * size.height),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              iconTheme: const IconThemeData(color: bluefnc),
              toolbarHeight: 0.1 * size.height,
              shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              title: const FittedBox(
                child: Text(
                  "General User informations",
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
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: 0.46 * size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          //this row is for general user informations row

                          //first infos line
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 0.046 * size.height,
                                width: 0.20 * size.width,
                                child: TextField(
                                  controller: _firstname,
                                  decoration: InputDecoration(
                                    fillColor: const Color.fromARGB(
                                        253, 209, 209, 209),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(253, 209, 209, 209),
                                        width: 1.5,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(253, 209, 209, 209),
                                        width: 1.5,
                                      ),
                                    ),
                                    labelText: "First Name",
                                    labelStyle: const TextStyle(
                                      color: bluefnc,
                                      fontFamily: 'poppins',
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 0.008 * size.width,
                              ),
                              Container(
                                height: 0.046 * size.height,
                                width: 0.20 * size.width,
                                child: TextField(
                                  controller: _secondname,
                                  decoration: InputDecoration(
                                    fillColor: const Color.fromARGB(
                                        253, 209, 209, 209),
                                    // border: OutlineInputBorder(
                                    //   borderRadius: BorderRadius.circular(10),

                                    // ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(253, 209, 209, 209),
                                        width: 1.5,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(253, 209, 209, 209),
                                        width: 1.5,
                                      ),
                                    ),
                                    labelText: "last Name",

                                    labelStyle: const TextStyle(
                                      color: bluefnc,
                                      fontFamily: 'poppins',
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 11,
                          ),
                          Container(
                              height: 0.049 * size.height,
                              width: 440,
                              child: Center(
                                  child: TextField(
                                controller:
                                    dateinput, //editing controller of this TextField
                                decoration: InputDecoration(
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
                                  icon: const Icon(Icons
                                      .calendar_today), //icon of text field
                                  labelText:
                                      "Enter Date Of Birth", //label text of field
                                  labelStyle: const TextStyle(
                                    color: bluefnc,
                                    fontFamily: 'poppins',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                readOnly:
                                    true, //set it true, so that user will not able to edit text
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime.now());

                                  if (pickedDate != null) {//pickedDate output format => 2021-03-10 00:00:00.000
                                    formattedDate =DateFormat('yyyy-MM-dd').format(pickedDate); //formatted date output using intl package =>  2021-03-16
                                    //you can implement different kind of Date Format here according to your requirement

                                    setState(() {
                                      dateinput.text =
                                          formattedDate!; //set output date to TextField value.
                                    });
                                  } else {
                                    // ignore: avoid_print
                                    print("Date is not selected");
                                  }
                                },
                              ))),

                          const SizedBox(
                            height: 11,
                          ),
                          Container(
                            height: 0.046 * size.height,
                            width: 440,
                            child: TextField(
                              controller: _placeofbirth,
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
                                labelText: "Place Of Birth",

                                labelStyle: const TextStyle(
                                  color: bluefnc,
                                  fontFamily: 'poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 11,
                          ),
                          Container(
                            height: 0.046 * size.height,
                            width: 440,
                            child: TextField(
                              controller: _phone,
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
                                labelText: "Phone Number",

                                labelStyle: const TextStyle(
                                  color: bluefnc,
                                  fontFamily: 'poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 11,
                          ),

                          //this next row is for choosing sexe
                          Container(
                            width: 0.44 * size.width,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: size.width * 0.1,
                                ),
                                const Text(
                                  " Sexe :",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: bluefnc,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),

                          Container(
                            width: 0.5 * size.width,
                            height: 42,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width: size.width * 0.003),
                                Container(
                                  height: 0.046 * size.height,
                                  width: 0.235 * size.width,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 0.046 * size.height,
                                        width: 0.235 * size.width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: const Color(0x66d1d1d1),
                                            width: 1.50,
                                          ),
                                          color: const Color(0x0cd1d1d1),
                                        ),
                                        padding: const EdgeInsets.only(
                                          left: 15,
                                          right: 17,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const FittedBox(
                                              child: Text(
                                                "Male",
                                                style: TextStyle(
                                                  color: Color(0xff406083),
                                                  fontSize: 13,
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 21,
                                              width: 21,
                                              child: Radio(
                                                activeColor:
                                                    const Color.fromRGBO(
                                                        13, 190, 216, 100),
                                                value: 1,
                                                groupValue: id,
                                                onChanged: (val) {
                                                  setState(() {
                                                    radioButtonItem = 'Man';
                                                    id = 1;
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 0.046 * size.height,
                                  width: 0.22 * size.width,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 0.046 * size.height,
                                        width: 0.22 * size.width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: const Color(0x66d1d1d1),
                                            width: 1.50,
                                          ),
                                          color: const Color(0x0cd1d1d1),
                                        ),
                                        padding: const EdgeInsets.only(
                                          left: 7,
                                          right: 15,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const FittedBox(
                                              child: Text(
                                                "female",
                                                style: TextStyle(
                                                  color: Color(0xff406083),
                                                  fontSize: 11,
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 21,
                                              width: 21,
                                              child: Radio(
                                                activeColor:
                                                    const Color.fromRGBO(
                                                        13, 190, 216, 100),
                                                value: 2,
                                                groupValue: id,
                                                onChanged: (val) {
                                                  setState(() {
                                                    radioButtonItem = 'women';
                                                    id = 2;
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 11,
                          ),
                          Container(
                            height: 0.046 * size.height,
                            width: 0.20 * size.width,
                            child: TextField(
                              controller: _fathername,
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
                                labelText: "last Name Of Father",
                                labelStyle: const TextStyle(
                                  color: bluefnc,
                                  fontFamily: 'poppins',
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
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
                                height: 36,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_firstname.text.isEmpty || _secondname.text.isEmpty || _phone.text.isEmpty || _placeofbirth.text.isEmpty || _fathername.text.isEmpty){
                                      await showErrorDialog(context, "please enter all the information");
                                    }else{
                                      try{
                                        final user = FirebaseAuth.instance.currentUser!.uid;
                                        FirebaseFirestore.instance.collection('users').doc(user).update({
                                          'full name' : '${_firstname.text} ${_secondname.text}',
                                          'sexe' : radioButtonItem,
                                          'date of birth' : formattedDate,
                                          'place of birth' : _placeofbirth.text,
                                          'phone number' : _phone.text,
                                          'father name' : _fathername.text,
                                        });
                                        final role = await getRole(user);
                                        if (role == 'docteur'){
                                          Navigator.of(context).pushNamed(docteurinfo);
                                        }else{
                                          Navigator.of(context).pushNamed(patientinfo);
                                        }
                                    }catch (e){
                                      await showErrorDialog(context,'Error: ${e.toString()}');
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
