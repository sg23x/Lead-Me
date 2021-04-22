import 'package:flutter/material.dart';
import 'package:lead_me/leads_form_page.dart';

class LeadsOrNeeds extends StatefulWidget {
  @override
  _LeadsOrNeedsState createState() => _LeadsOrNeedsState();
}

class _LeadsOrNeedsState extends State<LeadsOrNeeds> {
  String countryValue;
  String stateValue;
  String cityValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                child: Text("i got leads"),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => LeadsFormPage()));
                },
              ),
              RaisedButton(
                child: Text("i am in need"),
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
