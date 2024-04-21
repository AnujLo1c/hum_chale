import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hum_chale/models/trip.dart';

class tripFirestore {
  var ff = FirebaseFirestore.instance;
  var fs = FirebaseStorage.instance;
  var fa = FirebaseAuth.instance;
  String timestampToString(Timestamp timestamp) {
    // Convert Timestamp to DateTime
    DateTime dateTime = timestamp.toDate();

    // Extract year, month, and day
    int year = dateTime.year;
    int month = dateTime.month;
    int day = dateTime.day;

    // Format the string
    String formattedString =
        '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

    return formattedString;
  }

  Future<List<DocumentSnapshot>> fetchTripsFromFirestore() async {
    // Reference to the trips collection
    CollectionReference tripsRef =
        FirebaseFirestore.instance.collection('trips');

    // Get the current timestamp
    String now = timestampToString(Timestamp.now());

    try {
      // Query trips where startDate is greater than now
      QuerySnapshot querySnapshot =
          await tripsRef.where('date', isGreaterThan: now).get();

      // Return the list of trip documents
      for (var doc in querySnapshot.docs) {
        // Access data from each document
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // Now you can work with the data
        // String documentId = doc.id; // Get the document ID
        // String fieldValue = data['field']; // Access a specific field
        // Do something with the data
        // print('Document ID: $documentId, Field Value: $fieldValue');
        print(data.toString());
      }
      return querySnapshot.docs;
    } catch (e) {
      // Handle any errors
      print('Error fetching trips: $e');
      return [];
    }
  }

  createTrip(Trip trip) async {
    var userColl = ff.collection("userData").doc(trip.host);
    // ff.collection("userData").doc(user.email)
    var uToken = await userColl.get().then((doc) {
      // print(doc.data());
      if (doc.exists) {
        return doc.data()?["uToken"];
      } else {
        return -1;
      }
    });

    if (uToken != -1) {
      var task=fs.ref("Trips-pic").child(trip.host!+uToken.toString()).putFile(trip.pickedImage!);
      TaskSnapshot taskSnapshot=await task;
      String link=await taskSnapshot.ref.getDownloadURL();
      trip.imageurl=link;
      ff.collection("trips")
          .doc(trip.host! + uToken.toString())
          .set(trip.toMap());
      userColl.update({"uToken": uToken + 1});
    } else {
      print("trip data not uploaded");
    }
  }
}
