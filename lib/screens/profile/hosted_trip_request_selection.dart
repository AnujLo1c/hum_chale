import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hum_chale/models/trip.dart';
import 'package:hum_chale/ui/CustomColors.dart';
import 'package:hum_chale/widget/CustomAppBar.dart';
import 'package:hum_chale/widget/custom_snackbar.dart';

class HostedTRSelection extends StatefulWidget {
  static String routeName = "hosted-trip-request-selection";
  final String id;

  const HostedTRSelection({super.key, required this.id});

  @override
  State<HostedTRSelection> createState() => _HostedTRSelectionState();
}

class _HostedTRSelectionState extends State<HostedTRSelection> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(text: "Requests"),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("trips")
              .doc(widget.id)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Show a loading indicator while data is being fetched
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData) {
              return const Center(
                child: Text('Document does not exist'),
              ); // Handle the case where the document does not exist
            }
            final data = snapshot.data!.data();
            if (data!['requests'] == null) {
              return const Center(child: Text("No-one requested to join"));
            }
            var req = data['requests'];
            return
                // Text(data['requests'][0]["email"]);
                Column(
              children: [
                Expanded(
                    child: ListView.builder(
                  itemCount: req.length,
                  itemBuilder: (context, index) =>
                      requestTile(index, req[index]),
                ))
              ],
            );
          },
        ),
      ),
    );
  }

  requestTile(index, request) {
    var status = request["status"];
    // double a = 18.0, b = 20;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
          color: status == 'R'
              ? Colors.redAccent
              : (status == 'C')
                  ? Colors.greenAccent.shade200
                  : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: CustomColors.primaryColor)),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                "Seeker: ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              Text(
                request["name"].toString().split('#')[0],
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                "Total no. of Members: ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              Text(
                request["members"].length.toString(),
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
              )
            ],
          ),
          status == 'A'
              ? Row(
                  children: [
                    const Text("Email: ",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400)),
                    Expanded(
                      child: Text(request["email"],
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600)),
                    )
                  ],
                )
              : const Gap(1),
          status == 'A'
              ? Row(
                  children: [
                    const Text("Phone: ",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400)),
                    Text(request["phone"],
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w600))
                  ],
                )
              : const Gap(1),
          const Gap(10),
          status == 'P'
              ? Row(
                  children: [
                    SizedBox(
                      height: 35,
                      width: MediaQuery.of(context).size.width / 2 - 50,
                      child: ElevatedButton(
                        onPressed: () {
                          updateRequestStatus(
                              request["docId"], request["email"], 'R');
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF46A82),
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 2, color: Colors.black54),
                                borderRadius: BorderRadius.circular(10))),
                        child: const Text(
                          "Reject",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 35,
                      width: MediaQuery.of(context).size.width / 2 - 45,
                      child: ElevatedButton(
                        onPressed: () {
                          updateRequestStatus(
                              request["docId"], request["email"], 'A');
                          // updateTripHistoryStatus(
                          //     request["email"], request["docId"], 'A');
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE3FD7E),
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 2, color: Colors.black54),
                                borderRadius: BorderRadius.circular(10))),
                        child: const Text(
                          "Approve",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    )
                  ],
                )
              : const Gap(1),
          status == 'A'
              ? SizedBox(
                  height: 35,
                  width: MediaQuery.of(context).size.width - 70,
                  child: ElevatedButton(
                    onPressed: () {
                      // updateRequestStatus(
                      //     request["docId"], request["email"], 'C');
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text(
                            "Contacted?",
                            style: TextStyle(fontSize: 22),
                          ),
                          content: const Text(
                            "Have you contacted by email or Phone no.",
                          ),
                          contentTextStyle: const TextStyle(
                              fontSize: 18, color: Colors.black),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("No")),
                            TextButton(
                                onPressed: () {
                                  updateRequestStatus(
                                      request["docId"], request["email"], 'C');
                                  Navigator.pop(context);
                                },
                                child: const Text("Yes")),
                          ],
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF92FF9D),
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 2, color: Colors.black54),
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text(
                      "Confirm",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                )
              : const Gap(1),
        ],
      ),
    );
  }

  Future<void> updateRequestStatus(
      String tripDocumentId, String email, String newStatus) async {
    // Reference to the document containing the trip data
    DocumentReference documentRef =
        FirebaseFirestore.instance.collection('trips').doc(tripDocumentId);
    bool check = false;

    // Fetch the document
    await documentRef.get().then((documentSnapshot) {
      if (documentSnapshot.exists) {
        // Extract the requests list from the document
        List<dynamic>? requests =
            (documentSnapshot.data() as Map<String, dynamic>)['requests'];

        // Iterate through the requests list
        if (requests != null) {
          for (int i = 0; i < requests.length; i++) {
            Map<String, dynamic> request = requests[i] as Map<String, dynamic>;

            // Check if the email matches
            if (request['email'] == email) {
              // Update the status field of the matched request
              request['status'] = newStatus;

              // Update the requests list in the document
              requests[i] = request;
              check = true; // Set check to true to indicate match found

              // Update the document in Firestore with the modified requests list
              documentRef.update({
                'requests': requests,
              }).then((_) {
                ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar()
                    .customSnackbar(
                        1, "Status changed", "User new status set"));
              }).catchError((error) {
                ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar()
                    .customSnackbar(3, "Empty Field",
                        "Failed to update request status: $error"));
              });
              updateTripHistoryStatus(email, tripDocumentId, newStatus);
              break;
            }
          }
        } else {
          print("Document data is null or 'requests' field is missing.");
        }
      } else {
        print("Document does not exist.");
      }

      if (!check) {
        print("Email not found in requests list.");
      }
    }).catchError((error) {
      print("Failed to fetch document: $error");
    });
  }

  Future<void> updateTripHistoryStatus(
      String email, String tripId, String newStatus) async {
    DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('userData').doc(email);

    await userDocRef.get().then((documentSnapshot) {
      if (documentSnapshot.exists) {
        List<dynamic>? tripHistory =
            (documentSnapshot.data() as Map<String, dynamic>)['tripHistory'];
        if (tripHistory != null) {
          for (int i = 0; i < tripHistory.length; i++) {
            Map<String, dynamic> trip =
                (tripHistory[i] as Map<String, dynamic>);
            if (trip['docId'] == tripId) {
              trip['status'] = newStatus;

              tripHistory[i] = trip;
              userDocRef.update({
                'tripHistory': tripHistory,
              }).then((_) {
                print("Trip history status updated successfully!");
              }).catchError((error) {
                ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar()
                    .customSnackbar(3, "Empty Field",
                        "Failed to update trip history status: $error"));
              });

              break;
            } else {
              print("not equal");
            }
          }
        } else {
          print("tripHistory is null or missing in the document.");
        }
      } else {
        print("Document does not exist for email: $email");
      }
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar()
          .customSnackbar(
              3, "Empty Field", "Failed to fetch document: $error"));
      // print("Failed to fetch document: $error");
    });
  }
}