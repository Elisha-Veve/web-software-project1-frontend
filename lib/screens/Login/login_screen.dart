import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zanpakuto/screens/Login/components/login_form.dart';

import '../../responsive/responsive_layout_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

const double borderRadius = 20;

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
        mobile: MLoginScreen(), desktop: DLoginScreen());
  }
}

class MLoginScreen extends StatefulWidget {
  const MLoginScreen({Key? key}) : super(key: key);

  @override
  State<MLoginScreen> createState() => _MLoginScreenState();
}

class _MLoginScreenState extends State<MLoginScreen> {
  final titleStyle = GoogleFonts.bebasNeue(
    fontSize: 40,
  );
  final fieldTextStyle = const TextStyle(
    fontSize: 16,
  );

  final double borderRadius = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: const LoginForm(),
          ),
        ),
      ),
    );
  }
}

class DLoginScreen extends StatefulWidget {
  const DLoginScreen({Key? key}) : super(key: key);

  @override
  State<DLoginScreen> createState() => _DLoginScreenState();
}

class _DLoginScreenState extends State<DLoginScreen> {
  final titleStyle = GoogleFonts.bebasNeue(
    fontSize: 40,
  );
  final fieldTextStyle = const TextStyle(
    fontSize: 16,
  );
  final subtitleStyle = const TextStyle(
    fontSize: 20,
  );
  final double borderRadius = 20;
  @override
  Widget build(BuildContext context) {
    final bgImage = MediaQuery.of(context).platformBrightness == Brightness.dark
        ? 'assets/images/dark_sign.jpg'
        : 'assets/images/light_sign.jpg';

    final gradient =
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? [
                const Color(0xFF053B52).withOpacity(1),
                const Color(0xFF053B52).withOpacity(1),
                const Color(0xFF053B52).withOpacity(1),
                const Color(0xFF053B52).withOpacity(1),
                const Color(0xFF053B52).withOpacity(0.9),
                const Color(0xFF053B52).withOpacity(0.7),
                const Color(0xFF053B52).withOpacity(0.6),
                const Color(0xFF053B52).withOpacity(0.4),
                const Color(0xFF053B52).withOpacity(0),
              ]
            : [
                const Color(0xFFFFFFFF).withOpacity(1),
                const Color(0xFFFFFFFF).withOpacity(1),
                const Color(0xFFFFFFFF).withOpacity(1),
                const Color(0xFFFFFFFF).withOpacity(1),
                const Color(0xFFFFFFFF).withOpacity(0.9),
                const Color(0xFFFFFFFF).withOpacity(0.7),
                const Color(0xFFFFFFFF).withOpacity(0.6),
                const Color(0xFFFFFFFF).withOpacity(0.4),
                const Color(0xFFFFFFFF).withOpacity(0),
              ];
    return Scaffold(
        body: CustomScrollView(slivers: [
      SliverFillRemaining(
        hasScrollBody: false,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bgImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(40),
            decoration:
                BoxDecoration(gradient: LinearGradient(colors: gradient)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Expanded(child: LoginForm()),
                Expanded(child: Container()),
              ],
            ),
          ),
        ),
      )
    ]));
  }
}
