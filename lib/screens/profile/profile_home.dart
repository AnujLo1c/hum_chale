
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hum_chale/authentication/GoogleLogin.dart';
import 'package:hum_chale/authentication/Shared_pref.dart';
import 'package:hum_chale/firebase/user_firestore_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hum_chale/screens/profile/hosted_trip_request.dart';
import 'package:hum_chale/screens/profile/trip_history.dart';
import 'package:hum_chale/ui/CustomColors.dart';
import 'package:hum_chale/screens/profile/trip_booking_status.dart';
import 'package:hum_chale/screens/profile/settings_screen.dart';

class ProfileHome extends StatefulWidget {
  const ProfileHome({super.key});
  @override
  State<ProfileHome> createState() => _ProfileHomeState();
}

class _ProfileHomeState extends State<ProfileHome> {
  static Size? size;

  static bool c = true;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: UserFirestore().fetchUserData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
            color: CustomColors.primaryColor,
          ));
        } else if (snapshot.hasError) {
          return Text(
            'Error: ${snapshot.error}',
          );
        } else {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Gap(20),
                Text("  Profile",
                    style: GoogleFonts.playfairDisplay(
                        fontSize: 34,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600)),
                const Gap(10),
                Center(
                  child: ClipOval(
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      height: 150,
                      width: 150,
                      imageUrl: snapshot.data?["ImageURL"],
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const CircleAvatar(
                        foregroundColor: Colors.white,
                        backgroundColor: CustomColors.primaryColor,
                        radius: 100,
                        child: Icon(
                          Icons.person,
                          size: 90,
                        ),
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                Text(snapshot.data["Name"], style: const TextStyle(fontSize: 24)),
                const Gap(20),
                Column(
                  children: [
                    profileTile("Trip Booking Status", () {
                      DateTime today = DateTime.now();
                      List<String> validTripIds = [];

                      snapshot.data["tripHistory"].where((trip) {
                        DateTime startDate = trip['startDate'].toDate();

                        ///here///////////////////////////////
                        bool isValid =
                            // startDate.isAfter(today)
                            startDate.isAfter(today) ||
                                startDate.isAtSameMomentAs(today);
                        if (isValid) {
                          validTripIds.add(trip['docId'].toString());
                        }
                        return isValid;
                      }).toList();
                      print(validTripIds.toString());
                      Navigator.pushNamed(context, TripBookingStatus.routeName,
                          arguments: validTripIds);
                    }, Icons.bookmark_add_outlined),
                    profileTile("Hosted Trip Requests", () {
                      var hostings = snapshot.data["hostings"];
                      Navigator.pushNamed(context, HostedTripRequest.routeName,
                          arguments: hostings);
                    }, Icons.bookmark_add_outlined),
                    profileTile("Trip History", () {
                      Navigator.pushNamed(context, TripHistoryScreen.routeName,
                          arguments: snapshot.data["tripHistory"]);
                    }, Icons.history),
                    profileTile("Help", () {}, Icons.help_outline),
                    profileTile("Settings", () {
                      Navigator.pushNamed(context, SettingsScreen.routeName,
                          arguments: {
                            "email": snapshot.data["Email"] != null
                                ? snapshot.data["Email"] as String
                                : null,
                            "refreshData": prefresh,
                          });
                    }, Icons.settings),
                    profileTile("Log Out", () {
                      GoogleLogin().logOutFromGoogle(context);
                      SharedPref().LogoutSP();
                    }, Icons.logout),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget profileTile(String text, dynamic onTap, IconData icon) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size!.height / 16,
        width: size?.width,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        decoration: BoxDecoration(
            color: CustomColors.tileColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2, color: CustomColors.shadowColor),
            boxShadow: const [
              BoxShadow(
                  color: CustomColors.shadowColor,
                  blurRadius: 50,
                  spreadRadius: 10),
            ]),
        child: Row(
          children: [
            const Gap(10),
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

  void prefresh() {
    setState(() {});
  }
}
