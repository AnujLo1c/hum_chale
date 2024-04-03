import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as Flutter;
import 'package:flutter/widgets.dart';
import 'package:rive/rive.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class LoginPage extends StatefulWidget {
  static String routeName = "login-page";
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String errormsg = "";
// input form controller
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  /// rive controller and input
  StateMachineController? controller;

  SMIInput<bool>? isChecking;
  SMIInput<double>? numLook;
  SMIInput<bool>? isHandsUp;
  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;

  @override
  void initState() {
    emailFocusNode.addListener(emailFocus);
    passwordFocusNode.addListener(passwordFocus);
    super.initState();
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

  void passwordFocus() {
    isHandsUp?.change(passwordFocusNode.hasFocus);
  }

  final TextEditingController _controlleremail = TextEditingController();
  final TextEditingController _controllerpass = TextEditingController();

  Future<void> signInWithEandP() async {
    // print("login");
    // if(await Checkuserclass()) {
    //
    //   // print(await Checkuserclass());
    //   try {
    //     trigSuccess?.change(true);
    //     // context.read<Username_provider>().setusername(Auth().currentUser?.email, context);
    //
    //     // await Auth().signInWithEandP(_controlleremail.text, _controllerpass.text);
    //     // Auth().signInWithEandP(_controlleremail.text, _controllerpass.text);
    //     // checkuserexits = false;
    //   } catch (e) {
    //
    //     setState(() {
    //       errormsg = e.toString();
    //       error();
    //     });
    //   }
    // }
    // else{
    //   trigFail?.change(true);
    //   setState(() {
    //
    //     errormsg="Users already exits in other class or not registered.";
    //     error();
    //
    //   });
    // }
  }

  Future<void> createUserWithEandP() async {
    // try{
    //   trigSuccess?.change(true);
    //   context.read<Username_provider>().setusername(Auth().currentUser?.email, context);
    //
    //   await Auth().signUpWithEandP(_controlleremail.text, _controllerpass.text);
    //   checkuserexits=true;
    // }on FirebaseAuthException catch(e){
    //   setState(() {
    //     errormsg=e.message;
    //     error();
    //   });
    // }
  }
  void error() {
    // Fluttertoast.showToast(msg: errormsg!,fontSize: 16,textColor: Colors.red,backgroundColor: Colors.transparent);
    errormsg = '';
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
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
                  Align(
                    alignment: Alignment.topRight,
                    child: RichText(
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
                  ),

                  SizedBox(
                    width: size.width-225,
                    height: 150,
                    child: Align(
                      alignment: Alignment.topRight,
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
                  trigSuccess = controller?.findInput("trigSuccess");
                  trigFail = controller?.findInput("trigFail");
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
                      style: Theme.of(context).textTheme.bodyMedium,
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
                      style: Theme.of(context).textTheme.bodyMedium,
                      onChanged: (value) {},
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      height: 38,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            // isLogin=!isLogin;
                          });
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
                        // showLoadingDialog(context);
                        emailFocusNode.unfocus();
                        passwordFocusNode.unfocus();
                        // isLogin? signInWithEandP() : createUserWithEandP();
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
                          width: (size.width/3)-10,
                        ),
                        const SizedBox(
                            width: 20,
                            child: Divider(thickness: 3,color: Colors.black,)
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 40,
                          child: const Text("or",style: TextStyle(fontSize: 18,),),
                        ),
                        const SizedBox(
                            width: 20,
                            child: Divider(thickness: 3,color: Colors.black,)
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 36,
                    child: TextButton(onPressed: (){},
                        child: Text("Sign Up",style: TextStyle(color: Colors.grey,fontSize: 16,),)
                    ),
                  )
                ],


                
              ),
            ),
          ],
        ),
      ),
    );
  }

/////
// Future<bool> Checkuserclass()async{
//   print("checking user class");
//   CollectionReference cref = FirebaseFirestore.instance.collection(
//       "studentids");
//   bool ds = await cref.doc(_controlleremail.text).get().then((value){
//     if(value.exists){
//       var dsdata = value.get("ClassName");
//
//       String cname=Provider.of<Classname_provider>(context,listen: false).classname;
//       print(cname);
//       print(dsdata);
//       if(dsdata != cname){
//         return false;
//       }
//       else{
//         return true;
//       }
//     }else{
//       return false;
//     }
//   }
//   );
//   return ds;
}
