import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:collection/collection.dart";

class LeadsFormPage extends StatefulWidget {
  @override
  _LeadsFormPageState createState() => _LeadsFormPageState();
}

class _LeadsFormPageState extends State<LeadsFormPage> {
  String _leadTypeDropdownValue;
  String _leadLocationDropdownValue;
  bool _isVerified = false;
  List<DropdownMenuItem<String>> _othersDropdownList = [
    DropdownMenuItem(
      child: Text(
        "Can't find your city?",
        style: TextStyle(
          color: Colors.red,
        ),
      ),
      value: "others",
    ),
  ];

  String city;

  String _nameOfProvider;
  String _contactOfProvider;
  String _addressOfProvider;
  String _comments;
  String _cityTyped;

  bool _dummyBoolForSorting = true;
  bool _dummyBoolForLoadingLeadType = true;
  List _citiesList = [];
  List _leadTypeList = [];

  FirebaseFirestore fb = FirebaseFirestore.instance;

  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: fb.collection('metadata').doc('cities').snapshots(),
      builder: (context, citiessnap) {
        if (!citiessnap.hasData) {
          return Scaffold();
        }

        if (_dummyBoolForSorting) {
          _citiesList = citiessnap.data.data()['cities'];
          _citiesList.sort((a, b) {
            return compareAsciiUpperCase(a, b);
          });
          _dummyBoolForSorting = false;
        }

        return Scaffold(
          resizeToAvoidBottomInset: false,
          resizeToAvoidBottomPadding: false,
          body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder(
                      builder: (context, typesnap) {
                        if (!typesnap.hasData) {
                          return SizedBox();
                        }

                        if (_dummyBoolForLoadingLeadType) {
                          _leadTypeList = typesnap.data.data()['leadTypes'];
                          _dummyBoolForLoadingLeadType = false;
                        }

                        return DropdownButton(
                            hint: Text('Lead type'),
                            value: _leadTypeDropdownValue,
                            items: _leadTypeList
                                .map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(color: Colors.black),
                                ),
                              );
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                _leadTypeDropdownValue = val;
                              });
                            });
                      },
                      stream: fb
                          .collection('metadata')
                          .doc('leadTypes')
                          .snapshots()),
                  DropdownButton(
                      hint: Text('Location'),
                      value: _leadLocationDropdownValue,
                      items: _othersDropdownList +
                          _citiesList.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                      onChanged: (val) {
                        setState(() {
                          _leadLocationDropdownValue = val;
                        });
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '*You can leave the fields blank if you\'re not sure*',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  _leadLocationDropdownValue == 'others'
                      ? Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: TextField(
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              labelText: 'City',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onChanged: (val) {
                              _cityTyped = val;
                            },
                          ),
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        labelText: 'Name of provider',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (val) {
                        _nameOfProvider = val;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      keyboardType: TextInputType.numberWithOptions(),
                      decoration: InputDecoration(
                        labelText: 'Contact number of provider',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (val) {
                        _contactOfProvider = val;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        labelText: 'Address of provider',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (val) {
                        _addressOfProvider = val;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        labelText: 'Comments (optional)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (val) {
                        _comments = val;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          'Have you personally verified this source?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 35,
                                    child: Radio(
                                      value: true,
                                      groupValue: _isVerified,
                                      onChanged: (value) {
                                        setState(() {
                                          _isVerified = value;
                                        });
                                      },
                                    ),
                                  ),
                                  Text(
                                    'yes',
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 35,
                                    child: Radio(
                                      value: false,
                                      groupValue: _isVerified,
                                      onChanged: (value) {
                                        setState(() {
                                          _isVerified = value;
                                        });
                                      },
                                    ),
                                  ),
                                  Text('no'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                    onPressed: (_leadTypeDropdownValue == null) ||
                            (_leadLocationDropdownValue == null) ||
                            ((_nameOfProvider == null ||
                                    _nameOfProvider == "") &&
                                (_contactOfProvider == null ||
                                    _contactOfProvider == "") &&
                                (_addressOfProvider == null ||
                                    _addressOfProvider == "") &&
                                (_comments == null || _comments == ""))
                        ? null
                        : () {
                            if (_leadLocationDropdownValue != "others") {
                              setState(() {
                                city = _leadLocationDropdownValue;
                              });
                            } else {
                              if (citiessnap.data
                                  .data()['cities']
                                  .where((element) =>
                                      element.toLowerCase().trim() ==
                                      _cityTyped.toLowerCase().trim())
                                  .isEmpty) {
                                city = _cityTyped;
                                fb.collection('metadata').doc('cities').update(
                                  {
                                    'cities':
                                        FieldValue.arrayUnion([city.trim()]),
                                  },
                                );
                              } else {
                                city = citiessnap.data
                                    .data()['cities']
                                    .where((element) =>
                                        element.toLowerCase().trim() ==
                                        _cityTyped)
                                    .toList()[0];
                              }
                            }

                            fb
                                .collection('leads')
                                .doc(_leadTypeDropdownValue)
                                .collection(city)
                                .doc(DateTime.now()
                                    .microsecondsSinceEpoch
                                    .toString())
                                .set({
                              'leadType': _leadTypeDropdownValue,
                              'city': city,
                              'name': _nameOfProvider,
                              'contact': _contactOfProvider,
                              'address': _addressOfProvider,
                              'comments': _comments,
                              'isVerified': _isVerified,
                            });

                            Navigator.of(context).pop();
                            showDialog(
                              context: context,
                              child: AlertDialog(
                                content: Text('Thank You'),
                              ),
                            );
                          },
                    child: Text("Submit"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
