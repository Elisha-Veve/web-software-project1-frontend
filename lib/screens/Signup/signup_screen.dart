import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../responsive/responsive_layout_screen.dart';
import 'components/signup_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobile: MSignupScreen(
          usernameController: usernameController,
          emailController: emailController,
          passwordController: passwordController,
          confirmPasswordController: confirmPasswordController,
        ),
        desktop: DSignupScreen(
          usernameController: usernameController,
          emailController: emailController,
          passwordController: passwordController,
          confirmPasswordController: confirmPasswordController,
        ));
  }
}

class MSignupScreen extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const MSignupScreen({
    Key? key,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  }) : super(key: key);

  @override
  State<MSignupScreen> createState() => _MSignupScreenState();
}

class _MSignupScreenState extends State<MSignupScreen> {
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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: SignupForm(
              usernameController: widget.usernameController,
              emailController: widget.emailController,
              passwordController: widget.passwordController,
              confirmPasswordController: widget.confirmPasswordController,
            ),
          ),
        ),
      ),
    );
  }
}

class DSignupScreen extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const DSignupScreen({
    Key? key,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  }) : super(key: key);

  @override
  State<DSignupScreen> createState() => _DSignupScreenState();
}

class _DSignupScreenState extends State<DSignupScreen> {
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
                Expanded(
                  child: SignupForm(
                    usernameController: widget.usernameController,
                    emailController: widget.emailController,
                    passwordController: widget.passwordController,
                    confirmPasswordController: widget.confirmPasswordController,
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
        ),
      )
    ]));
  }
}
