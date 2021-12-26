import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pqt_fourth/data/documentIds.dart';
import 'package:pqt_fourth/entire_journey.dart';

import 'data/formscreen_data.dart';
import 'join_registration_queue.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey();
  DocumentReference patientIdEntire;
  var positionEJ;
  int entireJourney;

  final doctorsListReference =
      FirebaseFirestore.instance.collection('doctorsList');
  var formScreenData = Data();
  var doctorChosen,
      pDiagnosisChosen,
      gDiagnosisChosen,
      cDiagnosisChosen,
      pedDiagnosisChosen;

  getPositionEntire() async {
    var documentId = await patientIdEntire.id;
    var position = 1.0;
    print(documentId);
    final collectionReference =
        FirebaseFirestore.instance.collection('entireJourney');
    await collectionReference
        .orderBy('join_time')
        .get()
        .then((QuerySnapshot snapshot) async {
      snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
        if (documentId != documentSnapshot.id) {
          position = position + 1;
        } else {
          print('Final position of patient in Entire Journey: $position');
        }
      });
    });
    return position;
  }

  @override
  Widget build(BuildContext context) {
    List doctors = formScreenData.doctors;
    List physicianDiagnosis = formScreenData.physicanDiagnosis;
    List cardiologistDiagnosis = formScreenData.cardiologistDiagnosis;
    List gynaecDiagnosis = formScreenData.gynaecDiagnosis;
    List pediatricDiagnosis = formScreenData.pediatricDagnosis;
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text('Appointment Information'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            borderOnForeground: true,
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: DropdownButtonFormField(
              items: doctors.map((doctor) {
                return DropdownMenuItem(
                  value: doctor,
                  child: Text(
                    '\t\t$doctor',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  doctorChosen = value;
                });
              },
              hint: Text(
                '\t\tChoose your Consulting Doctor',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              isExpanded: false,
            ),
          ), //Doctor's Dropdown
          SizedBox(
            height: 50,
          ),
          Card(
            borderOnForeground: true,
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: doctorChosen == 'Dr. Saiqa Khan (Physician)'
                ? DropdownButtonFormField(
                    value: pDiagnosisChosen,
                    items: physicianDiagnosis.map((diagnosis) {
                      return DropdownMenuItem(
                        value: diagnosis,
                        child: Text(
                          '\t\t$diagnosis',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        pDiagnosisChosen = value;
                      });
                    },
                    hint: Text(
                      '\t\tChoose your Diagnosis',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    isExpanded: false,
                  )
                : doctorChosen == 'Dr. Maryam Ansari (Gynaecologist)'
                    ? DropdownButtonFormField(
                        value: gDiagnosisChosen,
                        items: gynaecDiagnosis.map((diagnosis) {
                          return DropdownMenuItem(
                            value: diagnosis,
                            child: Text(
                              '\t\t$diagnosis',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            gDiagnosisChosen = value;
                          });
                        },
                        hint: Text(
                          '\t\tChoose your Diagnosis',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        isExpanded: false,
                      )
                    : doctorChosen == 'Dr. Zafar Shaikh (Pediatrician)'
                        ? DropdownButtonFormField(
                            value: pedDiagnosisChosen,
                            items: pediatricDiagnosis.map((diagnosis) {
                              return DropdownMenuItem(
                                value: diagnosis,
                                child: Text(
                                  '\t\t$diagnosis',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                pedDiagnosisChosen = value;
                              });
                            },
                            hint: Text(
                              '\t\tChoose your Diagnosis',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            isExpanded: false,
                          )
                        : DropdownButtonFormField(
                            value: cDiagnosisChosen,
                            items: cardiologistDiagnosis.map((diagnosis) {
                              return DropdownMenuItem(
                                value: diagnosis,
                                child: Text(
                                  '\t\t$diagnosis',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                cDiagnosisChosen = value;
                              });
                            },
                            hint: Text(
                              '\t\tChoose your Diagnosis',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            isExpanded: false,
                          ),
          ),
          SizedBox(
            height: 50,
          ), // Diagnosis Dropdown
          RaisedButton(
            child: Text(
              'Submit',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () async {
              patientIdEntire = await FirebaseFirestore.instance
                  .collection('entireJourney')
                  .add({
                'join_time': DateTime.now().toString(),
              });
              var dId = DocumentId();
              dId.patientIdEntire = patientIdEntire.id;
              positionEJ = await getPositionEntire();
              var entireTime = EntireTime(
                positionEJ: positionEJ,
                doctorChosen: doctorChosen,
                pDiagnosisChosen: pDiagnosisChosen,
                gDiagnosisChosen: gDiagnosisChosen,
                pedDiagnosisChosen: pedDiagnosisChosen,
                cDiagnosisChosen: cDiagnosisChosen,
              );
              entireJourney = await entireTime.entireJourneyTime();
              await Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) {
                return JoinRegistration(
                    doctorChosen,
                    pDiagnosisChosen,
                    gDiagnosisChosen,
                    cDiagnosisChosen,
                    pedDiagnosisChosen,
                    entireJourney,
                    patientIdEntire.id);
              }));
            },
            color: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 10,
          )
        ],
      ),
    );
  }
}
