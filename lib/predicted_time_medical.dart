import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pqt_fourth/data/documentIds.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';

import 'message.dart';

// ignore: must_be_immutable
class PredictMedical extends StatefulWidget {
  int displayOutput;
  final Function getPosition;
  final documentId;
  var pharmacyPosition;
  final Widget entireTimer;

  PredictMedical(
    this.displayOutput,
    this.getPosition,
    this.documentId,
    this.pharmacyPosition,
    this.entireTimer,
  );

  @override
  _PredictMedicalState createState() => _PredictMedicalState();
}

class _PredictMedicalState extends State<PredictMedical> {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey();
  var dId = DocumentId();

  Future refresh() async {
    await Future.delayed(Duration(seconds: 2));
    widget.displayOutput = await widget.getPosition();
    setState(() {});
    return build;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text(
          "Pharmacy Queue",
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: RefreshIndicator(
        child: ListView(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Image.asset(
                        'assets/queue.jpg',
                        fit: BoxFit.cover,
                      ),
                      width: 160,
                      height: 105,
                    ),
                    SizedBox(
                      width: 14.7,
                    ),
                    Card(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(
                              'Your Hospital Journey ends in:',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            widget.entireTimer,
                          ],
                        ),
                        width: 200,
                        height: 105,
                      ),
                      color: Colors.white,
                      elevation: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 80,
                ),
                Text(
                  "Time until you reach the Pharmacists' desk",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                Card(
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    alignment: Alignment.center,
                    // padding: EdgeInsets.all(35),
                    width: 200,
                    height: 200,
                    child: SlideCountdownClock(
                      duration: Duration(
                        minutes: widget.pharmacyPosition != 1.0
                            ? widget.displayOutput
                            : 0,
                      ),
                      slideDirection: SlideDirection.Down,
                      separator: ':',
                      textStyle: TextStyle(
                        fontSize: 25,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                      onDone: () {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text('Timer is Over'),
                            content:
                                Text('Hope we predicted your journey right :)'),
                            actions: [
                              FlatButton(
                                child: Text('Done'),
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection('pharmacy')
                                      .doc(dId.patientIdPharmacy)
                                      .delete();

                                  await FirebaseFirestore.instance
                                      .collection('entireJourney')
                                      .doc(dId.patientIdEntire)
                                      .delete();

                                  Navigator.of(context).pop();

                                  await Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (_) {
                                    return Message();
                                  }));
                                },
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                RaisedButton(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.red,
                  child: Text(
                    'Quit Service',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('Leaving?'),
                        content:
                            Text('Are you sure you want to quit the queue?'),
                        actions: [
                          FlatButton(
                            child: Text(
                              'No',
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          FlatButton(
                            child: Text('Yes'),
                            onPressed: () async {
                              Navigator.of(context).pop();

                              await FirebaseFirestore.instance
                                  .collection('pharmacy')
                                  .doc(widget.documentId)
                                  .delete();

                              await FirebaseFirestore.instance
                                  .collection('entireJourney')
                                  .doc(dId.patientIdEntire)
                                  .delete();

                              await Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (_) {
                                return Message();
                              }));
                            },
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        onRefresh: refresh,
      ),
    );
  }
}
