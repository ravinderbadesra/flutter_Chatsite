import 'package:chatappfirebase/pages/loginpage.dart';
import 'package:chatappfirebase/pages/profilepage.dart';
import 'package:chatappfirebase/usermodel/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // const SignupPage({super.key});
  TextEditingController emailcontroller = TextEditingController();

  TextEditingController passwordcontroller = TextEditingController();

  TextEditingController cpasswordcontroller = TextEditingController();

  void checkValue() {
    String email = emailcontroller.text.trim();
    String password = passwordcontroller.text.trim();
    String cpassword = cpasswordcontroller.text.trim();
    if (email == "" || password == "" || cpassword == "") {
      print("please fill all field nuccessery");
    } else if (password != cpassword) {
      print("password not matched!");
    } else {
      signUp(email, password);
    }
  }

  void signUp(String email, String password) async {
    UserCredential? credential;

    try {
      credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (ex) {
      print(ex.message.toString());
    }

    if (credential != null) {
      String uid = credential.user!.uid;
      userModel newUser =
          userModel(uid: uid, email: email, fullname: "", profilepic: "");
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .set(newUser.toMap())
          .then((value) {
        print("New User Created!");
      });
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
                  "Chat App",
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
                  height: 10,
                ),
                TextField(
                  controller: cpasswordcontroller,
                  obscureText: true,
                  onTap: () {},
                  decoration: InputDecoration(hintText: "Confirm Password"),
                ),
                SizedBox(
                  height: 24,
                ),
                CupertinoButton(
                    child: Text("Sign Up"),
                    color: Colors.blue,
                    onPressed: () {
                      checkValue();
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ProfilePage()));
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
                "Log in",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              })
        ],
      )),
    );
  }
}
