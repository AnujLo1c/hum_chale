import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hum_chale/authentication/GoogleLogin.dart';
import 'package:hum_chale/authentication/Shared_pref.dart';
// import 'package:hum_chale/screens/after_confirmation/list_screen/Expense_list.dart';
// import 'package:hum_chale/screens/after_confirmation/list_screen/packing_list.dart';
// import 'package:hum_chale/screens/after_confirmation/list_screen/todo_list.dart';
import 'package:hum_chale/ui/CustomColors.dart';
import 'package:hum_chale/screens/after_confirmation/ac_home.dart';
class ProfileHome extends StatefulWidget {
  const ProfileHome({super.key});

  @override
  State<ProfileHome> createState() => _ProfileHomeState();
}

class _ProfileHomeState extends State<ProfileHome> {
Size? size;

  @override
  Widget build(BuildContext context) {
    size=MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Gap(20),
          const Text("Profile",style: TextStyle(fontSize: 34),),
      const Gap(10),
          SizedBox(
      height: 150,
      width: size?.width
      ,child: Image.asset("assets/images/default-img.png")),
          const Gap(10),
          const Text("User Name",style: TextStyle(fontSize: 24),),
          const Gap(20),
          ProfileTile("Booking Updates", ()=>Navigator.pushNamed(context, Achome.routeName), Icons.bookmark_add_outlined),
          ProfileTile("Trip History", (){}, Icons.history),
          ProfileTile("Help", (){}, Icons.help_outline),
          ProfileTile("Settings", (){}, Icons.settings),
          ProfileTile("Log Out", (){GoogleLogin().logOutFromGoogle(context);
            SharedPref().LogoutSP();
            }, Icons.logout),
          // ElevatedButton(onPressed: ()=>Navigator.pushNamed(context, Achome.routeName), child: Text("data"))
        ],
      ),
    );
  }

Widget ProfileTile(String text,dynamic onTap,IconData icon){
  return GestureDetector(
    onTap: onTap
    ,child: Container(
      height: size!.height/16,
      width: size?.width,
      margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 20),
      decoration: BoxDecoration(
        color:CustomColors.tileColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
    border:  Border.all(width: 2,color: CustomColors.shadowColor),
        boxShadow: [
          const BoxShadow(color: CustomColors.shadowColor,
          blurRadius: 50,spreadRadius: 10),
        ]
    
      ),
      child: Row(
        children: [const Gap(10),
          Icon(icon),
          const Gap(10),
          Text(text),
          const Spacer(),
          const Icon(Icons.chevron_right),
          const Gap(10)
        ],
      ),
    ),
  );
}
}
