import 'package:cloud_firestore/cloud_firestore.dart';

class Trip{
  final String title,price,imageurl,activities,pickUpPoint,host;
  final DateTime startDate,endDate;

  final int index;
   List<TravelRoute>? travelRoute;
   List<bool>? lodgings;
   List<bool>? transits;
  Trip(  {required this.startDate, required this.endDate, required this.host,this.lodgings, this.transits,required this.activities, required this.pickUpPoint, this.travelRoute,required this.title, required this.price, required this.imageurl,required this.index});

  void setItinerary(List<TravelRoute>? itineraries) {
    travelRoute=itineraries;
  }
  void setLodgings(List<bool>? lodgings) {
    this.lodgings=lodgings;
  }
  void setTransits(List<bool>? transits) {
    this.transits=transits;
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
    };
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