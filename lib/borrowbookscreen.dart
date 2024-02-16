import 'dart:async';
import 'package:borrowbook/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class BorrowedBook extends StatefulWidget {
  const BorrowedBook({super.key});

  @override
  State<BorrowedBook> createState() => _BorrowedBookState();
}

class _BorrowedBookState extends State<BorrowedBook> {
  double screenHeight = 0;
  double screenWidth = 0;

  String checkIn2 = '';

  String checkIn = '--/--';
  String checkOut = '--/--';
  String locationCheckin = " ";
  String locationCheckout = " ";
  Color primary = const Color.fromRGBO(12, 45, 92, 1);
  bool check = false;

  final _booknameController = TextEditingController();
  final _typenameController = TextEditingController();

  String duedate = 'Date of Birth';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future addRecordDetails() async {
    QuerySnapshot sanp = await FirebaseFirestore.instance
        .collection("Employee")
        .where('username', isEqualTo: Users.username)
        .get();
    await FirebaseFirestore.instance
        .collection('Employee')
        .doc(sanp.docs[0].id)
        .collection('Record')
        .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
        .collection('mybooks')
        .doc()
        .set({
      'Datetime': Timestamp.now(),
      'borrowed': DateFormat('dd/MM/yyyy').format(DateTime.now()),
      'due': duedate,
      'namebook': _booknameController.text,
      'typebook': _typenameController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 32),
              child: Text(
                'Welcome',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth / 12),
              ),
            ),
            Text(
              Users.firstName,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'THsarabunBold',
                  fontSize: screenWidth / 10),
            ),
            Container(
                alignment: Alignment.topRight,
                child: RichText(
                  text: TextSpan(
                      text: DateTime.now().day.toString(),
                      style: TextStyle(
                        color: primary,
                        fontSize: screenWidth / 10,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'THsarabunBold',
                      ),
                      children: [
                        TextSpan(
                          text: DateFormat(' MMMM yyyy').format(DateTime.now()),
                          style: TextStyle(
                              fontFamily: 'THsarabunBold',
                              fontSize: screenWidth / 12,
                              color: Colors.black),
                        )
                      ]),
                )),
            StreamBuilder(
                stream: Stream.periodic(const Duration(seconds: 1)),
                builder: (context, snapshot) {
                  return Container(
                    alignment: Alignment.topRight,
                    child: Text(
                      DateFormat('hh:mm:ss a').format(DateTime.now()),
                      style: TextStyle(
                          fontFamily: 'THsarabunBold',
                          fontSize: screenWidth / 10,
                          color: Colors.black),
                    ),
                  );
                }),
            const SizedBox(
              height: 20,
            ),
            textField("Book Title", "Book Title", _booknameController),
            textField("Book Type", "Book Type", _typenameController),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Date Due',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "THsarabunBold",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 365 * 5)),
                  builder: (context, child) {
                    return Theme(
                        data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                                primary: primary,
                                secondary: primary,
                                onSecondary: Colors.white),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(primary: primary),
                            ),
                            textTheme: const TextTheme(
                              headline4: TextStyle(fontFamily: 'THsarabunBold'),
                              overline: TextStyle(fontFamily: 'THsarabunBold'),
                              button: TextStyle(fontFamily: 'THsarabunBold'),
                            )),
                        child: child!);
                  },
                ).then((value) {
                  if (value != '') {
                    setState(() {
                      duedate = DateFormat('dd/MM/yyyy').format(value!);
                    });
                  } else {
                    setState(() {
                      duedate = DateFormat('dd/MM/yyyy').format(DateTime.now());
                    });
                  }
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: kToolbarHeight,
                width: screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.black),
                ),
                child: Container(
                  padding: const EdgeInsets.only(left: 11, top: 10),
                  margin: const EdgeInsets.only(bottom: 12),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    duedate,
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: "THsarabunBold",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 75,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade600,
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: const Offset(4, 4)),
                  const BoxShadow(
                      color: Colors.white,
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: Offset(-4, -4))
                ],
                borderRadius: const BorderRadius.all(Radius.circular(100)),
              ),
              margin: const EdgeInsets.only(top: 40),
              child: MaterialButton(
                onPressed: () async {
                  addRecordDetails();
                  _booknameController.clear();
                  _typenameController.clear();
                  setState(() {
                    duedate = DateFormat('dd/MM/yyyy').format(DateTime.now());
                  });
                },
                color: Colors.blue,
                textColor: Colors.white,
                padding: const EdgeInsets.all(16),
                shape: const CircleBorder(),
                child: const Icon(
                  FontAwesomeIcons.penToSquare,
                  size: 40,
                ),
              ),
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
