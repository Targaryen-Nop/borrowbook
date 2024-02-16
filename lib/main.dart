import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:borrowbook/homescreen.dart';
import 'package:borrowbook/loginscreen.dart';
import 'package:borrowbook/model/user.dart';
import 'package:month_year_picker/month_year_picker.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: KeyboardVisibilityProvider(
        child: AuthCheck(),
      ),
      localizationsDelegates: [MonthYearPickerLocalizations.delegate],
    );
  }
}

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  bool userAvailable = false;
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() async {
    sharedPreferences = await SharedPreferences.getInstance();
    try {
      if (sharedPreferences.getString('employeeUser') != '') {
        QuerySnapshot snap = await FirebaseFirestore.instance
            .collection("Employee")
            .where('username',
                isEqualTo: sharedPreferences.getString('employeeUser')!)
            .get();
        setState(() {
          Users.username = sharedPreferences.getString('employeeUser')!;
          Users.id = sharedPreferences.getString('employeeID')!;
          Users.id_student = sharedPreferences.getString('studentID')!;
          Users.id_major = sharedPreferences.getString('majorID')!;
          Users.firstName = sharedPreferences.getString('name')!;
          Users.lastName = sharedPreferences.getString('lastName')!;
          Users.age = sharedPreferences.getString('age')!;
          Users.address = sharedPreferences.getString('address')!;
          Users.major = sharedPreferences.getString('major')!;
          Users.faculty = sharedPreferences.getString('faculty')!;
          Users.phone = sharedPreferences.getString('phone')!;
          Users.career = sharedPreferences.getString('career')!;
          userAvailable = true;
        });
      }
    } catch (e) {
      setState(() {
        userAvailable = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return userAvailable
        ? const HomeScreeen()
        : const KeyboardVisibilityProvider(
            child: LoginScreen(),
          );
  }
}
