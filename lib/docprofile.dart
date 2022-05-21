// ignore_for_file: sized_box_for_whitespace, file_names

import 'package:admin/show_error_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../colors.dart';
import 'getdata.dart';

// ignore: must_be_immutable
class DocProfile extends StatefulWidget {
  String id ;
  DocProfile({required this.id ,Key? key}) : super(key: key);

  @override
  State<DocProfile> createState() => _DocProfileState();
}
 var imageUrl = "assets/avatar.png";

class _DocProfileState extends State<DocProfile> {
  late final TextEditingController edit;
  TextEditingController dateinput = TextEditingController();

  String? formattedDate;

  @override
  void initState() {
    edit = TextEditingController();
    dateinput.text = "";
    super.initState();
  }

  @override
  void dispose() {
    edit.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: getData(widget.id),
      builder: (BuildContext context,snapshot){
      if (snapshot.hasData){
      Map content = snapshot.data as Map;
      return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: bluefnc),
          backgroundColor: bgcolor,
          elevation: 0.0,
        ),
        body:SafeArea(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                      SizedBox(width: 0.001 * size.width,),
                      IconButton(
                        icon: const Icon(Icons.mode_edit_outline),
                        color: const Color.fromRGBO(209, 209, 209, 100),
                        onPressed: () {
                          showDialog(
                          context: context,
                          builder: (context){
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60),
                                ),
                              elevation: 16,
                              child: Container(
                                height: 220,
                                width: 307,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 15,),
                                    const Text("edit this information",
                                      style: TextStyle(fontSize: 20,color: bluefnc),
                                    ),
                                    const SizedBox(height: 15,),
                                    Container(
                                      height: 50,
                                      width: 259,
                                      child: TextField(
                                        controller: edit,
                                        decoration: InputDecoration(labelText: "enter the new information here",
                                        labelStyle: const TextStyle(fontSize: 15,color: bluefnc),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide: const BorderSide(color: blueclr)
                                          ), 
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20,),
                                    SizedBox(
                                      width: 259,
                                      height: 50,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          try{
                                            await FirebaseFirestore.instance.collection('users').doc(widget.id).update({'full name' : edit.text});
                                            setState(() {
                                              content['full name'] = edit.text;
                                            });
                                            // ignore: use_build_context_synchronously
                                            Navigator.of(context).pop();
                                          }catch (e){
                                            showErrorDialog(context, e.toString());
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shadowColor: blueclr,
                                            elevation: 4,
                                            primary: blueclr,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10))),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: const [
                                            Icon(Icons.search_outlined),
                                            SizedBox(width: 5,),
                                            Text(
                                              "edit",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            
                                          ],
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            );
                          },
                        );
                        },
                      )
                    ],
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
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: size.width * 0.8,
                          height: size.height * 0.33,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: size.width * 0.8,
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
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          FittedBox(
                                            child: Text(
                                              "specialité : ",
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
                                              content['specialite'],
                                              style: TextStyle(
                                                color: const Color(0xffc4c4c4),
                                                fontSize: 0.03333333 * size.width,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 0.001 * size.width,),
                                      IconButton(
                                      icon: const Icon(Icons.mode_edit_outline,size: 20,),
                                      color:
                                           Colors.grey.shade400,
                                      onPressed: () {
                                        showDialog(
                                        context: context,
                                        builder: (context){
                                          return Dialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(60),
                                              ),
                                            elevation: 16,
                                            child: Container(
                                              height: 220,
                                              width: 307,
                                              child: Column(
                                                children: [
                                                  const SizedBox(height: 15,),
                                                  const Text("edit this information",
                                                    style: TextStyle(fontSize: 20,color: bluefnc),
                                                  ),
                                                  const SizedBox(height: 15,),
                                                  Container(
                                                    height: 50,
                                                    width: 259,
                                                    child: TextField(
                                                      controller: edit,
                                                      decoration: InputDecoration(labelText: "enter the new information here",
                                                      labelStyle: const TextStyle(fontSize: 15,color: bluefnc),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(15),
                                                        borderSide: const BorderSide(color: blueclr)
                                                        ), 
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20,),
                                                  SizedBox(
                                                    width: 259,
                                                    height: 50,
                                                    child: ElevatedButton(
                                                      onPressed: () async {
                                                        try{
                                                          await FirebaseFirestore.instance.collection('users').doc(widget.id).update({'specialite' : edit.text});
                                                          setState(() {
                                                            content['specialite'] = edit.text;
                                                          });
                                                          // ignore: use_build_context_synchronously
                                                          Navigator.of(context).pop();
                                                        }catch (e){
                                                          showErrorDialog(context, e.toString());
                                                        }
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                          shadowColor: blueclr,
                                                          elevation: 4,
                                                          primary: blueclr,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(10))),
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: const [
                                                          Icon(Icons.search_outlined),
                                                          SizedBox(width: 5,),
                                                          Text(
                                                            "edit",
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 20,
                                                              fontFamily: "Poppins",
                                                              fontWeight: FontWeight.w600,
                                                            ),
                                                          ),
                                                          
                                                        ],
                                                      ),
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                      },
                                    )
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
                                            CrossAxisAlignment.end,
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
                                          SizedBox(width: 0.001 * size.width,),
                                      IconButton(
                                      icon: const Icon(Icons.mode_edit_outline,size: 20,),
                                      color:
                                           Colors.grey.shade400,
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context){
                                            return Dialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(60),
                                                ),
                                              elevation: 16,
                                              child: Container(
                                                height: 220,
                                                width: 307,
                                                child: Column(
                                                  children: [
                                                    const SizedBox(height: 15,),
                                                    const Text("edit this information",
                                                      style: TextStyle(fontSize: 20,color: bluefnc),
                                                    ),
                                                    const SizedBox(height: 15,),
                                                    Container(
                                                      height: 50,
                                                      width: 259,
                                                      child: Container(
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
                                                    ),
                                                    const SizedBox(height: 20,),
                                                    SizedBox(
                                                      width: 259,
                                                      height: 50,
                                                      child: ElevatedButton(
                                                        onPressed: () async {
                                                          try{
                                                            await FirebaseFirestore.instance.collection('users').doc(widget.id).update({'date of birth' : formattedDate});
                                                            setState(() {
                                                              content['date of birth'] = formattedDate;
                                                            });
                                                            // ignore: use_build_context_synchronously
                                                            Navigator.of(context).pop();
                                                          }catch (e){
                                                            showErrorDialog(context, e.toString());
                                                          }
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            shadowColor: blueclr,
                                                            elevation: 4,
                                                            primary: blueclr,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(10))),
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: const [
                                                            Icon(Icons.search_outlined),
                                                            SizedBox(width: 5,),
                                                            Text(
                                                              "edit",
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 20,
                                                                fontFamily: "Poppins",
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                            ),
                                                            
                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    )
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
                                            CrossAxisAlignment.end,
                                        children: [
                                          FittedBox(
                                            child: Text(
                                              "localisation:",
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
                                              content['localisation'],
                                              style: TextStyle(
                                                color: const Color(0xffc4c4c4),
                                                fontSize: size.width * 0.03333333,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),SizedBox(width: 0.001 * size.width,),
                                      IconButton(
                                      icon: const Icon(Icons.mode_edit_outline,size: 20,),
                                      color:
                                           Colors.grey.shade400,
                                      onPressed: () {
                                        showDialog(
                                        context: context,
                                        builder: (context){
                                          return Dialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(60),
                                              ),
                                            elevation: 16,
                                            child: Container(
                                              height: 220,
                                              width: 307,
                                              child: Column(
                                                children: [
                                                  const SizedBox(height: 15,),
                                                  const Text("edit this information",
                                                    style: TextStyle(fontSize: 20,color: bluefnc),
                                                  ),
                                                  const SizedBox(height: 15,),
                                                  Container(
                                                    height: 50,
                                                    width: 259,
                                                    child: TextField(
                                                      controller: edit,
                                                      decoration: InputDecoration(labelText: "enter the new information here",
                                                      labelStyle: const TextStyle(fontSize: 15,color: bluefnc),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(15),
                                                        borderSide: const BorderSide(color: blueclr)
                                                        ), 
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20,),
                                                  SizedBox(
                                                    width: 259,
                                                    height: 50,
                                                    child: ElevatedButton(
                                                      onPressed: () async {
                                                        try{
                                                          await FirebaseFirestore.instance.collection('users').doc(widget.id).update({'localisation' : edit.text});
                                                          setState(() {
                                                            content['localisation'] = edit.text;
                                                          });
                                                          // ignore: use_build_context_synchronously
                                                          Navigator.of(context).pop();
                                                        }catch (e){
                                                          showErrorDialog(context, e.toString());
                                                        }
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                          shadowColor: blueclr,
                                                          elevation: 4,
                                                          primary: blueclr,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(10))),
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: const [
                                                          Icon(Icons.search_outlined),
                                                          SizedBox(width: 5,),
                                                          Text(
                                                            "edit",
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 20,
                                                              fontFamily: "Poppins",
                                                              fontWeight: FontWeight.w600,
                                                            ),
                                                          ),
                                                          
                                                        ],
                                                      ),
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                      },
                                    )
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
                                              CrossAxisAlignment.end,
                                          children: [
                                            FittedBox(
                                              child: Text(
                                                "code du docteur",
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
                                                content['code du docteur'],
                                                style: TextStyle(
                                                  color: const Color(0xffc4c4c4),
                                                  fontSize: size.width * 0.03333333,
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 0.001 * size.width,),
                                      IconButton(
                                      icon: const Icon(Icons.mode_edit_outline,size: 20,),
                                      color:
                                           Colors.grey.shade400,
                                      onPressed: () {
                                        showDialog(
                                        context: context,
                                        builder: (context){
                                          return Dialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(60),
                                              ),
                                            elevation: 16,
                                            child: Container(
                                              height: 220,
                                              width: 307,
                                              child: Column(
                                                children: [
                                                  const SizedBox(height: 15,),
                                                  const Text("edit this information",
                                                    style: TextStyle(fontSize: 20,color: bluefnc),
                                                  ),
                                                  const SizedBox(height: 15,),
                                                  Container(
                                                    height: 50,
                                                    width: 259,
                                                    child: TextField(
                                                      controller: edit,
                                                      decoration: InputDecoration(labelText: "enter the new information here",
                                                      labelStyle: const TextStyle(fontSize: 15,color: bluefnc),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(15),
                                                        borderSide: const BorderSide(color: blueclr)
                                                        ), 
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20,),
                                                  SizedBox(
                                                    width: 259,
                                                    height: 50,
                                                    child: ElevatedButton(
                                                      onPressed: () async {
                                                        try{
                                                          await FirebaseFirestore.instance.collection('users').doc(widget.id).update({'code du docteur' : edit.text});
                                                          setState(() {
                                                            content['code du docteur'] = edit.text;
                                                          });
                                                          // ignore: use_build_context_synchronously
                                                          Navigator.of(context).pop();
                                                        }catch (e){
                                                          showErrorDialog(context, e.toString());
                                                        }
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                          shadowColor: blueclr,
                                                          elevation: 4,
                                                          primary: blueclr,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(10))),
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: const [
                                                          Icon(Icons.search_outlined),
                                                          SizedBox(width: 5,),
                                                          Text(
                                                            "edit",
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 20,
                                                              fontFamily: "Poppins",
                                                              fontWeight: FontWeight.w600,
                                                            ),
                                                          ),
                                                          
                                                        ],
                                                      ),
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                      },
                                    )
                                          ],
                                        ),
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
                                              CrossAxisAlignment.end,
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
                                                content['phone number'],
                                                style: TextStyle(
                                                  color: const Color(0xffc4c4c4),
                                                  fontSize: size.width * 0.03333333,
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 0.001 * size.width,),
                                      IconButton(
                                      icon: const Icon(Icons.mode_edit_outline,size: 20,),
                                      color:
                                           Colors.grey.shade400,
                                      onPressed: () {
                                        showDialog(
                                        context: context,
                                        builder: (context){
                                          return Dialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(60),
                                              ),
                                            elevation: 16,
                                            child: Container(
                                              height: 220,
                                              width: 307,
                                              child: Column(
                                                children: [
                                                  const SizedBox(height: 15,),
                                                  const Text("edit this information",
                                                    style: TextStyle(fontSize: 20,color: bluefnc),
                                                  ),
                                                  const SizedBox(height: 15,),
                                                  Container(
                                                    height: 50,
                                                    width: 259,
                                                    child: TextField(
                                                      controller: edit,
                                                      decoration: InputDecoration(labelText: "enter the new information here",
                                                      labelStyle: const TextStyle(fontSize: 15,color: bluefnc),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(15),
                                                        borderSide: const BorderSide(color: blueclr)
                                                        ), 
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20,),
                                                  SizedBox(
                                                    width: 259,
                                                    height: 50,
                                                    child: ElevatedButton(
                                                      onPressed: () async {
                                                        try{
                                                          await FirebaseFirestore.instance.collection('users').doc(widget.id).update({'phone number' : edit.text});
                                                          setState(() {
                                                            content['phone number'] = edit.text;
                                                          });
                                                          // ignore: use_build_context_synchronously
                                                          Navigator.of(context).pop();
                                                        }catch (e){
                                                          showErrorDialog(context, e.toString());
                                                        }
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                          shadowColor: blueclr,
                                                          elevation: 4,
                                                          primary: blueclr,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(10))),
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: const [
                                                          Icon(Icons.search_outlined),
                                                          SizedBox(width: 5,),
                                                          Text(
                                                            "edit",
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 20,
                                                              fontFamily: "Poppins",
                                                              fontWeight: FontWeight.w600,
                                                            ),
                                                          ),
                                                          
                                                        ],
                                                      ),
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                      },
                                    ),
                                            const SizedBox(width: 15),
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
                ]))])])));
      
     }
     else{
       return const Scaffold(body: Center(child: CircularProgressIndicator()),);
     }
    }
      
  );
  
}
}

    
