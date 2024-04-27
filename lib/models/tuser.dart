import 'package:hum_chale/models/trip.dart';

class Tuser{
final String fullName,phoneNo,email;
 String? url;
final int age;
final int uToken=0;
  List<String>? hostings = [];
  List<TripHistory>? tripHistory = <TripHistory>[];

  Tuser(
    {this.tripHistory, this.hostings, required this.fullName, required this.phoneNo, required this.email, this.url, required this.age});
}