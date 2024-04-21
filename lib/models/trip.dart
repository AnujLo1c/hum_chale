class Trip{
  final String title,price,imageurl,activities,pickUpPoint,host;

//add end date
  final int index;
   List<TravelRoute>? travelRoute;
   List<bool>? lodgings;
   List<bool>? transits;
  Trip( {required this.host,this.lodgings, this.transits,required this.activities, required this.pickUpPoint, this.travelRoute,required this.title, required this.price, required this.imageurl,required this.index});

  void setItinerary(List<TravelRoute>? itineraries) {
    travelRoute=itineraries;
  }
  void setLodgings(List<bool>? lodgings) {
    this.lodgings=lodgings;
  }
  void setTransits(List<bool>? transits) {
    this.transits=transits;
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
}