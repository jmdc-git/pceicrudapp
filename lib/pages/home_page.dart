// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pseicrud_app/pages/add_page.dart';
import 'package:pseicrud_app/pages/updatedelete_page.dart';
import 'package:pseicrud_app/pages/view_page.dart';
import 'package:pseicrud_app/services/firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //access the firestore
  final FirestoreService firestoreService = FirestoreService();

  //get current user
  final user = FirebaseAuth.instance.currentUser!;

  //text controller to listen for typed text
  final TextEditingController textController = TextEditingController();

  //CREATE & UPDATE: open a dialog box to add or edit an employee
  // void openEmployeeBox({String? docID}) {
  //   showDialog(
  //     context: context, 
  //     builder: (context) => AlertDialog(
  //       //text user input
  //       content: TextField(
  //         controller: textController,
  //       ),
  //       actions: [
  //         //button to add
  //         ElevatedButton(
  //           onPressed: (){
  //             //add to firestore
  //             if (docID == null){
  //             firestoreService.addEmployee(textController.text);
  //             }
  //             //edit to firestore
  //             else{
  //               firestoreService.updateEmployee(docID, textController.text);
  //             }

  //             //text to clear
  //             textController.clear();

  //             //close dialog
  //             Navigator.pop(context);
  //           }, 
  //           child: Text("Add"),
  //           ),
  //       ]
  //   ),
  //   );
  // }

  void signUserOut(){
    FirebaseAuth.instance.signOut();
  }

  void _navigateToViewPage(BuildContext context){
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewPage()));
  }

    void _navigateToAddPage(BuildContext context){
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddPage()));
  }

    void _navigateToUpdateDeletePage(BuildContext context){
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => UpdatedeletePage()));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome ${user.email!}"), 
        actions: [
          IconButton(
            onPressed: signUserOut, 
            icon: Icon(Icons.logout)
            )
          ],
        ),
        body:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            ElevatedButton(
            onPressed: (){
              _navigateToViewPage(context);
            },
            child: Text("View Employees"),
            ),
            ElevatedButton(
              onPressed: (){
                _navigateToAddPage(context);
              }, child: Text("Add Employees")
            ),
            ElevatedButton(
              onPressed: (){
                _navigateToUpdateDeletePage(context);
              }, child: Text("Update Employees")
              ),

          ],)
          
      );
        
      // //CREATE: Action Button for adding 
      // floatingActionButton: FloatingActionButton(
      //   onPressed:  openEmployeeBox,
      //   child: const Icon(Icons.add)
      //   ),
        //READ: displays collection of employees
        // body: StreamBuilder<QuerySnapshot>(
        //   stream: firestoreService.getEmployeesStream(),
        //   builder: (context, snapshot){

        //     //if we have data get all the docs
        //     if (snapshot.hasData){
        //       List employeesList = snapshot.data!.docs;

        //       return ListView.builder(

        //         itemCount: employeesList.length,
        //         itemBuilder: (context,index){

        //           //get individual item
        //           DocumentSnapshot document = employeesList[index];
        //           String docID = document.id;

        //           //get employee from each item
        //           Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        //           String employeeText = data['employee'];

        //           //display as a  tile
        //           return ListTile(
        //              title: Text(employeeText),
        //              trailing: Row(
        //               mainAxisSize: MainAxisSize.min,
        //                children: [
        //                 //update button
        //                  IconButton(
        //                   onPressed: () => openEmployeeBox(docID: docID), 
        //                   icon: const Icon(Icons.settings),
        //                   ),
        //                 // delete button
        //                 IconButton(
        //                   onPressed: () => firestoreService.deleteEmployee(docID), 
        //                   icon: const Icon(Icons.delete)
        //                   )
        //                ],
        //              ),
        //           );
        //         }
        //       );
        //     } else {
        //       // if no employee on table
        //       return const Text("No employees");
        //     }
        //   },
        // ),

  }

  
}