import 'package:flutter/material.dart';
import 'package:hum_chale/models/menu.dart';
import 'package:hum_chale/screens/custom_bottom_nav.dart';
import 'package:rive/rive.dart';
class TripBookingHome extends StatefulWidget {
  static var routeName = "trip-booking-home";
  const TripBookingHome({super.key});

  @override
  State<TripBookingHome> createState() => _TripBookingHomeState();
}

class _TripBookingHomeState extends State<TripBookingHome> {
  // List<SMIBool> riveIconInput=[];
  // List<StateMachineController> controllers=[];
  // int selectedNavIndex=0;
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   for(var controller in controllers){
  //     controller.dispose();
  //   }
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    return Container(
child: Text("help"),
    );
  }
// void animatedTheIcon(int index) {
//     // print("object");
//   riveIconInput[index].change(true);
//   Future.delayed(const Duration(seconds: 1),(){
//     riveIconInput[index].change(false);
//   });
// }
// void riveOnInit(Artboard artboard,{required String stateMachineName}){
//   StateMachineController? controller=StateMachineController.fromArtboard(artboard,stateMachineName );
//   artboard.addController(controller!);
//  controllers.add(controller);
//   riveIconInput.add(controller.findInput<bool>('active') as SMIBool);
//
// }
}

// class AnimatedBar extends StatelessWidget {
// final bool isActive;
//   const AnimatedBar( {
//     super.key,
//     required this.isActive
//   });
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(duration: const Duration(milliseconds: 200),
//     margin: const EdgeInsets.only(bottom: 2),
//     height: 5,
//       width: isActive?20:0,
//       decoration: const BoxDecoration(
//         color: Colors.black54
//             ,borderRadius: BorderRadius.all(Radius.circular(15))
//       ),
//     );
//   }
// }

