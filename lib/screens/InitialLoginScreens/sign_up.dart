import 'package:flutter/material.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text("Hum Chale",style: TextStyle(fontSize: 24),),
      ),
      body: Placeholder(),
    ));
  }
}

//     return Container(
//       width: screenSize.width,
//       height: screenSize.height,
//       clipBehavior: Clip.antiAlias,
//       decoration: BoxDecoration(
//         color: Color(0xFF4FC3DC),
//       ),
//       child: Stack(
//         children: [
//           _buildLogo(),
//           _buildFormField(
//             leftPosition: 16,
//             topPosition: 421,
//             labelText: 'Full Name',
//             width: 309,
//           ),
//           _buildFormField(
//             leftPosition: 16,
//             topPosition: 516,
//             labelText: 'Phone No.',
//             width: 398,
//           ),
//           _buildFormField(
//             leftPosition: 16,
//             topPosition: 611,
//             labelText: 'Email address',
//             width: 398,
//           ),
//           _buildFormField(
//             leftPosition: 16,
//             topPosition: 706,
//             labelText: 'Password',
//             width: 398,
//           ),
//           _buildFormField(
//             leftPosition: 337,
//             topPosition: 421,
//             labelText: 'Age',
//             width: 77,
//           ),
//           _buildProfileImage(),
//           _buildSignInButton(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLogo() {
//     return Positioned(
//       left: 43,
//       top: 23,
//       child: SizedBox(
//         width: 331,
//         height: 42,
//         child: Text(
//           'Hum Chale',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 48,
//             fontFamily: 'Playfair Display',
//             fontWeight: FontWeight.w800,
//             height: 1.0,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildFormField({
//     double leftPosition,
//     double topPosition,
//     String labelText,
//     double width,
//   }) {
