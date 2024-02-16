import 'dart:io';
import 'package:borrowbook/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _phoneController = TextEditingController();
  double screenHeight = 0;
  double screenWidth = 0;

  String birthDate = 'Date of Birth';

  Color primary = const Color.fromRGBO(12, 45, 92, 1);

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 75),
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Username : ${Users.username}',
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: "NexaBold",
                  fontSize: screenWidth / 20,
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Name : ${Users.firstName} ${Users.lastName}',
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: "NexaBold",
                  fontSize: screenWidth / 20,
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
             Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Age : ${Users.age}',
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: "NexaBold",
                  fontSize: screenWidth / 20,
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'ID : ${Users.id_student} ',
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: "NexaBold",
                  fontSize: screenWidth / 20,
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Major ID : ${Users.id_major} ',
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: "NexaBold",
                  fontSize: screenWidth / 20,
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Faculty : ${Users.faculty} ',
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: "NexaBold",
                  fontSize: screenWidth / 20,
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Major : ${Users.major} ',
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: "NexaBold",
                  fontSize: screenWidth / 20,
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Phone : ${Users.phone} ',
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: "NexaBold",
                  fontSize: screenWidth / 20,
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Address : ${Users.address} ',
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: "NexaBold",
                  fontSize: screenWidth / 20,
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            const SizedBox(
              height: 24,
            ),
          
          ],
        ),
      ),
    );
  }

  Widget textField(
      String hint, String title, TextEditingController controller) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black54,
              fontFamily: "NexaBold",
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          margin: EdgeInsets.only(bottom: 12),
          child: TextFormField(
            controller: controller,
            cursorColor: Colors.black54,
            maxLines: 1,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: Colors.black54,
                fontFamily: "NexaBold",
                fontSize: 14,
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black54,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(text),
      ),
    );
  }
}
