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
    try {
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
      String tripNameId = trip.host! + uToken.toString();
      if (uToken != -1) {
        var task =
            fs.ref("Trips-pic").child(tripNameId).putFile(trip.pickedImage!);
        trip.setRefId(trip.host! + uToken.toString());
        TaskSnapshot taskSnapshot = await task;
        String link = await taskSnapshot.ref.getDownloadURL();
        trip.imageurl = link;
        ff.collection("trips").doc(tripNameId).set(trip.toMap());
        userColl.update({
          "hostings": FieldValue.arrayUnion([tripNameId])
        });
        userColl.update({"uToken": uToken + 1});
      } else {
        print("trip data not uploaded");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> submitRequest(TripJoinRequest tripReq) async {
    try {
      var documentReference = ff.collection("trips").doc(tripReq.docId);
      var documentSnapshot = await documentReference.get();

      // print("fval$fieldValue");
      if (documentSnapshot.exists) {
        var data = documentSnapshot.data();
        if (data != null) {
          var fieldValue = data['requests'];
          TripHistory tripHistory = TripHistory(
              user: tripReq.email,
              docId: tripReq.docId,
              startDate: data["startDate"],
              membersCount: tripReq.members?.length,
              title: data["title"]);
          if (fieldValue != null) {
            print(data['requests']);
            List<dynamic> existingRequests = data['requests'];
            bool userAlreadyRequested = existingRequests
                .any((request) => request['email'] == tripReq.email);
            print(userAlreadyRequested);
            if (!userAlreadyRequested) {
              await documentReference.update({
                'requests': FieldValue.arrayUnion([tripReq.toMap()]),
              });
              addToUserHistory(tripHistory);
              print("field exits");
            } else {
              print("already requested");
            }
          } else {
            await documentReference.update({
              'requests': [tripReq.toMap()],
            });
            addToUserHistory(tripHistory);
            print("field not exits");
          }
        } else {
          // Document data is null
          print("trip documnet data error null valuew");
        }
      } else {
        print("doc snapshot doesnot exits");
      }
    } catch (e) {
      print("Trip request failed to send $e");
    }
  }

  // Future<void> submitRequest(TripJoinRequest tripReq) async {
  //   try {
  //     var documentReference = ff.collection("trips").doc(tripReq.docId);
  //     var documentSnapshot = await documentReference.get();
  //
  //     // print("fval$fieldValue");
  //     if (documentSnapshot.exists) {
  //       var data = documentSnapshot.data();
  //       if (data != null) {
  //         print(data['requests']);
  //         List<dynamic> existingRequests = data['requests'];
  //         bool userAlreadyRequested = existingRequests
  //             .any((request) => request['email'] == tripReq.email);
  //         print(userAlreadyRequested);
  //         if (!userAlreadyRequested) {
  //           var fieldValue = data['requests'];
  //           TripHistory tripHistory = TripHistory(
  //               user: tripReq.email,
  //               docId: tripReq.docId,
  //               startDate: data["startDate"],
  //               membersCount: tripReq.members?.length);
  //           if (fieldValue != null) {
  //             await documentReference.update({
  //               'requests': FieldValue.arrayUnion([tripReq.toMap()]),
  //             });
  //             // addToUserHistory(tripHistory);
  //             print("field exits");
  //           } else {
  //             await documentReference.update({
  //               'requests': [tripReq.toMap()],
  //             });
  //             // addToUserHistory(tripHistory);
  //             print("field not exits");
  //           }
  //         } else {
  //           print("already requested");
  //         }
  //       } else {
  //         // Document data is null
  //         print("trip documnet data error null valuew");
  //       }
  //     } else {
  //       print("doc snapshot doesnot exits");
  //     }
  //   } catch (e) {
  //     print("Trip request failed to send $e");
  //   }
  // }
  addToUserHistory(TripHistory tripHistory) async {
    try {
      await ff.collection("userData").doc(tripHistory.user).update({
        'tripHistory': FieldValue.arrayUnion([tripHistory.toMap()]),
      });
    } catch (e) {
      print("error in uploading user historu for this trip");
    }
  }
}
