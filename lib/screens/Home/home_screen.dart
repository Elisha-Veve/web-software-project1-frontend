import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zanpakuto/screens/Login/login_screen.dart';

import '../../api/api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userData;
  var token;

  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = jsonDecode(userJson!);
    var tokenn = localStorage.getString('token');
    setState(() {
      userData = user;
      token = tokenn;
    });
  }

  @override
  Widget build(BuildContext context) {
    void _logout() async {
      setState(() {});

      var res = await CallApi().logout();
      var body = jsonDecode(res.body);

      print(body);
      if (res.statusCode == 200) {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('token', "");
        localStorage.setString('user', "");
      }
      print(body);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(userData != null ? '${userData['name']}' : ''),
            Text(userData != null ? '${userData['email']}' : ''),
            Text(userData != null ? '$token' : ''),
            Text(userData != null ? '${userData['name']}' : ''),
            ElevatedButton(
              onPressed: _logout,
              child: Text("Logout",
                  style:
                      GoogleFonts.bebasNeue(fontSize: 20, color: Colors.white)),
              style: ButtonStyle(
                shape: MaterialStateProperty.resolveWith(
                  (state) => RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 25.0, horizontal: 60.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
