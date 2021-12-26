import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pqt_fourth/data/documentIds.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';
import 'data/keys.dart';
import 'predicted_time_registration.dart';
import 'tflitemodels/registration_ann.dart';

class JoinRegistration extends StatefulWidget {
  final doctorChosen,
      pDiagnosisChosen,
      gDiagnosisChosen,
      cDiagnosisChosen,
      pedDiagnosisChosen,
      entireJourney,
      patientIdEntire;

  JoinRegistration(
    this.doctorChosen,
    this.pDiagnosisChosen,
    this.gDiagnosisChosen,
    this.cDiagnosisChosen,
    this.pedDiagnosisChosen,
    this.entireJourney,
    this.patientIdEntire,
  );
  @override
  _JoinRegistrationState createState() => _JoinRegistrationState();
}

class _JoinRegistrationState extends State<JoinRegistration> {
  // GlobalKey<SlideCountdownClockState> _countDownState = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey();
  GlobalKey _columnKey = GlobalKey();

  var registrationTime, registrationPosition;

  DocumentReference patientId;

  getPosition() async {
    var documentId = await patientId.id;
    var predictedTime;
    var position = 1.0;
    print(documentId);
    final collectionReference =
        FirebaseFirestore.instance.collection('registration');
    await collectionReference
        .orderBy('join_time')
        .get()
        .then((QuerySnapshot snapshot) async {
      snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
        if (documentId != documentSnapshot.id) {
          position = position + 1;
        } else {
          print('Final position of patient: $position');
        }
      });
      var model = RegistrationModel();
      predictedTime = await model.loadModel(position);
    });
    await collectionReference.doc(patientId.id).update({
      'predictedTime': predictedTime,
    });
    registrationPosition = position;
    return predictedTime;
  }

  Widget entireTimer() {
    return SlideCountdownClock(
      key: TimerKeys.timerKeys,
      duration: Duration(
        minutes: widget.entireJourney,
      ),
      slideDirection: SlideDirection.Down,
      separator: ':',
      textStyle: TextStyle(
        fontSize: 17,
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text(
          "Join Queue",
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        key: _columnKey,
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      entireTimer(),
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
            height: 50,
          ),
          Text(
            "REGISTRATION",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            child: Image.asset(
              'assets/registration.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.blue,
              child: Text(
                'Join Registration Queue',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                patientId = await FirebaseFirestore.instance
                    .collection('registration')
                    .add({
                  'join_time': DateTime.now().toString(),
                });
                var dId = DocumentId();
                dId.patientIdRegistration = patientId.id;
                registrationTime = await getPosition();

                await Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) {
                  return PredictRegistration(
                    registrationTime,
                    getPosition,
                    widget.doctorChosen,
                    widget.pDiagnosisChosen,
                    widget.gDiagnosisChosen,
                    widget.cDiagnosisChosen,
                    widget.pedDiagnosisChosen,
                    patientId.id,
                    registrationPosition,
                    // _countDownState,
                    entireTimer(),
                    widget.patientIdEntire,
                  );
                }));
              },
            ),
          ),
        ],
      ),
    );
  }
}
