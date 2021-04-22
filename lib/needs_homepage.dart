import 'package:flutter/material.dart';
import 'package:lead_me/query_card.dart';

class NeedsHomePage extends StatelessWidget {
  NeedsHomePage({
    this.city,
    this.leadType,
  });
  String leadType;
  String city;

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
      body: Column(
        children: [
          QueryCard(
            name: 'Sarthak',
            address: '420/69',
            city: 'Faridabad',
            comments: 'covid sucks',
            contact: '9723859036',
            leadType: 'Plasma',
            isVerified: true,
          ),
          QueryCard(
            name: 'Jasmine',
            address: 'wef',
            city: 'ewfwe',
            comments: 'wef',
            contact: '9288377489',
            leadType: 'fPlaefesmafe',
            isVerified: false,
          ),
          QueryCard(
            name: 'Seefarthwef',
            address: 'wef',
            city: 'Faridabad',
            comments: 'wefwfwefwefs',
            contact: '99999999420',
            leadType: 'wefwf',
            isVerified: true,
          ),
        ],
      ),
    );
  }
}
