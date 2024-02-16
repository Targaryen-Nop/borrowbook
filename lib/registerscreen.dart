import 'package:borrowbook/loginscreen.dart';
import 'package:borrowbook/model/user.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class RegisterBook extends StatefulWidget {
  const RegisterBook({super.key});

  @override
  State<RegisterBook> createState() => _RegisterBookState();
}

class _RegisterBookState extends State<RegisterBook> {
  double screenHeight = 0;
  double screenWidth = 0;

  String checkIn2 = '';

  String checkIn = '--/--';
  String checkOut = '--/--';
  String locationCheckin = " ";
  String locationCheckout = " ";
  Color primary = const Color.fromRGBO(12, 45, 92, 1);
  bool check = false;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _studentIDController = TextEditingController();
  final TextEditingController _majorIDController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _facultyController = TextEditingController();
  final TextEditingController _majorController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _careerController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String duedate = 'Date of Birth';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future addRecordDetails() async {
    await FirebaseFirestore.instance.collection('Employee').doc().set({
      'Datetime': Timestamp.now(),
      'username': _usernameController.text,
      'password': _passwordController.text,
      'name': _firstNameController.text,
      'lastname': _lastNameController.text,
      'id': _studentIDController.text,
      'id_major': _majorIDController.text,
      'faculty': _facultyController.text,
      'major': _majorController.text,
      'phone': _phoneController.text,
      'age': _ageController.text,
      'address': _addressController.text,
      'career': _careerController.text,
    });
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const KeyboardVisibilityProvider(
                  child: LoginScreen(),
                )));
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: ListView(
      children: [
        Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Center(
              child: Text(
                'Register',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "THsarabunBold",
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            textField("Username", "Username", _usernameController),
            textField("Password", "Password", _passwordController),
            textField("First Name", "First Name", _firstNameController),
            textField("Last Name", "Last Name", _lastNameController),
            textField("Student ID", "Student ID", _studentIDController),
            textField("Major ID", "Major ID", _majorIDController),
            textField("Age", "Age", _ageController),
            textField("Faculty", "Faculty", _facultyController),
            textField("Major", "Major", _majorController),
            textField("Phone", "Phone", _phoneController),
            textField("Career", "Career", _careerController),
            textField("Address", "Address", _addressController),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: GestureDetector(
                        onTap: () async {
                          addRecordDetails();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(12)),
                          child: const Center(
                            child: Text(
                              'Register',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: GestureDetector(
                        onTap: () async {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const KeyboardVisibilityProvider(
                                        child: LoginScreen(),
                                      )));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(12)),
                          child: const Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ));
  }

  Widget textField(
      String hint, String title, TextEditingController controller) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: "THsarabunBold",
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          margin: const EdgeInsets.only(bottom: 12),
          child: TextFormField(
            controller: controller,
            cursorColor: Colors.black,
            maxLines: 1,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: Colors.black,
                fontFamily: "THsarabunBold",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
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
