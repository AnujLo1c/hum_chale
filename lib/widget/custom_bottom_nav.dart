import 'package:flutter/material.dart';
import 'package:hum_chale/models/menu.dart';
import 'package:rive/rive.dart';
class CustomBottomNav extends StatefulWidget {
  const CustomBottomNav({super.key});
  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}
class _CustomBottomNavState extends State<CustomBottomNav> {
  List<SMIBool> riveIconInput=[];
  List<StateMachineController> controllers=[];
  int selectedNavIndex=0;
  @override
  void dispose() {
    // TODO: implement dispose
    for(var controller in controllers){
      controller.dispose();
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 75,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 30,vertical: 5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white,width: 2),
            color: const Color(0xFFD3F7FF).withOpacity(0.5),
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4FC3DC).withOpacity(0.3),
                offset: const Offset(0,20),
                blurRadius: 20,
              )
            ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(bottomNavItems.length,
                  (index) {
                final riveIcon=bottomNavItems[index].rive;
                return GestureDetector(
                  onTap: (){
                    animatedTheIcon(index);
                    setState(() {
                      selectedNavIndex=index;
                    });
                  }
                  , child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedBar(isActive: index==selectedNavIndex),
                      SizedBox(
                        height: 32,
                        width: 34,
                        child: Opacity(
                          opacity: selectedNavIndex==index?1:0.5,
                          child: RiveAnimation.asset(
                            riveIcon.src,
                            artboard: riveIcon.artboard,
                            onInit: (artboard){
                              riveOnInit(artboard,stateMachineName: riveIcon.stateMachineName);},
                          ),
                        ),
                      ),
                    ]
                ),
                );
              }
          ),
        ),
      ),
    );
  }
  void animatedTheIcon(int index) {
    // print("object");
    riveIconInput[index].change(true);
    Future.delayed(const Duration(seconds: 1),(){
      riveIconInput[index].change(false);
    });
  }
  void riveOnInit(Artboard artboard,{required String stateMachineName}){
    StateMachineController? controller=StateMachineController.fromArtboard(artboard,stateMachineName );
    artboard.addController(controller!);
    controllers.add(controller);
    riveIconInput.add(controller.findInput<bool>('active') as SMIBool);
  }
}
class AnimatedBar extends StatelessWidget {
  final bool isActive;
  const AnimatedBar( {
    super.key,
    required this.isActive
  });
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 2),
      height: 5,
      width: isActive?20:0,
      decoration: const BoxDecoration(
          color: Colors.black54
          ,borderRadius: BorderRadius.all(Radius.circular(15))
      ),
    );
  }
}

