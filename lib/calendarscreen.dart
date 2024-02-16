import 'package:borrowbook/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = const Color.fromRGBO(12, 45, 92, 1);

  String _month = DateFormat('MMMM').format(DateTime.now());
  String _date = DateFormat('dd/MM/yyyy').format(DateTime.now());
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Users.id != ""
        ? Scaffold(
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 35, bottom: 20),
                    child: Text(
                      'My Books',
                      style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'THsarabunBold',
                          fontSize: screenWidth / 10),
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          _date,
                          style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'THsarabunBold',
                              fontSize: screenWidth / 10),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        margin: const EdgeInsets.only(top: 10),
                        child: GestureDetector(
                          onTap: () async {
                            int nowyear = DateTime.now().year.toInt();
                            final month = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(nowyear),
                              lastDate: DateTime(2099),
                              builder: (context, child) {
                                return Theme(
                                    data: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.light(
                                            primary: primary,
                                            secondary: primary,
                                            onSecondary: Colors.white),
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                              primary: primary),
                                        ),
                                        textTheme: const TextTheme(
                                          headline4:
                                              TextStyle(fontFamily: 'THsarabunBold'),
                                          overline:
                                              TextStyle(fontFamily: 'THsarabunBold'),
                                          button:
                                              TextStyle(fontFamily: 'THsarabunBold'),
                                        )),
                                    child: child!);
                              },
                            );

                            if (month != null) {
                              setState(() {
                                _month = DateFormat('MMMM').format(month);
                                _date = DateFormat('dd/MM/yyyy').format(month);
                              });
                            }
                          },
                          child: Text(
                            'Pick Month',
                            style: TextStyle(
                                color: Colors.black54,
                                fontFamily: 'THsarabunBold',
                                fontSize: screenWidth / 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: screenHeight / 1.45,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Employee')
                          .doc(Users.id)
                          .collection('Record')
                          .doc(
                              DateFormat('dd MMMM yyyy').format(DateTime.now()))
                          .collection('mybooks')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          final snap = snapshot.data!.docs;
                          return ListView.builder(
                            itemCount: snap.length,
                            itemBuilder: (context, index) {
                              return DateFormat('dd/MM/yyyy').format(
                                          snap[index]['Datetime'].toDate()) ==
                                      _date
                                  ? Container(
                                      margin: const EdgeInsets.only(
                                          top: 12,
                                          right: 6,
                                          left: 6,
                                          bottom: 10),
                                      height: 200,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 10,
                                              offset: Offset(2, 2))
                                        ],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 120,
                                            decoration: BoxDecoration(
                                                color: primary,
                                                borderRadius: const BorderRadius.all(
                                                    Radius.circular(20))),
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text('Borrowed',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'THsarabunBold',
                                                          fontSize:
                                                              screenWidth / 16,
                                                          color: Colors.white)),
                                                  Text(snap[index]['borrowed'],
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'THsarabunBold',
                                                          fontSize:
                                                              screenWidth / 14,
                                                          color: Colors.white)),
                                                  Text('Due',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'THsarabunBold',
                                                          fontSize:
                                                              screenWidth / 16,
                                                          color: Colors.white)),
                                                  Text(snap[index]['due'],
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'THsarabunBold',
                                                          fontSize:
                                                               screenWidth / 14,
                                                          color: Colors.white)),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.all(15),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Book Title  :",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            screenWidth / 20,
                                                        color: Colors.black),
                                                  ),
                                                  Text(
                                                      snap[index]['namebook'],
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'THsarabun',
                                                          fontSize:
                                                              screenWidth / 16,
                                                          color:
                                                              Colors.black54)),
                                                  Text(
                                                    "Book Type :",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            screenWidth / 20,
                                                        color: Colors.black),
                                                  ),
                                                  Text(
                                                      snap[index]['typebook'],
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'THsarabun',
                                                          fontSize:
                                                              screenWidth / 16,
                                                          color:
                                                              Colors.black54)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : SizedBox();
                            },
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ),
                  // Container(
                  //   margin: const EdgeInsets.only(
                  //       top: 12, right: 6, left: 6, bottom: 10),
                  //   height: 200,
                  //   decoration: const BoxDecoration(
                  //     color: Colors.white,
                  //     boxShadow: [
                  //       BoxShadow(
                  //           color: Colors.black26,
                  //           blurRadius: 10,
                  //           offset: Offset(2, 2))
                  //     ],
                  //     borderRadius: BorderRadius.all(Radius.circular(20)),
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       Container(
                  //         width: 120,
                  //         margin: EdgeInsets.only(),
                  //         decoration: BoxDecoration(
                  //             color: primary,
                  //             borderRadius:
                  //                 BorderRadius.all(const Radius.circular(20))),
                  //         child: Center(
                  //           child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             children: [
                  //               Text('Borrowed',
                  //                   style: TextStyle(
                  //                       fontFamily: 'THsarabunBold',
                  //                       fontSize: screenWidth / 22,
                  //                       color: Colors.white)),
                  //               Text('1/2/2024',
                  //                   style: TextStyle(
                  //                       fontFamily: 'THsarabunBold',
                  //                       fontSize: screenWidth / 20,
                  //                       color: Colors.white)),
                  //               Text('Due',
                  //                   style: TextStyle(
                  //                       fontFamily: 'THsarabunBold',
                  //                       fontSize: screenWidth / 22,
                  //                       color: Colors.white)),
                  //               Text('11/2/2024',
                  //                   style: TextStyle(
                  //                       fontFamily: 'THsarabunBold',
                  //                       fontSize: screenWidth / 20,
                  //                       color: Colors.white)),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: Container(
                  //           padding: EdgeInsets.all(15),
                  //           child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.start,
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 "Book Title  :",
                  //                 style: TextStyle(
                  //                     fontWeight: FontWeight.bold,
                  //                     fontSize: screenWidth / 20,
                  //                     color: Colors.black),
                  //               ),
                  //               Text(
                  //                   'The Name Book: Over 10,000 Names : Their Meanings, Origins, and Spiritual Significance',
                  //                   style: TextStyle(
                  //                       fontFamily: 'THsarabunBold',
                  //                       fontSize: screenWidth / 26,
                  //                       color: Colors.black54)),
                  //               Text(
                  //                 "Book Type :",
                  //                 style: TextStyle(
                  //                     fontWeight: FontWeight.bold,
                  //                     fontSize: screenWidth / 20,
                  //                     color: Colors.black),
                  //               ),
                  //               Text('Christian Books & Bibles',
                  //                   style: TextStyle(
                  //                       fontFamily: 'THsarabunBold',
                  //                       fontSize: screenWidth / 26,
                  //                       color: Colors.black54)),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          )
        : SizedBox();
  }
}
