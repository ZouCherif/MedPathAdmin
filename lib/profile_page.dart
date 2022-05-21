// ignore_for_file: sized_box_for_whitespace
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'get_role.dart';
import 'getdata.dart';

// ignore: must_be_immutable
class ProfilPage1 extends StatefulWidget {
  String id;
  ProfilPage1({required this.id,Key? key}) : super(key: key);

  @override
  State<ProfilPage1> createState() => _ProfilPage1State();
}

class _ProfilPage1State extends State<ProfilPage1> {
  var imageUrl = "assets/avatar.png";
  var telephone = "0662541966";
  var nss = "1563486513254165";
  var pheight = 177;
  var pweight = 67;
  var sexewidth = 80;
  var usid = FirebaseAuth.instance.currentUser!.uid;

  var colorBAD = Colors.transparent;

  late final TextEditingController rapport;
  

     @override
  void initState() {
    rapport = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    rapport.dispose();
    super.dispose();
  }  
   

  String imc(taille,poids) {
    num N = poids/((taille/100)*(taille/100));
    if (N >= 18 && N <= 24.9){
      colorBAD=Colors.green;
      return 'good';
    }else{
      colorBAD=Colors.red;
      return 'BAD';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: getData(widget.id),
      builder: (BuildContext context,snapshot){
      if (snapshot.hasData){
      Map content = snapshot.data as Map;
      final user = FirebaseAuth.instance.currentUser!.uid;
      return FutureBuilder(
        future: getRole(user),
        builder: (BuildContext context, snapshot) {
        return SafeArea(
          child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                  iconTheme:
                      const IconThemeData(color: Color.fromARGB(156, 6, 37, 70)),
                  centerTitle: true,
                  title: const Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: 'Poppins',
                      color: Color.fromARGB(156, 6, 37, 70),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: Colors.blue.withOpacity(0.00),
                  elevation: 0.0,
              ),
              body: SafeArea(
                  child: ListView(children: <Widget>[
                Column(children: [
                  Center(
                    child: SizedBox(
                      height: 146,
                      width: 146,
                      child: CircleAvatar(
                        radius: 30.0,
                        backgroundImage: NetworkImage(imageUrl),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      content['full name'],
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 44, 98, 143),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('ID :',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 44, 98, 143),
                          )),
                      Text(content['id'],
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 44, 98, 143),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: SizedBox(
                          height: 20,
                          width: 50,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                              ),
                              onPressed: () async {
                                final data = ClipboardData(text: content['id']);
                                Clipboard.setData(data);
                              },
                              child: const Text('copy',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 44, 98, 143),
                                  ))),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: size.width * 0.65641,
                          height: size.height * 0.33,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: size.width * 0.65641,
                                height: size.height * 0.33,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x19000000),
                                      blurRadius: 45,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                  color: Colors.white,
                                ),
                                padding: const EdgeInsets.only(
                                  left: 9,
                                  right: 24,
                                  top: 16,
                                  bottom: 15,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.65641,
                                      height: size.height * 0.02463541871921,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          FittedBox(
                                            child: Text(
                                              "Date de naissance:  ",
                                              style: TextStyle(
                                                color: const Color(0xff406083),
                                                fontSize: 0.032 * size.width,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          FittedBox(
                                            child: Text(
                                              content['date of birth'],
                                              style: TextStyle(
                                                color: const Color(0xffc4c4c4),
                                                fontSize: 0.03333333 * size.width,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 23.25),
                                    SizedBox(
                                      width: size.width * 0.65641,
                                      height: size.height * 0.02463541871921,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          FittedBox(
                                            child: Text(
                                              "place of birth:",
                                              style: TextStyle(
                                                color: const Color(0xff406083),
                                                fontSize: size.width * 0.03333333,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          FittedBox(
                                            child: Text(
                                              content['place of birth'],
                                              style: TextStyle(
                                                color: const Color(0xffc4c4c4),
                                                fontSize: size.width * 0.03333333,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 23.25),
                                    FittedBox(
                                      child: Container(
                                        width: size.width * 0.65641,
                                        height: size.height * 0.02463541871921,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            FittedBox(
                                              child: Text(
                                                "Téléphone:",
                                                style: TextStyle(
                                                  color: const Color(0xff406083),
                                                  fontSize: size.width * 0.03333333,
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            FittedBox(
                                              child: Text(
                                                content['phone number'].toString(),
                                                style: TextStyle(
                                                  color: const Color(0xffc4c4c4),
                                                  fontSize: size.width * 0.03333333,
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 15.25),
                                    FittedBox(
                                      child: Container(
                                        width: size.width * 0.66,
                                        height: size.height * 0.02463541871921,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            FittedBox(
                                              child: Text(
                                                "Numéro de sécurité: ",
                                                style: TextStyle(
                                                  color: const Color(0xff406083),
                                                  fontSize: size.width * 0.03333333,
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            FittedBox(
                                              child: Text(
                                                content['number'],
                                                style: TextStyle(
                                                  color: const Color(0xffc4c4c4),
                                                  fontSize: size.width * 0.03333333,
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 15.25),
                                    FittedBox(
                                      child: Container(
                                        width: size.width * 0.66,
                                        height: size.height * 0.02463541871921,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            FittedBox(
                                              child: Text(
                                                "Allergies ",
                                                style: TextStyle(
                                                  color: const Color(0xff406083),
                                                  fontSize: size.width * 0.03333333,
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            FittedBox(
                                              child: Text(
                                                "pinisciline",
                                                style: TextStyle(
                                                  color: const Color(0xffc4c4c4),
                                                  fontSize: size.width * 0.03333333,
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      
                                    ),
                                    const SizedBox(height: 15.25),
                                    FittedBox(
                                      child: Container(
                                        width: size.width * 0.66,
                                        height: size.height * 0.02463541871921,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            FittedBox(
                                              child: Text(
                                                "chronical diseases ",
                                                style: TextStyle(
                                                  color: const Color(0xff406083),
                                                  fontSize: size.width * 0.03333333,
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            FittedBox(
                                              child: Text(
                                                "diabetic",
                                                style: TextStyle(
                                                  color: const Color(0xffc4c4c4),
                                                  fontSize: size.width * 0.03333333,
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: SizedBox(
                            width: size.width * 0.21794871794871,
                            height: size.height * 0.33,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: size.width * 0.21794871794871,
                                  height: size.height * 0.33,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x19000000),
                                        blurRadius: 80,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 13.73333 * size.width,
                                        height: 0.13 * size.height,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const FittedBox(
                                              child: Text(
                                                "Sexe:",
                                                style: TextStyle(
                                                  color: Color(0xff406083),
                                                  fontSize: 23,
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: size.width * 0.106666,
                                              height: 45,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  // ignore: unrelated_type_equality_checks
                                                  if (content['sexe'] == 'F')
                                                    FittedBox(
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: const [
                                                          FittedBox(
                                                            child: Text(
                                                              "F",
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xffc4c4c4),
                                                                fontSize: 30,
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight.w700,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 2.0),
                                                            child: Icon(
                                                              Icons.female,
                                                              color: Color.fromRGBO(
                                                                  255,
                                                                  133,
                                                                  143,
                                                                  100),
                                                              size: 20,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  else
                                                    FittedBox(
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: const [
                                                          FittedBox(
                                                            child: Text(
                                                              "M",
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xffc4c4c4),
                                                                fontSize: 30,
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight.w700,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 2.0),
                                                            child: Icon(
                                                              Icons.male,
                                                              color: Colors.blue,
                                                              size: 20,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Flexible(
                                        child: Container(
                                          width: 13.73333 * size.width,
                                          height: 0.19 * size.height,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const FittedBox(
                                                child: Text(
                                                  "Group \n Sanguin:",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xff406083),
                                                    fontSize: 22,
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                                  FittedBox(
                                                  child: Text(
                                                    content['groupe sanguin'],
                                                    style: const TextStyle(
                                                      color:  Color(0xffc4c4c4),
                                                      fontSize: 30,
                                                      fontFamily: "Poppins",
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                )
                                              // else if (sang == Sang.Onegative)
                                              //   const FittedBox(
                                              //     child: Text(
                                              //       "O-",
                                              //       style: TextStyle(
                                              //         color: Color(0xffc4c4c4),
                                              //         fontSize: 27,
                                              //         fontFamily: "Poppins",
                                              //         fontWeight: FontWeight.w700,
                                              //       ),
                                              //     ),
                                              //   )
                                              // else if (sang == Sang.Anegative)
                                              //   Text(
                                              //     "A-",
                                              //     style: TextStyle(
                                              //       color: const Color(0xffc4c4c4),
                                              //       fontSize: 0.06 * size.width,
                                              //       fontFamily: "Poppins",
                                              //       fontWeight: FontWeight.w700,
                                              //     ),
                                              //   )
                                              // else if (sang == Sang.Apositive)
                                              //   Text(
                                              //     "A+",
                                              //     style: TextStyle(
                                              //       color: const Color(0xffc4c4c4),
                                              //       fontSize: 0.06 * size.width,
                                              //       fontFamily: "Poppins",
                                              //       fontWeight: FontWeight.w700,
                                              //     ),
                                              //   )
                                              // else if (sang == Sang.Bnegative)
                                              //   Text(
                                              //     "B-",
                                              //     style: TextStyle(
                                              //       color: const Color(0xffc4c4c4),
                                              //       fontSize: 0.06 * size.width,
                                              //       fontFamily: "Poppins",
                                              //       fontWeight: FontWeight.w700,
                                              //     ),
                                              //   )
                                              // else if (sang == Sang.Bpositive)
                                              //   Text(
                                              //     "B+",
                                              //     style: TextStyle(
                                              //       color: const Color(0xffc4c4c4),
                                              //       fontSize: 0.06 * size.width,
                                              //       fontFamily: "Poppins",
                                              //       fontWeight: FontWeight.w700,
                                              //     ),
                                              //   )
                                              // else if (sang == Sang.ABnegative)
                                              //   Text(
                                              //     "AB-",
                                              //     style: TextStyle(
                                              //       color: const Color(0xffc4c4c4),
                                              //       fontSize: 0.06 * size.width,
                                              //       fontFamily: "Poppins",
                                              //       fontWeight: FontWeight.w700,
                                              //     ),
                                              //   )
                                              // else if (sang == Sang.ABpositive)
                                              //   FittedBox(
                                              //     child: Text(
                                              //       "AB+",
                                              //       style: TextStyle(
                                              //         color:
                                              //             const Color(0xffc4c4c4),
                                              //         fontSize: 0.06 * size.width,
                                              //         fontFamily: "Poppins",
                                              //         fontWeight: FontWeight.w700,
                                              //       ),
                                              //     ),
                                              //   )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SafeArea(
                    child: Container(
                      width: size.width * 0.91,
                      height: size.height * 0.0995260666350710,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: size.width * 0.86,
                            height: size.height * 0.0995260666350710,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: Stack(
                              children: [
                                const Positioned(
                                  left: 22,
                                  top: 8,
                                  child: FittedBox(
                                    child: Text(
                                      "Poids",
                                      style: TextStyle(
                                        color: Color(0xff406083),
                                        fontSize: 17,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 20,
                                  top: 34,
                                  child: SizedBox(
                                    width: 0.16154 * size.width,
                                    height: 35,
                                    child: FittedBox(
                                      child: Text(
                                        "${content['weight']} KG ",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Color(0xff0dbed8),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 100,
                                  top: 50,
                                  child: SizedBox(
                                    width: 0.46 * size.width,
                                    height: 19,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Doctor’s review ",
                                          style: TextStyle(
                                            color: Color(0xffc4c4c4),
                                            fontSize: 9,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Container(
                                          width: 70,
                                          height: 25,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              FittedBox(
                                                child: Container(
                                                  width: 70,
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(8),
                                                    color: colorBAD,
                                                  ),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                    children:  [
                                                      FittedBox(
                                                        child: Text(
                                                          imc(int.parse(content['height']), int.parse(content['weight'])),
                                                          style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
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
                                const Positioned(
                                  left: 145,
                                  top: 17,
                                  child: Text(
                                    "derniere mise a jour:  Before 2 months",
                                    style: TextStyle(
                                      color: Color(0xffc4c4c4),
                                      fontSize: 9,
                                    ),
                                  ),
                                ),
                                Positioned(
                                    left: 0.27 * size.width,
                                    top: 23,
                                    child: IconButton(
                                      icon: const Icon(Icons.mode_edit_outline),
                                      color:
                                          const Color.fromRGBO(209, 209, 209, 100),
                                      onPressed: () {},
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: size.width * 0.91,
                    height: size.height * 0.0995260666350710,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: size.width * 0.86,
                          height: size.height * 0.0995260666350710,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Stack(
                            children: [
                              const Positioned(
                                left: 22,
                                top: 8,
                                child: FittedBox(
                                  child: Text(
                                    "Taille",
                                    style: TextStyle(
                                      color: Color(0xff406083),
                                      fontSize: 17,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 20,
                                top: 34,
                                child: SizedBox(
                                  width: 0.16154 * size.width,
                                  height: 35,
                                  child: FittedBox(
                                    child: Text(
                                      "${content['height']} CM ",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Color(0xff0dbed8),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Positioned(
                              //   left: 100,
                              //   top: 50,
                              //   child: SizedBox(
                              //     width: 0.46 * size.width,
                              //     height: 19,
                              //     child: Row(
                              //       mainAxisSize: MainAxisSize.min,
                              //       mainAxisAlignment: MainAxisAlignment.end,
                              //       crossAxisAlignment: CrossAxisAlignment.center,
                              //       children: [
                              //         const Text(
                              //           "Doctor’s review ",
                              //           style: TextStyle(
                              //             color: Color(0xffc4c4c4),
                              //             fontSize: 9,
                              //           ),
                              //         ),
                              //         const SizedBox(width: 12),
                              //         Container(
                              //           width: 52,
                              //           height: 19,
                              //           child: Row(
                              //             mainAxisSize: MainAxisSize.min,
                              //             mainAxisAlignment:
                              //                 MainAxisAlignment.center,
                              //             crossAxisAlignment:
                              //                 CrossAxisAlignment.center,
                              //             children: [
                              //               FittedBox(
                              //                 child: Container(
                              //                   width: 52,
                              //                   height: 19,
                              //                   decoration: BoxDecoration(
                              //                     borderRadius:
                              //                         BorderRadius.circular(8),
                              //                     color: const Color(0xffff858f),
                              //                   ),
                              //                   padding: const EdgeInsets.symmetric(
                              //                     horizontal: 16,
                              //                     vertical: 2,
                              //                   ),
                              //                   child: Row(
                              //                     mainAxisSize: MainAxisSize.min,
                              //                     mainAxisAlignment:
                              //                         MainAxisAlignment.center,
                              //                     crossAxisAlignment:
                              //                         CrossAxisAlignment.center,
                              //                     children: const [
                              //                       FittedBox(
                              //                         child: Text(
                              //                           "Bad",
                              //                           style: TextStyle(
                              //                             color: Colors.white,
                              //                             fontSize: 10,
                              //                           ),
                              //                         ),
                              //                       ),
                              //                     ],
                              //                   ),
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              const Positioned(
                                left: 145,
                                top: 17,
                                child: FittedBox(
                                  child: Text(
                                    "derniere mise a jour:  Before 2 months",
                                    style: TextStyle(
                                      color: Color(0xffc4c4c4),
                                      fontSize: 9,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  left: 0.27 * size.width,
                                  top: 23,
                                  child: IconButton(
                                    icon: const Icon(Icons.mode_edit_outline),
                                    color: const Color.fromRGBO(209, 209, 209, 100),
                                    onPressed: () {},
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ]))),
        );
        }
      );
      }else{
        return const Scaffold(body: Center(child: CircularProgressIndicator()),);
      }
      }
    );
  }
}






 