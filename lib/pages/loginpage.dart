import 'package:chatappfirebase/pages/signuppage.dart';
import 'package:chatappfirebase/usermodel/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  checkValues() {
    String email = emailcontroller.text.trim();
    String password = passwordcontroller.text.trim();
    if (email == "" || password == "") {
      print("please fill all textfield");
    } else {
      logIn(email, password);
    }
  }

  void logIn(String email, String password) async {
    UserCredential? Credential;
    try {
      Credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseException catch (exp) {
      print(exp.message.toString());
    }
    if (Credential != null) {
      String uid = Credential.user!.uid;
      DocumentSnapshot userData =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      userModel usermodel =
          userModel.fromMap(userData.data() as Map<String, dynamic>);
      print("login successfully");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 253, 253),
      body: Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  "lib/images/chatimage.png",
                  fit: BoxFit.cover,
                ),
                Text(
                  "Chat_Cat App",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 34,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 55,
                ),
                TextField(
                  controller: emailcontroller,
                  onTap: () {},
                  decoration: InputDecoration(hintText: "Email Address"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: passwordcontroller,
                  obscureText: true,
                  onTap: () {},
                  decoration: InputDecoration(hintText: "Password"),
                ),
                SizedBox(
                  height: 24,
                ),
                CupertinoButton(
                    child: Text("Login"),
                    color: Colors.blue,
                    onPressed: () {
                      checkValues();
                    })
              ]),
        )),
      ),
      bottomNavigationBar: Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account?",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          CupertinoButton(
              child: Text(
                "Sign up",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignupPage()));
              })
        ],
      )),
    );
  }
}
