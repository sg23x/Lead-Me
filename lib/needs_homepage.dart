import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lead_me/query_card.dart';

class NeedsHomePage extends StatelessWidget {
  NeedsHomePage({
    this.city,
    this.leadType,
  });
  String leadType;
  String city;

  List leadDocs = [];

  FirebaseFirestore fb = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('$leadType in $city'),
      ),
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: StreamBuilder(
          stream:
              fb.collection('leads').doc(leadType).collection(city).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return SizedBox();
            }

            leadDocs = snapshot.data.docs;

            return leadDocs.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (context, i) {
                      return QueryCard(
                        address: leadDocs[i]['address'],
                        isVerified: leadDocs[i]['isVerified'],
                        comments: leadDocs[i]['comments'],
                        contact: leadDocs[i]['contact'],
                        leadType: leadDocs[i]['leadType'],
                        city: leadDocs[i]['city'],
                        name: leadDocs[i]['name'],
                        timeAgo: DateTime.fromMicrosecondsSinceEpoch(
                            int.parse(leadDocs[i].id)),
                      );
                    },
                    itemCount: leadDocs.length,
                    shrinkWrap: true,
                  )
                : Center(
                    child: Text(
                      'Nothing here!',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
          }),
    );
  }
}
