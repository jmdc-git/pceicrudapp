// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pseicrud_app/services/firestore.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  //access the firestore
  final FirestoreService firestoreService = FirestoreService();

  //text controller to listen for typed text
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //sign user in method
  void signUserIn() async {
    try{
       await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, 
        password: passwordController.text
      );
    }catch(error){
      return showDialog(
        // ignore: use_build_context_synchronously
        context: context, 
        builder: (context) => AlertDialog(
          content: Text("Invalid email or password")
        )
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Login",
            style: TextStyle(
              fontSize: 30,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),

          //Form starts here
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Form(
              child: Column(
                children: [
                  //Text field for email
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter email',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String value){
            
                    },
                    validator: (value){
                      return value!.isEmpty ? 'Please enter email' : null;
                    },
                  ),
            
                  SizedBox(height: 20,),
            
                  //Text field for password
                  TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter password',
                      prefixIcon: Icon(Icons.password),
                      border: OutlineInputBorder(),  
                    ),
                    onChanged: (String value){
            
                    },
                    validator: (value){
                      return value!.isEmpty ? 'Please enter password' : null;
                    },
                  ),
                  
                  MaterialButton(
                    minWidth: double.infinity,
                    onPressed: signUserIn,
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text("Login"),
                  )
                ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}