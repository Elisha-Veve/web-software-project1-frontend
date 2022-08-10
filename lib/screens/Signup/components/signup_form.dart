import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zanpakuto/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zanpakuto/screens/Login/login_screen.dart';

import '../../Home/home_screen.dart';

class SignupForm extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const SignupForm({
    Key? key,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  }) : super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  static const double borderRadius = 20;
  final _formkey = GlobalKey<FormState>();
  bool _isLoading = false;

  Widget _buildNameField() {
    return TextFormField(
      controller: widget.usernameController,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
          labelText: 'Name',
          labelStyle: GoogleFonts.bebasNeue(
            fontSize: 16,
          ),
          suffixIcon: const Icon(
            Icons.person,
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
          return 'Please enter your name';
        }
        return null;
      },
    );
  }

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

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      controller: widget.confirmPasswordController,
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          suffixIcon: Icon(Icons.password),
          labelText: 'Confirm Password',
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
    final _formkey = GlobalKey<FormState>();

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
        'name': widget.usernameController.text,
        'email': widget.emailController.text,
        'password': widget.passwordController.text,
        'password_confirmation': widget.confirmPasswordController.text,
      };

      var res = await CallApi().postData(data, 'register');
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
            Text("Sign up",
                style: GoogleFonts.bebasNeue(
                  fontSize: 40,
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                text: 'Already have an account?',
                style: GoogleFonts.bebasNeue(
                    fontSize: 20, color: Theme.of(context).colorScheme.primary),
                children: <TextSpan>[
                  TextSpan(
                      text: ' Sign in!',
                      style: GoogleFonts.bebasNeue(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        }),
                ],
              ),
            ),
            const SizedBox(height: 40),
            _buildNameField(),
            const SizedBox(height: 20),
            _buildEmailField(),
            const SizedBox(height: 20),
            _buildPasswordField(),
            const SizedBox(height: 20),
            _buildConfirmPasswordField(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text("Sign Up",
                  style:
                      GoogleFonts.bebasNeue(fontSize: 20, color: Colors.white)),
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
