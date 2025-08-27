import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{

  //Get table of employees
  final CollectionReference employees = FirebaseFirestore.instance.collection('Employees');
  final CollectionReference users = FirebaseFirestore.instance.collection('Users');

  //CREATE
  Future<void> addEmployee(String employee){
    return employees.add({
      'employee': employee,
      'timestamp': Timestamp.now(),
    });
  }

  //READ
  Stream<QuerySnapshot> getEmployeesStream(){
    final employeesStream = employees.orderBy('timestamp', descending: true).snapshots();

    return employeesStream;
  }

  //UPDATE
  Future<void> updateEmployee(String docID, String newEmployee){
    return employees.doc(docID).update({
      'employee': newEmployee,
      'timestamp': Timestamp.now(),
    });
  }


  //DELETE
  Future<void> deleteEmployee(String docID){
    return employees.doc(docID).delete();
  }

  //AUTH


}