import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isLogin = true;
  String email = '', password = '', username = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void authenticate() async {
    try {
      if (isLogin) {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
      }
      else {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'username': username,
          'email': email,
        });
      }
    }
    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFededeb),
      body: Container(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/2),
              padding: EdgeInsets.only(top: 45, left: 20, right: 20),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 53, 51, 51), Colors.black],
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                ),
                borderRadius: BorderRadius.vertical(
                  top: Radius.elliptical(MediaQuery.of(context).size.width, 110.0),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30, top: 60),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          "Let's start with\nAdmin",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 30.0,
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                      Material(
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: MediaQuery.of(context).size.height/2.2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 50,),
                              if (!isLogin)
                                TextField(
                                  onChanged: (val) => username = val,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    labelText: 'Username',
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                  ),
                                ),
                              SizedBox(height: 10),
                              TextField(
                                onChanged: (val) => email = val,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'Email',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                onChanged: (val) => password = val,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                obscureText: true,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'Password',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: authenticate,
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                                child: Text(isLogin ? 'Login' : 'Register',
                                    style: TextStyle(color: Colors.black)),
                              ),
                              TextButton(
                                onPressed: () => setState(() => isLogin = !isLogin),
                                child: Text(
                                  isLogin ? 'Create an account' : 'Already have an account?',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
