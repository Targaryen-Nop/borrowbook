import 'package:borrowbook/homescreen.dart';
import 'package:borrowbook/model/user.dart';
import 'package:borrowbook/registerscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double screenHeight = 0;
  double screenWidth = 0;

  Color primary = Color.fromARGB(255, 122, 1, 1);

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardVisible =
        KeyboardVisibilityProvider.isKeyboardVisible(context);
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          isKeyboardVisible
              ? SizedBox(
                  height: screenHeight / 20,
                )
              : Container(
                  height: screenHeight / 3,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: primary,
                    // borderRadius: const BorderRadius.only(
                    //      Radius.circular(55))
                  ),
                  child: Center(
                      child: Image(
                    image: const AssetImage('assets/images/logo.png'),
                    height: screenHeight / 5,
                  )),
                ),
          Container(
            margin: EdgeInsets.only(
                top: screenHeight / 15, bottom: screenHeight / 25),
            child: Text(
              "Login",
              style: TextStyle(
                  fontSize: screenWidth / 10,
                  fontFamily: "THsarabun",
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(
              horizontal: screenWidth / 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                fieldTitle('Username'),
                customField('Student ID', _emailController, false),
                fieldTitle('Password'),
                customField('Password', _passwordController, false),
                Container(
                  margin: const EdgeInsets.only(top: 32),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: GestureDetector(
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        String email = _emailController.text.trim();
                        String password = _passwordController.text.trim();
                        if (email.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Email in still empty!")));
                        } else if (password.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Paswword in still empty !")));
                        } else {
                          QuerySnapshot sanp = await FirebaseFirestore.instance
                              .collection("Employee")
                              .where('username', isEqualTo: email)
                              .get();

                          try {
                            if (password == sanp.docs[0]['password']) {
                              QuerySnapshot snap2 = await FirebaseFirestore
                                  .instance
                                  .collection("Employee")
                                  .where('username', isEqualTo: email)
                                  .get();
                              setState(() {
                                Users.username = snap2.docs[0]['username'];
                                Users.age = snap2.docs[0]['username'];
                                Users.firstName = snap2.docs[0]['name'];
                                Users.lastName = snap2.docs[0]['lastname'];
                                Users.phone = snap2.docs[0]['phone'];
                                Users.id_major = snap2.docs[0]['id_major'];
                                Users.major = snap2.docs[0]['major'];
                                Users.faculty = snap2.docs[0]['faculty'];
                                Users.career = snap2.docs[0]['career'];
                                Users.id = snap2.docs[0].id;
                                Users.address = snap2.docs[0]['address'];
                              });

                              sharedPreferences =
                                  await SharedPreferences.getInstance();
                              sharedPreferences.setString(
                                  'employeeID', snap2.docs[0].id);
                              sharedPreferences.setString(
                                  'studentID', snap2.docs[0]['id']);
                              sharedPreferences.setString(
                                  'majorID', snap2.docs[0]['id_major']);
                              sharedPreferences.setString(
                                  'major', snap2.docs[0]['major']);
                              sharedPreferences.setString(
                                  'faculty', snap2.docs[0]['faculty']);
                              sharedPreferences.setString(
                                  'career', snap2.docs[0]['career']);
                              sharedPreferences.setString(
                                  'name', snap2.docs[0]['name']);
                              sharedPreferences.setString(
                                  'lastname', snap2.docs[0]['lastname']);
                              sharedPreferences.setString(
                                  'phone', snap2.docs[0]['phone']);
                              sharedPreferences.setString(
                                  'address', snap2.docs[0]['address']);
                              sharedPreferences.setString(
                                  'age', snap2.docs[0]['age']);
                              sharedPreferences
                                  .setString('employeeUser', email)
                                  .then((_) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreeen()));
                              });
                            } else {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Paswword in wrong !")));
                            }
                          } catch (e) {
                            String error = '';

                            if (e.toString() ==
                                "RangeError (index): Invalid value: Valid value range is empty: 0") {
                              setState(() {
                                error = 'Employee is not exist';
                              });
                            } else {
                              setState(() {
                                error = 'Error occured';
                              });
                            }
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(error)));
                          }
                        }
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
                Container(
                  margin: const EdgeInsets.only(top: 32),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: GestureDetector(
                      onTap: () async {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const KeyboardVisibilityProvider(
                                      child: RegisterBook(),
                                    )));
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget fieldTitle(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      child: Text(
        title,
        style: TextStyle(fontSize: screenWidth / 26, fontFamily: "THsarabun"),
      ),
    );
  }

  Widget customField(
      String hint, TextEditingController controller, bool obscureText) {
    return Container(
      margin: EdgeInsets.only(bottom: screenWidth / 50),
      width: screenWidth,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black26, blurRadius: 10, offset: Offset(2, 2))
          ]),
      child: Row(
        children: [
          Container(
            width: screenWidth / 6,
            child: Icon(
              Icons.person,
              color: primary,
              size: screenWidth / 15,
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(right: screenWidth / 12),
            child: TextFormField(
              enableSuggestions: false,
              obscureText: obscureText,
              controller: controller,
              autocorrect: false,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: screenHeight / 35,
                  ),
                  border: InputBorder.none,
                  hintText: hint),
              maxLines: 1,
            ),
          ))
        ],
      ),
    );
  }
}
