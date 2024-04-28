import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class Trip {
  final String title, price, activities, pickUpPoint;
  final File? pickedImage;
  final DateTime startDate, endDate;
  final String? host;
  final int index;
  String imageurl;
  String? refId;
  List<TravelRoute>? travelRoute;
  List<bool>? lodgings;
  List<bool>? transits;
  List<String>? locations;

  Trip(
      {this.refId,
      this.locations,
      required this.startDate,
      required this.pickedImage,
      required this.endDate,
      required this.host,
      this.lodgings,
      this.transits,
      required this.activities,
      required this.pickUpPoint,
      this.travelRoute,
      required this.title,
      required this.price,
      required this.imageurl,
      required this.index});

  void setItinerary(List<TravelRoute>? itineraries) {
    travelRoute = itineraries;
  }

  void setLodgings(List<bool>? lodgings) {
    this.lodgings = lodgings;
  }

  void setTransits(List<bool>? transits) {
    this.transits = transits;
  }

  void setLocations(List<String>? locations) {
    this.locations = locations;
  }

  void setRefId(String id) {
    refId = id;
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'price': price,
      'imageUrl': imageurl,
      'activities': activities,
      'pickUpPoint': pickUpPoint,
      'host': host,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'index': index,
      'travelRoute': travelRoute?.map((route) => route.toMap()).toList(),
      'lodgings': lodgings,
      'transits': transits,
      'locations': locations,
      'refId': refId,
    };
  }

  factory Trip.fromSnapshot(DocumentSnapshot<Object?> snapshot) {
    return Trip(
      title: snapshot['title'] as String,
      price: snapshot['price'] as String,
      activities: snapshot['activities'] as String,
      pickUpPoint: snapshot['pickUpPoint'] as String,
      startDate: (snapshot['startDate'] as Timestamp).toDate(),
      endDate: (snapshot['endDate'] as Timestamp).toDate(),
      index: snapshot['index'] as int,
      host: snapshot['host'] as String?, // Assuming 'host' is nullable
      pickedImage: null,
      imageurl: snapshot['imageUrl'] as String,
      locations: List<String>.from(snapshot['locations'] ?? []),
      refId: snapshot['refId'] as String?,
    );
  }
}

class TravelRoute {
  final String start, dest, time;
  final DateTime? date;
  TravelRoute(
      {required this.start,
      required this.dest,
      required this.time,
      required this.date});
  Map<String, dynamic> toMap() {
    return {
      'start': start,
      'dest': dest,
      'time': time,
      'date': date != null ? Timestamp.fromDate(date!) : null,
    };
  }
}

class TripJoinRequest {
  //
  final String phone, docId, email, name;
  String status = 'P';
  List<String>? members;

  TripJoinRequest(
      {required this.phone,
      required this.docId,
      required this.email,
      this.members,
      required this.name});

  changeStatus(String status) {
    this.status = status;
  }

  setMembers(List<String> m) {
    members = m;
  }

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'docId': docId,
      'email': email,
      'members': members,
      'name': name,
      'status': status,
    };
  }
}

class TripHistory {
  final String docId, user, title;
  String? status = 'P';
  final Timestamp startDate;
  int? membersCount;

  TripHistory(
      {required this.user,
      this.status,
      this.membersCount,
      required this.docId,
      required this.startDate,
      required this.title});

  changeStatus(String status) {
    this.status = status;
  }

  setMembers(int m) {
    membersCount = m;
  }

  Map<String, dynamic> toMap() {
    return {
      'docId': docId,
      'status': status,
      'startDate': startDate,
      'membersCount': membersCount,
      'user': user,
      'title': title
    };
  }
}
