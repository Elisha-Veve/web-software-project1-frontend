import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api/api.dart';
import '../../Home/home_screen.dart';
import '../../Signup/signup_screen.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const LoginForm(
      {Key? key,
      required this.emailController,
      required this.passwordController})
      : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final double borderRadius = 20;
  final _formkey = GlobalKey<FormState>();
  bool _isLoading = false;

  Widget _buildEmailField() {
    return TextFormField(
      controller: widget.emailController,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          suffixIcon: Icon(Icons.email),
          labelText: 'Email',
          labelStyle: GoogleFonts.bebasNeue(
            fontSize: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              width: 0,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              width: 1,
              color: Theme.of(context).colorScheme.primary,
            ),
          )),
      style: GoogleFonts.bebasNeue(
        fontSize: 16,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: widget.passwordController,
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          suffixIcon: Icon(Icons.password),
          labelText: 'Password',
          labelStyle: GoogleFonts.bebasNeue(
            fontSize: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              width: 0,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              width: 1,
              color: Theme.of(context).colorScheme.primary,
            ),
          )),
      style: GoogleFonts.bebasNeue(
        fontSize: 16,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
    }

    void _submitForm() async {
      if (_formkey.currentState!.validate()) {
        _formkey.currentState!.save();
        setState(() {
          _isLoading = true;
        });
        print('Form is valid');
      } else {
        print('Form is invalid');
      }

      setState(() {
        _isLoading = false;
      });
      var data = {
        'email': widget.emailController.text,
        'password': widget.passwordController.text,
      };

      var res = await CallApi().postData(data, 'login');
      var body = jsonDecode(res.body);

      print(body);
      if (res.statusCode == 201) {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('token', body['token']);
        localStorage.setString('user', jsonEncode(body['user']));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }
      print(body);
    }

    return Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Sign in",
                style: GoogleFonts.bebasNeue(
                  fontSize: 40,
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                text: 'Don\'t have an account?',
                style: TextStyle(
                    fontSize: 20, color: Theme.of(context).colorScheme.primary),
                children: <TextSpan>[
                  TextSpan(
                      text: ' Sign up!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen()));
                        }),
                ],
              ),
            ),
            const SizedBox(height: 40),
            _buildEmailField(),
            const SizedBox(height: 20),
            _buildPasswordField(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text("Sign In"),
              style: ButtonStyle(
                shape: MaterialStateProperty.resolveWith(
                  (state) => RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius)),
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 25.0, horizontal: 60.0),
                ),
              ),
            ),
          ],
        ));
  }
}
