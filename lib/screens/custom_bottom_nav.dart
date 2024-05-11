import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hum_chale/models/menu.dart';
import 'package:hum_chale/screens/trip_booking/trip_booking_home.dart';
import 'package:hum_chale/screens/trip_hosting/trip_hosting_home.dart';
import 'package:hum_chale/screens/profile/profile_home.dart';
import 'package:rive/rive.dart';
import '../widget/CustomAppBar.dart';
class CustomBottomNav extends StatefulWidget {
  static var routeName = "bottom-nav";
  const CustomBottomNav({super.key});
  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  static List<SMIBool> riveIconInput = [];
  static List<StateMachineController> controllers = [];
  static var pages=[const TripBookingHome(),TripHostingHome(),const ProfileHome()];
  PageController pageController=PageController(initialPage: 0);
  static List<dynamic> screens=[const TripBookingHome(),TripHostingHome(),const ProfileHome()];
  static int selectedNavIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedNavIndex = 0;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      // body: screens[selectedNavIndex],
      body: PageView(children: pages,controller: pageController,
        onPageChanged: (value) {
          setState(() {
            selectedNavIndex=value;
          });
        },
      ),
      bottomNavigationBar: Container(
        height: 75,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            color: const Color(0xFFD3F7FF).withOpacity(0.5),
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4FC3DC).withOpacity(0.3),
                offset: const Offset(0, 20),
                blurRadius: 20,
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(bottomNavItems.length, (index) {
            final riveIcon = bottomNavItems[index].rive;
            return GestureDetector(
              onTap: () {
                animatedTheIcon(index);
                // Navigator.pushNamed(context, )
                // if(selectedNavIndex!=index){
                //   Navigator.pushNamed(context, screens[index]);
                // }
                // if (selectedNavIndex == 1) {
                // TripHostingHome().dispose();
                // }
                setState(() {
                  selectedNavIndex = index;
                  pageController.animateToPage(index, duration: Duration(milliseconds: 200), curve: Curves.linear);
                });

              },
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                AnimatedBar(isActive: index == selectedNavIndex),
                SizedBox(
                  height: 32,
                  width: 34,
                  child: Opacity(
                    opacity: selectedNavIndex == index ? 1 : 0.5,
                    child: RiveAnimation.asset(
                      riveIcon.src,
                      artboard: riveIcon.artboard,
                      onInit: (artboard) {
                        riveOnInit(artboard,
                            stateMachineName: riveIcon.stateMachineName);
                      },
                    ),
                  ),
                ),
              ]),
            );
          }),
        ),
      ),
    );
  }

  void animatedTheIcon(int index) {
    // print("object");
    riveIconInput[index].change(true);
    Future.delayed(const Duration(seconds: 1), () {
      riveIconInput[index].change(false);
    });
  }

  void riveOnInit(Artboard artboard, {required String stateMachineName}) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, stateMachineName);
    artboard.addController(controller!);
    controllers.add(controller);
    riveIconInput.add(controller.findInput<bool>('active') as SMIBool);
  }
}

class AnimatedBar extends StatelessWidget {
  final bool isActive;
  const AnimatedBar({super.key, required this.isActive});
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 2),
      height: 5,
      width: isActive ? 20 : 0,
      decoration: const BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.all(Radius.circular(15))),
    );
  }
}
