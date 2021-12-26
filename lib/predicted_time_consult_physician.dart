import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pqt_fourth/data/documentIds.dart';
import 'package:pqt_fourth/join_billing_queue.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';

import 'home_page.dart';

// ignore: must_be_immutable
class PredictConsultationPhysician extends StatefulWidget {
  var physicianTime, physicianPosition, sum;
  final Function getPositionPhysician;
  final documentId;
  final Widget entireTimer;
  PredictConsultationPhysician(
    this.physicianTime,
    this.physicianPosition,
    this.getPositionPhysician,
    this.sum,
    this.documentId,
    this.entireTimer,
  );
  @override
  _PredictConsultationPhysicianState createState() =>
      _PredictConsultationPhysicianState();
}

class _PredictConsultationPhysicianState
    extends State<PredictConsultationPhysician> {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey();
  Future refresh() async {
    await Future.delayed(Duration(seconds: 2));
    widget.physicianTime = await widget.getPositionPhysician();
    setState(() {});
    return build;
  }

  var dId = DocumentId();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldState,
        appBar: AppBar(
          title: Text(
            "Consultation Queue",
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          backgroundColor: Colors.lightBlue,
        ),
        body: RefreshIndicator(
          onRefresh: refresh,
          child: ListView(children: [
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
                    )
                  ],
                ),
                SizedBox(
                  height: 80,
                ),
                Text(
                  "Time until you reach the Physician\'s desk",
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
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 20,
                  color: Colors.white,
                  child: Container(
                    alignment: Alignment.center,
                    width: 200,
                    height: 200,
                    child: SlideCountdownClock(
                      duration: Duration(
                        minutes: widget.sum,
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
                                child: Text('Dismiss'),
                                onPressed: () async {
                                  Navigator.of(context).pop();
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
                  color: Colors.green,
                  child: Text(
                    'Move Towards Consultation Billing',
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
                              await FirebaseFirestore.instance
                                  .collection('physician')
                                  .doc(widget.documentId)
                                  .delete();

                              Navigator.of(context).pop();

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => JoinBilling(
                                          widget.entireTimer,
                                        )),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
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
                              await FirebaseFirestore.instance
                                  .collection('physician')
                                  .doc(widget.documentId)
                                  .delete();

                              await FirebaseFirestore.instance
                                  .collection('entireJourney')
                                  .doc(dId.patientIdEntire)
                                  .delete();

                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (_) {
                                return HomePage();
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
          ]),
        ));
  }
}
