import 'dart:async';
import 'package:borrowbook/calendarscreen.dart';
import 'package:borrowbook/borrowbookscreen.dart';
import 'package:borrowbook/profilescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:borrowbook/profilescreen.dart';

class HomeScreeen extends StatefulWidget {
  const HomeScreeen({super.key});

  @override
  State<HomeScreeen> createState() => HomeScreeenState();
}

class HomeScreeenState extends State<HomeScreeen> {
  late SharedPreferences sharedPreferences;
  @override
  void initState() {
    super.initState();
  }

  void _getCredentials() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('Employee')
        .doc('XWGUEbtxAOXQg2MU73hu')
        .get();

    // setState(() {
    //   Users.conEdit = doc['conEdit'];
    //   Users.firstName = doc['firstName'];
    //   Users.lastName = doc['lastName'];
    //   Users.phone = doc['phone'];
    //   Users.birthDate = doc['birthDate'];
    // });
  }

  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = const Color.fromRGBO(12, 45, 92, 1);
  int currerntIndex = 1;

  List<IconData> navigationIcons = [
    FontAwesomeIcons.calendarDay,
    FontAwesomeIcons.pencil,
    FontAwesomeIcons.user,
  ];

  void changePage(int newIndex) {
    setState(() {
      currerntIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: IndexedStack(
        index: currerntIndex,
        children: const [
          CalendarScreen(),
          BorrowedBook(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        margin: const EdgeInsets.only(
          left: 12,
          right: 12,
          bottom: 24,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          boxShadow: [
            BoxShadow(
                color: Colors.black26, blurRadius: 10, offset: Offset(2, 2))
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < navigationIcons.length; i++) ...<Expanded>{
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      changePage(i);
                    },
                    child: Container(
                      height: screenHeight,
                      width: screenWidth,
                      color: Colors.white,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              navigationIcons[i],
                              color:
                                  i == currerntIndex ? primary : Colors.black54,
                              size: i == currerntIndex ? 30 : 26,
                            ),
                            i == currerntIndex
                                ? Container(
                                    margin: const EdgeInsets.only(top: 6),
                                    height: 3,
                                    width: 22,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(40)),
                                      color: primary,
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              }
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Perform cleanup when the widget is removed from the tree.
    super.dispose();
  }
}
