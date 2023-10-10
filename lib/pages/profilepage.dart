import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complete Profile"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(25),
        child: ListView(
          children: [
            CupertinoButton(
              onPressed: () {},
              child: CircleAvatar(
                  radius: 60,
                  child: Icon(
                    Icons.person,
                    size: 52,
                  )),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              decoration: InputDecoration(hintText: "Full Name"),
            ),
            SizedBox(
              height: 30,
            ),
            CupertinoButton(
                child: Text("Submit"), color: Colors.blue, onPressed: () {})
          ],
        ),
      ),
    );
  }
}
