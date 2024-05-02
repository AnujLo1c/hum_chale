
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as Flutter;
import 'package:hum_chale/authentication/GoogleLogin.dart';
import 'package:hum_chale/authentication/email_pass_login.dart';
import 'package:hum_chale/authentication/forgot_password.dart';
import 'package:hum_chale/screens/InitialLoginScreens/sign_up.dart';
import 'package:hum_chale/widget/loading-dialog.dart';
import 'package:rive/rive.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class LoginPage extends StatefulWidget {
  static String routeName = "login-page";
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  /// rive controller and input
  StateMachineController? controller;

  SMIInput<bool>? isChecking;
  SMIInput<double>? numLook;
  SMIInput<bool>? isHandsUp;

  // SMIInput<bool>? trigSuccess;
  // SMIInput<bool>? trigFail;

  @override
  void initState() {
    super.initState();
    emailFocusNode.addListener(emailFocus);
    passwordFocusNode.addListener(passwordFocus);
  }

  @override
  void dispose() {
    emailFocusNode.removeListener(emailFocus);
    passwordFocusNode.removeListener(passwordFocus);

    super.dispose();
  }

  void emailFocus() {
    isChecking?.change(emailFocusNode.hasFocus);
  }

  // setTrigSuccess() {
  //   trigSuccess = trigSuccess!;
  // }

  void passwordFocus() {
    isHandsUp?.change(passwordFocusNode.hasFocus);
  }

  final TextEditingController _controlleremail = TextEditingController();
  final TextEditingController _controllerpass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: const Color(0xFF4FC3DC),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                      text: const TextSpan(
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontFamily: 'Playfair Display',
                          ),
                          children: [
                        TextSpan(
                            text: "Let's enjoy the\n",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400,
                            )),
                        TextSpan(
                            text: "Beautiful\nWorld",
                            style: TextStyle(fontSize: 45))
                      ])),
                  SizedBox(
                    width: size.width - 225,
                    height: 150,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: ()=>GoogleLogin().signInWithGoogle(context),
                        child: Container(
                          height: 50,
                          width: 50,
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: Image.asset("assets/images/google.png"),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 250,
              width: 320,
              child: RiveAnimation.asset(
                "assets/rive/login-bear.riv",

                fit: BoxFit.fitHeight,
                stateMachines: const ["Login Machine"],
                onInit: (artboard) {
                  controller = StateMachineController.fromArtboard(
                    artboard,
                    "Login Machine",
                  );
                  if (controller == null) return;
                  artboard.addController(controller!);
                  isChecking = controller?.findInput("isChecking");
                  numLook = controller?.findInput("numLook");
                  isHandsUp = controller?.findInput("isHandsUp");
                  // trigSuccess = controller?.findInput("trigSuccess");
                  // trigFail = controller?.findInput("trigFail");
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.8),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                      border: const GradientBoxBorder(
                          width: 2,
                          gradient: Flutter.LinearGradient(colors: [
                            Colors.blueAccent,
                            Colors.blue,
                            Colors.lightBlue,
                            Colors.lightBlueAccent
                          ])),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: TextField(
                      focusNode: emailFocusNode,
                      controller: _controlleremail,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                          hintStyle: TextStyle(fontSize: 18)
                      ),
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyMedium,
                      onChanged: (value) {
                        numLook?.change(value.length.toDouble());
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                      border: const GradientBoxBorder(
                          width: 2,
                          gradient: Flutter.LinearGradient(colors: [
                            Colors.blueAccent,
                            Colors.blue,
                            Colors.lightBlue,
                            Colors.lightBlueAccent
                          ])),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: TextField(
                      focusNode: passwordFocusNode,
                      controller: _controllerpass,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                          hintStyle: TextStyle(fontSize: 18)
                      ),
                      obscureText: true,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyMedium,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      height: 38,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, ForgotPassword.routeName);
                          // setState(() {
                            // isLogin=!isLogin;
                          // });
                        },
                        // child:  Text(isLogin ? 'Register ' : 'Login'),
                        child: const Text('Forget Password?'),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () {
                        emailFocusNode.unfocus();
                        passwordFocusNode.unfocus();
                        String email = _controlleremail.text.trim();
                        String pass = _controllerpass.text.trim();
                        if (email.isNotEmpty && pass.isNotEmpty) {
                          precacheImage(
                              const AssetImage("assets/images/explore.jpg"),
                              context);
                          LoadingDialog().loadingDialog(context);
                          EmailPassLogin().userLogin(context, email, pass);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Email Or Password field must be filled.")));
                        }
                        // Navigator.pushNamed(context, Explore.routeName);


                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4FC3DC),
                        foregroundColor: const Color(0xFFFFFFFF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(
                              color: Colors.black,
                              width: 1,
                            )),
                      ),
                      // child:  Text(!isLogin ? 'Register ' : 'Login ',style: const TextStyle(letterSpacing: 1,fontSize: 18),),
                      child: const Text(
                        'Login ',
                        style: TextStyle(letterSpacing: 1, fontSize: 24),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6,),
                  SizedBox(
                    height: 25,
                    child: Row(
                      children: [
                        SizedBox(
                          width: (size.width / 3) - 10,
                        ),
                        const SizedBox(
                            width: 20,
                            child: Divider(thickness: 3, color: Colors.black,)
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 40,
                          child: const Text("or", style: TextStyle(
                            fontSize: 18,),),
                        ),
                        const SizedBox(
                            width: 20,
                            child: Divider(thickness: 3, color: Colors.black,)
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 36,
                    child: TextButton(onPressed: () =>
                        Navigator.pushNamed(context, SignUp.routeName),
                        child: const Text("Sign Up",
                          style: TextStyle(color: Colors.grey, fontSize: 16,),)
                    ),
                  ),
                  // ElevatedButton(onPressed: ()=>push, child: child)
                ],


              ),
            ),
          ],
        ),
      ),
    );
  }}