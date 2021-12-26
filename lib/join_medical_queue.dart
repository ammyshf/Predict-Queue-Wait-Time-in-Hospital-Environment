import 'package:flutter/material.dart';
import './predicted_time_medical.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'data/documentIds.dart';
import 'tflitemodels/medical_ann.dart';

class JoinMedical extends StatefulWidget {
  final Widget entireTimer;

  JoinMedical(this.entireTimer);
  @override
  _JoinMedicalState createState() => _JoinMedicalState();
}

class _JoinMedicalState extends State<JoinMedical> {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey();
  var medicalTime, pharmacyPosition;
  DocumentReference patientId;
  getPosition() async {
    var documentId = patientId.id;
    var predictedTime;
    var position = 1.0;
    final collectionReference =
        FirebaseFirestore.instance.collection('pharmacy');
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
      var model = MedicalModel();
      predictedTime = await model.loadModel(position);
    });
    await collectionReference.doc(patientId.id).update({
      'predictedTime': predictedTime,
    });
    pharmacyPosition = position;
    return predictedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text(
          "Join Pharmacy Queue",
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
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
            height: 50,
          ),
          Text(
            "PHARMACY",
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
              'assets/medical.jpg',
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
                  'Join Pharmacy Queue',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  patientId = await FirebaseFirestore.instance
                      .collection('pharmacy')
                      .add({
                    'join_time': DateTime.now().toString(),
                  });
                  var dId = DocumentId();
                  dId.patientIdPharmacy = patientId.id;
                  medicalTime = await getPosition();
                  await Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) {
                    return PredictMedical(
                      medicalTime,
                      getPosition,
                      patientId.id,
                      pharmacyPosition,
                      widget.entireTimer,
                    );
                  }));
                }),
          ),
        ],
      ),
    );
  }
}
