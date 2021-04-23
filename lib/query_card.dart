import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class QueryCard extends StatelessWidget {
  QueryCard({
    this.address,
    this.city,
    this.comments,
    this.contact,
    this.leadType,
    this.name,
    this.isVerified,
    this.timeAgo,
  });
  String leadType;
  String city;
  String name;
  String contact;
  String address;
  String comments;
  bool isVerified;
  DateTime timeAgo;
  @override
  Widget build(BuildContext context) {
    return isVerified
        ? Banner(
            location: BannerLocation.topEnd,
            message: "Verified",
            color: Colors.green,
            child: CardContent(
              name: this.name,
              address: this.address,
              city: this.city,
              comments: this.comments,
              contact: this.contact,
              leadType: this.leadType,
              timeAgo: this.timeAgo,
            ),
          )
        : CardContent(
            name: this.name,
            address: this.address,
            city: this.city,
            comments: this.comments,
            contact: this.contact,
            leadType: this.leadType,
            timeAgo: this.timeAgo,
          );
  }
}

class CardContent extends StatelessWidget {
  CardContent({
    this.address,
    this.city,
    this.comments,
    this.contact,
    this.leadType,
    this.name,
    this.timeAgo,
  });
  String leadType;
  String city;
  String name;
  String contact;
  String address;
  String comments;
  DateTime timeAgo;
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.all(10),
      width: _width * 0.95,
      height: _height * 0.2,
      color: Colors.white,
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('city: $city'),
          Text('requirement: $leadType'),
          Text('name: $name'),
          Text('contact: $contact'),
          Text('address: $address'),
          Text('comments: $comments'),
          Text('time ago: ' + timeago.format(timeAgo, locale: 'en_short')),
        ],
      ),
    );
  }
}
