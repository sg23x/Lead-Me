import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lead_me/leads_form_page.dart';
import 'package:lead_me/needs_homepage.dart';
import "package:collection/collection.dart";

class LeadsOrNeeds extends StatefulWidget {
  @override
  _LeadsOrNeedsState createState() => _LeadsOrNeedsState();
}

class _LeadsOrNeedsState extends State<LeadsOrNeeds> {
  String _leadTypeDropdownValue;
  String _leadLocationDropdownValue;

  String leadType;
  String city;

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
                onPressed: () {
                  showDialog(
                    context: context,
                    child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        bool _dummyBoolForSorting = true;
                        List _citiesList = [];
                        return AlertDialog(
                          content: StreamBuilder(
                            builder: (context, typesnap) {
                              if (!typesnap.hasData) {
                                return SizedBox();
                              }
                              if (_dummyBoolForSorting) {
                                _citiesList =
                                    typesnap.data.docs[0].data()['cities'];
                                _citiesList.sort((a, b) {
                                  return compareAsciiUpperCase(a, b);
                                });
                                _dummyBoolForSorting = false;
                              }

                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  DropdownButton(
                                      hint: Text('Need type'),
                                      value: _leadTypeDropdownValue,
                                      items: typesnap.data.docs[1]
                                          .data()['leadTypes']
                                          .map<DropdownMenuItem<String>>(
                                              (value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        setState(() {
                                          _leadTypeDropdownValue = val;
                                        });
                                      }),
                                  DropdownButton(
                                      hint: Text('Location'),
                                      value: _leadLocationDropdownValue,
                                      items: _citiesList
                                          .map<DropdownMenuItem<String>>(
                                              (value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        setState(() {
                                          _leadLocationDropdownValue = val;
                                        });
                                      }),
                                ],
                              );
                            },
                            stream: FirebaseFirestore.instance
                                .collection('metadata')
                                .snapshots(),
                          ),
                          actions: [
                            FlatButton(
                              onPressed: _leadLocationDropdownValue == null ||
                                      _leadTypeDropdownValue == null
                                  ? null
                                  : () {
                                      setState(() {
                                        city = _leadLocationDropdownValue;
                                        leadType = _leadTypeDropdownValue;
                                      });
                                      Navigator.of(context).pop();
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              NeedsHomePage(
                                            city: this.city,
                                            leadType: this.leadType,
                                          ),
                                        ),
                                      );
                                    },
                              child: Text(
                                'Find leads',
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ).then(
                    (v) {
                      setState(
                        () {
                          _leadLocationDropdownValue = null;
                          _leadTypeDropdownValue = null;
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
