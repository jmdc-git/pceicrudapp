import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pseicrud_app/services/firestore.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({super.key});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  
  void signUserOut(){
    FirebaseAuth.instance.signOut();
  }

final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Employees"), 
        actions: [
          IconButton(
            onPressed: signUserOut, 
            icon: Icon(Icons.logout)
            )
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: firestoreService.getEmployeesStream(),
          builder: (context, snapshot){

            //if we have data get all the docs
            if (snapshot.hasData){
              List employeesList = snapshot.data!.docs;

              return ListView.builder(

                itemCount: employeesList.length,
                itemBuilder: (context,index){

                  //get individual item
                  DocumentSnapshot document = employeesList[index];
                  // String docID = document.id;

                  //get employee from each item
                  Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                  String employeeText = data['employee'];

                  //display as a  tile
                  return ListTile(
                     title: Text(employeeText),
                     trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                     ),
                  );
                }
              );
            } else {
              // if no employee on table
              return const Text("No employees");
            }
          },
        ),
    );
  }
}