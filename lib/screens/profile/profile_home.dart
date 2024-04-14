import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Gap(20),
        Text("Profile",style: TextStyle(fontSize: 34),),
Gap(10),
        SizedBox(
height: 150,
width: size?.width
,child: Image.asset("assets/images/default-img.png")),
        Gap(10),
        Text("User Name",style: TextStyle(fontSize: 24),),
        Gap(20),
        ProfileTile("Booking Updates", (){}, Icons.bookmark_add_outlined),
        ProfileTile("Trip History", (){}, Icons.history),
        ProfileTile("Help", (){}, Icons.help_outline),
        ProfileTile("Setting", (){}, Icons.settings),
        ProfileTile("Log Out", ()=>Navigator.pushNamed(context, Achome.routeName), Icons.logout),

      ],
    );
  }

Widget ProfileTile(String text,dynamic onTap,IconData icon){
  return GestureDetector(
    onTap: onTap
    ,child: Container(
      height: size!.height/16,
      width: size?.width,
      margin: EdgeInsets.symmetric(vertical: 8,horizontal: 20),
      decoration: BoxDecoration(
        color:CustomColors.tileColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
    border:  Border.all(width: 2,color: CustomColors.shadowColor),
        boxShadow: [
          BoxShadow(color: CustomColors.shadowColor,
          blurRadius: 50,spreadRadius: 10),
        ]
    
      ),
      child: Row(
        children: [Gap(10),
          Icon(icon),
          Gap(10),
          Text(text),
          Spacer(),
          Icon(Icons.chevron_right),
          Gap(10)
        ],
      ),
    ),
  );
}
}
