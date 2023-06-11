import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_to_give_23/pages/update.dart';
import 'package:code_to_give_23/pages/update_case_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'add_case_page.dart';
// import 'package:flutter_fbfirestore_crud/pages/update_student_page.dart';

class ListCasePage extends StatefulWidget {
  ListCasePage({Key? key}) : super(key: key);

  @override
  _ListCasePageState createState() => _ListCasePageState();
}

class _ListCasePageState extends State<ListCasePage> {
  final Stream<QuerySnapshot> studentsStream =
      FirebaseFirestore.instance.collection('Cases').snapshots();

  // For Deleting User
  CollectionReference students = FirebaseFirestore.instance.collection('Cases');
  Future<void> deleteUser(id) {
    // print("User Deleted $id");
    return students
        .doc(id)
        .delete()
        .then((value) => print('User Deleted'))
        .catchError((error) => print('Failed to Delete user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: studentsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong in list case page');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];
          //   [
          //     {caseNumber: 1}
          //   ],
          // [{'caseNumber':'2', 'childName':'Ankita'},{'childClassification':'Surrendered'}],
          // [{'caseNumber':'3', 'childName':'Manan'},{'childClassification':'Abandoned'}]
          // ];
          snapshot.data?.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();

          return Scaffold(
              appBar: AppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Assigned Cases'),
                    ElevatedButton(
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddCasePage(),
                          ),
                        )
                      },
                      child: Text('Add', style: TextStyle(fontSize: 20.0)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 108, 170, 105)),
                    )
                  ],
                ),
              ),
              body: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Table(
                    border: TableBorder.all(),
                    columnWidths: const <int, TableColumnWidth>{
                      1: FixedColumnWidth(90),
                      0: FixedColumnWidth(80),
                      2: FixedColumnWidth(100),
                      // 3: FixedColumnWidth(40),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              // color: Colors.greenAccent,
                              child: Center(
                                child: Text(
                                  'Case Number',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              // color: Colors.greenAccent,
                              child: Center(
                                child: Text(
                                  'Child Name',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              // color: Colors.greenAccent,
                              child: Center(
                                child: Text(
                                  'Child Classification',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              // color: Colors.greenAccent,
                              child: Center(
                                child: Text(
                                  'Action',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      for (var i = 0; i < 1; i++) ...[
                        TableRow(
                          children: [
                            TableCell(
                              child: Center(
                                  child: Text("KVB-001",
                                      // storedocs[i]['caseNumber'],
                                      style: TextStyle(fontSize: 18.0))),
                            ),
                            TableCell(
                              child: Center(
                                  child: Text("Sarita",
                                    // storedocs[i]['childName'],
                                      style: TextStyle(fontSize: 18.0))),
                            ),
                            TableCell(
                              child: Center(
                                  child: Text("Abandoned",
                                      // storedocs[i]['childClassification'],
                                      style: TextStyle(fontSize: 18.0))),
                            ),
                            TableCell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () => {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Update(),
                                              // id: storedocs[i]['id']),
                                        ),
                                      )
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        {deleteUser(storedocs[i]['id'])},
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],




                      for (var i = 0; i < 1; i++) ...[
                        TableRow(
                          children: [
                            TableCell(
                              child: Center(
                                  child: Text("KVB-002",
                                      // storedocs[i]['caseNumber'],
                                      style: TextStyle(fontSize: 18.0))),
                            ),
                            TableCell(
                              child: Center(
                                  child: Text("Manan",
                                    // storedocs[i]['childName'],
                                      style: TextStyle(fontSize: 18.0))),
                            ),
                            TableCell(
                              child: Center(
                                  child: Text("Surrendered",
                                      // storedocs[i]['childClassification'],
                                      style: TextStyle(fontSize: 18.0))),
                            ),
                            TableCell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () => {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Update(),
                                              // id: storedocs[i]['id']),
                                        ),
                                      )
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        {deleteUser(storedocs[i]['id'])},
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],




                      for (var i = 0; i < 1; i++) ...[
                        TableRow(
                          children: [
                            TableCell(
                              child: Center(
                                  child: Text("KVB-003",
                                      // storedocs[i]['caseNumber'],
                                      style: TextStyle(fontSize: 18.0))),
                            ),
                            TableCell(
                              child: Center(
                                  child: Text("Ankita",
                                    // storedocs[i]['childName'],
                                      style: TextStyle(fontSize: 18.0))),
                            ),
                            TableCell(
                              child: Center(
                                  child: Text("Abandoned",
                                      // storedocs[i]['childClassification'],
                                      style: TextStyle(fontSize: 18.0))),
                            ),
                            TableCell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () => {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Update(),
                                              // id: storedocs[i]['id']),
                                        ),
                                      )
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        {deleteUser(storedocs[i]['id'])},
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],

                      for (var i = 0; i < 1; i++) ...[
                        TableRow(
                          children: [
                            TableCell(
                              child: Center(
                                  child: Text("KVB-004",
                                      // storedocs[i]['caseNumber'],
                                      style: TextStyle(fontSize: 18.0))),
                            ),
                            TableCell(
                              child: Center(
                                  child: Text("Raj",
                                    // storedocs[i]['childName'],
                                      style: TextStyle(fontSize: 18.0))),
                            ),
                            TableCell(
                              child: Center(
                                  child: Text("Abandoned",
                                      // storedocs[i]['childClassification'],
                                      style: TextStyle(fontSize: 18.0))),
                            ),
                            TableCell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () => {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Update(),
                                              // id: storedocs[i]['id']),
                                        ),
                                      )
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        {deleteUser(storedocs[i]['id'])},
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],

                      for (var i = 0; i < 1; i++) ...[
                        TableRow(
                          children: [
                            TableCell(
                              child: Center(
                                  child: Text("KVB-005",
                                      // storedocs[i]['caseNumber'],
                                      style: TextStyle(fontSize: 18.0))),
                            ),
                            TableCell(
                              child: Center(
                                  child: Text("Bhoomika",
                                    // storedocs[i]['childName'],
                                      style: TextStyle(fontSize: 18.0))),
                            ),
                            TableCell(
                              child: Center(
                                  child: Text("Surrendered",
                                      // storedocs[i]['childClassification'],
                                      style: TextStyle(fontSize: 18.0))),
                            ),
                            TableCell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () => {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Update(),
                                              // id: storedocs[i]['id']),
                                        ),
                                      )
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        {deleteUser(storedocs[i]['id'])},
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],

                      
                      for (var i = 0; i < 1; i++) ...[
                        TableRow(
                          children: [
                            TableCell(
                              child: Center(
                                  child: Text("KVB-006",
                                      // storedocs[i]['caseNumber'],
                                      style: TextStyle(fontSize: 18.0))),
                            ),
                            TableCell(
                              child: Center(
                                  child: Text("ankit",
                                    // storedocs[i]['childName'],
                                      style: TextStyle(fontSize: 18.0))),
                            ),
                            TableCell(
                              child: Center(
                                  child: Text("Surrendered",
                                      // storedocs[i]['childClassification'],
                                      style: TextStyle(fontSize: 18.0))),
                            ),
                            TableCell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () => {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Update(),
                                              // id: storedocs[i]['id']),
                                        ),
                                      )
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        {deleteUser(storedocs[i]['id'])},
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],

                      
                      for (var i = 0; i < 1; i++) ...[
                        TableRow(
                          children: [
                            TableCell(
                              child: Center(
                                  child: Text("KVB-007",
                                      // storedocs[i]['caseNumber'],
                                      style: TextStyle(fontSize: 18.0))),
                            ),
                            TableCell(
                              child: Center(
                                  child: Text("Riya",
                                    // storedocs[i]['childName'],
                                      style: TextStyle(fontSize: 18.0))),
                            ),
                            TableCell(
                              child: Center(
                                  child: Text("Surrendered",
                                      // storedocs[i]['childClassification'],
                                      style: TextStyle(fontSize: 18.0))),
                            ),
                            TableCell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () => {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Update(),
                                              // id: storedocs[i]['id']),
                                        ),
                                      )
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        {deleteUser(storedocs[i]['id'])},
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],


                    
                  ),
                ),
              ));
        });
  }
}
