import 'package:flutter/material.dart';
import './predicted_time_billing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'data/documentIds.dart';
import 'tflitemodels/billing_ann.dart';

class JoinBilling extends StatefulWidget {
  final Widget entireTimer;
  JoinBilling(
    this.entireTimer,
  );
  @override
  _JoinBillingState createState() => _JoinBillingState();
}

class _JoinBillingState extends State<JoinBilling> {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey();
  var billingTime, billingPosition;
  DocumentReference patientId;

  getPosition() async {
    var documentId = await patientId.id;
    var predictedTime;
    var position = 1.0;
    print(documentId);
    final collectionReference =
        FirebaseFirestore.instance.collection('billing');
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

      var model = BillingModel();
      predictedTime = await model.loadModel(position);
    });
    await collectionReference.doc(patientId.id).update({
      'predictedTime': predictedTime,
    });
    billingPosition = position;
    return predictedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text(
          "Join Consultation Billing Queue",
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
              )
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            "CONSULTATION BILLING",
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
              'assets/billing.png',
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
                  'Join Consultation Billing Queue',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  patientId = await FirebaseFirestore.instance
                      .collection('billing')
                      .add({
                    'join_time': DateTime.now().toString(),
                  });
                  var dId = DocumentId();
                  dId.patientIdBilling = patientId.id;
                  billingTime = await getPosition();
                  await Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) {
                    return PredictBilling(
                      billingTime,
                      getPosition,
                      patientId.id,
                      billingPosition,
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
