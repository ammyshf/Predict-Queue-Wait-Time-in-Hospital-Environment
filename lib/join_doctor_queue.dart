import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pqt_fourth/data/documentIds.dart';
import 'package:pqt_fourth/data/encoded_values.dart';
import 'package:pqt_fourth/predicted_time_consult_pediatric.dart';
import 'package:pqt_fourth/tflitemodels/gynaecologist_ann.dart';
import 'package:pqt_fourth/tflitemodels/pediatric_ann.dart';
import 'package:pqt_fourth/tflitemodels/physician_ann.dart';
import './predicted_time_consult_cardio.dart';
import './predicted_time_consult_gynaec.dart';
import './predicted_time_consult_physician.dart';
import 'tflitemodels/cardiologist_ann.dart';

class JoinDoctor extends StatefulWidget {
  final doctorChosen,
      pDiagnosisChosen,
      gDiagnosisChosen,
      cDiagnosisChosen,
      pedDiagnosisChosen;

  final Widget entireTimer;

  JoinDoctor(
    this.doctorChosen,
    this.pDiagnosisChosen,
    this.gDiagnosisChosen,
    this.cDiagnosisChosen,
    this.pedDiagnosisChosen,
    this.entireTimer,
  );
  @override
  _JoinDoctorState createState() => _JoinDoctorState();
}

class _JoinDoctorState extends State<JoinDoctor> {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey();

  int i = 0, count = 0, sum = 0;

  DocumentReference patientId;

  var physicianTime,
      physicianPosition,
      gynaecTime,
      gynaecPosition,
      pediatricTime,
      pediatricPosition,
      cardioTime,
      cardioPosition;

  Map documentData;

  List documentDataList = [];

  void navigateDoctor(BuildContext context) async {
    if (widget.doctorChosen == 'Dr. Saiqa Khan (Physician)') {
      patientId = await FirebaseFirestore.instance.collection('physician').add({
        'join_time': DateTime.now().toString(),
      });
      var dId = DocumentId();
      dId.patientIdPhysician = patientId.id;
      physicianTime = await getPositionPhysician();
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => PredictConsultationPhysician(
                  physicianTime,
                  physicianPosition,
                  getPositionPhysician,
                  sum,
                  patientId.id,
                  widget.entireTimer,
                )),
      );
    } else if (widget.doctorChosen == 'Dr. Zafar Shaikh (Pediatrician)') {
      patientId = await FirebaseFirestore.instance.collection('pediatric').add({
        'join_time': DateTime.now().toString(),
      });
      var dId = DocumentId();
      dId.patientIdPediatrician = patientId.id;
      pediatricTime = await getPositionPediatric();
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => PredictConsultationPediatric(
                  pediatricTime,
                  pediatricPosition,
                  getPositionPediatric,
                  sum,
                  patientId.id,
                  widget.entireTimer,
                )),
      );
    } else if (widget.doctorChosen == 'Dr. Maryam Ansari (Gynaecologist)') {
      patientId =
          await FirebaseFirestore.instance.collection('gynaecologist').add({
        'join_time': DateTime.now().toString(),
      });
      var dId = DocumentId();
      dId.patientIdGynaecologist = patientId.id;
      gynaecTime = await getPositionGynaec();
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => PredictConsultationGynaec(
                  gynaecTime,
                  gynaecPosition,
                  getPositionGynaec,
                  sum,
                  patientId.id,
                  widget.entireTimer,
                )),
      );
    } else {
      patientId =
          await FirebaseFirestore.instance.collection('cardiologist').add({
        'join_time': DateTime.now().toString(),
      });
      var dId = DocumentId();
      dId.patientIdCardiologist = patientId.id;
      cardioTime = await getPositionCardio();
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => PredictConsultationCardio(
                  cardioTime,
                  cardioPosition,
                  getPositionCardio,
                  sum,
                  patientId.id,
                  widget.entireTimer,
                )),
      );
    }
  }

  getPositionPhysician() async {
    var documentId = await patientId.id;
    var predictedTime;
    var position = 1.0;
    print(documentId);
    final collectionReference =
        FirebaseFirestore.instance.collection('physician');
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
      physicianPosition = position;
      var encodedData = EncodedValues();
      var backPain = encodedData.backPain;
      var chestPain = encodedData.chestPain;
      var commonCold = encodedData.commonCold;
      var constipation = encodedData.constipation;
      var diabetes = encodedData.diabetes;
      var dizziness = encodedData.dizziness;
      var fever = encodedData.fever;
      var gas = encodedData.gas;
      var headache = encodedData.headache;
      var highCholesterol = encodedData.highCholesterol;
      var highLowBp = encodedData.highLowBp;
      var looseMotion = encodedData.looseMotion;
      var migraine = encodedData.migraine;
      var other = encodedData.other;
      var smallInjuries = encodedData.smallInjuries;
      var stomachAche = encodedData.stomachAche;
      var throatPain = encodedData.throatPain;
      var unconciousness = encodedData.unconciousness;
      var viralFever = encodedData.viralFever;
      var vomitingNausea = encodedData.vomitingNausea;

      var model = PhysicianModel();

      if (widget.pDiagnosisChosen == 'Fever') {
        predictedTime = await model.loadModel(fever);
        await FirebaseFirestore.instance
            .collection('physician')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.pDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.pDiagnosisChosen == 'Common Cold') {
        predictedTime = await model.loadModel(commonCold);
        await FirebaseFirestore.instance
            .collection('physician')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.pDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.pDiagnosisChosen == 'Throat Pain') {
        predictedTime = await model.loadModel(throatPain);
        await FirebaseFirestore.instance
            .collection('physician')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.pDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.pDiagnosisChosen == 'Loose Motions') {
        predictedTime = await model.loadModel(looseMotion);
        await FirebaseFirestore.instance
            .collection('physician')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.pDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.pDiagnosisChosen == 'High/Low BP') {
        predictedTime = await model.loadModel(highLowBp);
        await FirebaseFirestore.instance
            .collection('physician')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.pDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.pDiagnosisChosen == 'Headache') {
        predictedTime = await model.loadModel(headache);
        await FirebaseFirestore.instance
            .collection('physician')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.pDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.pDiagnosisChosen == 'Small Injuries') {
        predictedTime = await model.loadModel(smallInjuries);
        await FirebaseFirestore.instance
            .collection('physician')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.pDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.pDiagnosisChosen == 'Stomach Ache') {
        predictedTime = await model.loadModel(stomachAche);
        await FirebaseFirestore.instance
            .collection('physician')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.pDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.pDiagnosisChosen == 'Chest Pain') {
        predictedTime = await model.loadModel(chestPain);
        await FirebaseFirestore.instance
            .collection('physician')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.pDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.pDiagnosisChosen == 'Constipation') {
        predictedTime = await model.loadModel(constipation);
        await FirebaseFirestore.instance
            .collection('physician')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.pDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.pDiagnosisChosen == 'Vomiting/Nausea') {
        predictedTime = await model.loadModel(vomitingNausea);
        await FirebaseFirestore.instance
            .collection('physician')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.pDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.pDiagnosisChosen == 'Diabetes') {
        predictedTime = await model.loadModel(diabetes);
        await FirebaseFirestore.instance
            .collection('physician')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.pDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.pDiagnosisChosen == 'Back Pain') {
        predictedTime = await model.loadModel(backPain);
        await FirebaseFirestore.instance
            .collection('physician')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.pDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.pDiagnosisChosen == 'Gas') {
        predictedTime = await model.loadModel(gas);
        await FirebaseFirestore.instance
            .collection('physician')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.pDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.pDiagnosisChosen == 'High Cholesterol') {
        predictedTime = await model.loadModel(highCholesterol);
        await FirebaseFirestore.instance
            .collection('physician')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.pDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.pDiagnosisChosen == 'Migraine') {
        predictedTime = await model.loadModel(migraine);
        await FirebaseFirestore.instance
            .collection('physician')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.pDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.pDiagnosisChosen == 'Viral Fever') {
        predictedTime = await model.loadModel(viralFever);
        await FirebaseFirestore.instance
            .collection('physician')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.pDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.pDiagnosisChosen == 'Dizziness') {
        predictedTime = await model.loadModel(dizziness);
        await FirebaseFirestore.instance
            .collection('physician')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.pDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.pDiagnosisChosen == 'Unconciousness') {
        predictedTime = await model.loadModel(unconciousness);
        await FirebaseFirestore.instance
            .collection('physician')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.pDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.pDiagnosisChosen == 'Other') {
        predictedTime = await model.loadModel(other);
        await FirebaseFirestore.instance
            .collection('physician')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.pDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      }
    });
    return sum;
  }

  getPositionGynaec() async {
    var documentId = await patientId.id;
    var predictedTime;
    var position = 1.0;
    print(documentId);
    final collectionReference =
        FirebaseFirestore.instance.collection('gynaecologist');
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
      gynaecPosition = position;
      var encodedData = EncodedValues();
      var bleedingAfterIntercourse = encodedData.bleedingAfterIntercourse;
      var breastScan = encodedData.breastScan;
      var excessiveBleeding = encodedData.excessiveBleeding;
      var fertlityIssues = encodedData.fertilityIssues;
      var otherGynaec = encodedData.otherGynaec;
      var painInLowerAbdomen = encodedData.painInLowerAbdomen;
      var periodIssues = encodedData.periodIssues;
      var polycysticOvarySyndrome = encodedData.polycysticOvarySyndrome;
      var pregnancyRoutineCheckUp = encodedData.pregnancyRoutineCheckUp;
      var pregnancyIssues = encodedData.pregnancyIssues;
      var routineCheckUp = encodedData.routineCheckUp;
      var sexualityHealthIssues = encodedData.sexualityHealthIssues;
      var urinaryTractInfection = encodedData.urinaryTractInfection;
      var vomitingNauseaGynaec = encodedData.vomitingNauseaGynaec;

      var model = GynaecologistModel();

      if (widget.gDiagnosisChosen == 'Period Issues') {
        predictedTime = await model.loadModel(periodIssues);
        await FirebaseFirestore.instance
            .collection('gynaecologist')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.gDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.gDiagnosisChosen == 'Breast Scan') {
        predictedTime = await model.loadModel(breastScan);
        await FirebaseFirestore.instance
            .collection('gynaecologist')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.gDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.gDiagnosisChosen == 'Pregnancy Issues') {
        predictedTime = await model.loadModel(pregnancyIssues);
        await FirebaseFirestore.instance
            .collection('gynaecologist')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.gDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.gDiagnosisChosen == 'Fertility Issues') {
        predictedTime = await model.loadModel(fertlityIssues);
        await FirebaseFirestore.instance
            .collection('gynaecologist')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.gDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.gDiagnosisChosen == 'Urinary Tract Infection') {
        predictedTime = await model.loadModel(urinaryTractInfection);
        await FirebaseFirestore.instance
            .collection('gynaecologist')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.gDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.gDiagnosisChosen == 'Pregnancy Routine Checkup') {
        predictedTime = await model.loadModel(pregnancyRoutineCheckUp);
        await FirebaseFirestore.instance
            .collection('gynaecologist')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.gDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.gDiagnosisChosen == 'Sexuality Health Issues') {
        predictedTime = await model.loadModel(sexualityHealthIssues);
        await FirebaseFirestore.instance
            .collection('gynaecologist')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.gDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.gDiagnosisChosen == 'Pain in Lower Abdomen') {
        predictedTime = await model.loadModel(painInLowerAbdomen);
        await FirebaseFirestore.instance
            .collection('gynaecologist')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.gDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.gDiagnosisChosen ==
          'Excessive Bleeding during Periods') {
        predictedTime = await model.loadModel(excessiveBleeding);
        await FirebaseFirestore.instance
            .collection('gynaecologist')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.gDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.gDiagnosisChosen == 'Vomiting/Nausea') {
        predictedTime = await model.loadModel(vomitingNauseaGynaec);
        await FirebaseFirestore.instance
            .collection('gynaecologist')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.gDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.gDiagnosisChosen == 'Routine Checkup') {
        predictedTime = await model.loadModel(routineCheckUp);
        await FirebaseFirestore.instance
            .collection('gynaecologist')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.gDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.gDiagnosisChosen == 'Polycystic Ovary Syndrome') {
        predictedTime = await model.loadModel(polycysticOvarySyndrome);
        await FirebaseFirestore.instance
            .collection('gynaecologist')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.gDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.gDiagnosisChosen == 'Bleeding After Intercourse') {
        predictedTime = await model.loadModel(bleedingAfterIntercourse);
        await FirebaseFirestore.instance
            .collection('gynaecologist')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.gDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.gDiagnosisChosen == 'Other') {
        predictedTime = await model.loadModel(otherGynaec);
        await FirebaseFirestore.instance
            .collection('gynaecologist')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.gDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      }
    });
    return sum;
  }

  getPositionPediatric() async {
    var documentId = await patientId.id;
    var predictedTime;
    var position = 1.0;
    print(documentId);
    final collectionReference =
        FirebaseFirestore.instance.collection('pediatric');
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
      pediatricPosition = position;
      var encodedData = EncodedValues();
      var teething = encodedData.teething;
      var feverPediatric = encodedData.feverPediatric;
      var commonColdPediatric = encodedData.commonColdPediatric;
      var fracture = encodedData.fracture;
      var earPain = encodedData.earPain;
      var stomachAchePediatric = encodedData.stomachAchePediatric;
      var chestPainPediatric = encodedData.chestPainPediatric;
      var vomiting = encodedData.vomiting;
      var diarrhoea = encodedData.diarrhoea;
      var breathingProblem = encodedData.breathingProblem;
      var skinInfection = encodedData.skinInfection;
      var sinus = encodedData.sinus;
      var otherPediatric = encodedData.otherPediatric;

      var model = PediatricModel();

      if (widget.pedDiagnosisChosen == 'Teething') {
        predictedTime = await model.loadModel(teething);
        await FirebaseFirestore.instance
            .collection('pediatric')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.pedDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.pedDiagnosisChosen == 'Fever') {
        predictedTime = await model.loadModel(feverPediatric);
        await FirebaseFirestore.instance
            .collection('pediatric')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.pedDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.pedDiagnosisChosen == 'Common Cold') {
        predictedTime = await model.loadModel(commonColdPediatric);
        await FirebaseFirestore.instance
            .collection('pediatric')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.pedDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.pedDiagnosisChosen == 'Fracture') {
        predictedTime = await model.loadModel(fracture);
        await FirebaseFirestore.instance
            .collection('pediatric')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.pedDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.pedDiagnosisChosen == 'Ear Pain') {
        predictedTime = await model.loadModel(earPain);
        await FirebaseFirestore.instance
            .collection('pediatric')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.pedDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.pedDiagnosisChosen == 'Stomach Ache') {
        predictedTime = await model.loadModel(stomachAchePediatric);
        await FirebaseFirestore.instance
            .collection('pediatric')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.pedDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.pedDiagnosisChosen == 'Chest Pain') {
        predictedTime = await model.loadModel(chestPainPediatric);
        await FirebaseFirestore.instance
            .collection('pediatric')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.pedDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.pedDiagnosisChosen == 'Vomiting') {
        predictedTime = await model.loadModel(vomiting);
        await FirebaseFirestore.instance
            .collection('pediatric')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.pedDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.pedDiagnosisChosen == 'Diarrhoea') {
        predictedTime = await model.loadModel(diarrhoea);
        await FirebaseFirestore.instance
            .collection('pediatric')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.pedDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.pedDiagnosisChosen == 'Breathing Problem') {
        predictedTime = await model.loadModel(breathingProblem);
        await FirebaseFirestore.instance
            .collection('pediatric')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.pedDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.pedDiagnosisChosen == 'Skin Infection') {
        predictedTime = await model.loadModel(skinInfection);
        await FirebaseFirestore.instance
            .collection('pediatric')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.pedDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.pedDiagnosisChosen == 'Sinus') {
        predictedTime = await model.loadModel(sinus);
        await FirebaseFirestore.instance
            .collection('pediatric')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.pedDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.pedDiagnosisChosen == 'Other') {
        predictedTime = await model.loadModel(otherPediatric);
        await FirebaseFirestore.instance
            .collection('pediatric')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.pedDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      }
    });
    return sum;
  }

  getPositionCardio() async {
    var documentId = await patientId.id;
    var predictedTime;
    var position = 1.0;
    print(documentId);
    final collectionReference =
        FirebaseFirestore.instance.collection('cardiologist');
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
      cardioPosition = position;
      var encodedData = EncodedValues();
      var chestPainCardio = encodedData.chestPainCardio;
      var irregularHeartRate = encodedData.irregularHeartrate;
      var highLowBpCardio = encodedData.highLowBpCardio;
      var routineCheckup = encodedData.routineCheckupCardio;
      var cholesterol = encodedData.cholesterol;
      var feverCardio = encodedData.feverCardio;
      var otherCardio = encodedData.otherCardio;

      var model = CardiologistModel();

      if (widget.cDiagnosisChosen == 'Chest Pain') {
        predictedTime = await model.loadModel(chestPainCardio);
        await FirebaseFirestore.instance
            .collection('cardiologist')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.cDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.cDiagnosisChosen == 'Irregular Heartrate') {
        predictedTime = await model.loadModel(irregularHeartRate);
        await FirebaseFirestore.instance
            .collection('cardiologist')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.cDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.cDiagnosisChosen == 'High/Low BP') {
        predictedTime = await model.loadModel(highLowBpCardio);
        await FirebaseFirestore.instance
            .collection('cardiologist')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.cDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.cDiagnosisChosen == 'Routine Checkup') {
        predictedTime = await model.loadModel(routineCheckup);
        await FirebaseFirestore.instance
            .collection('cardiologist')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.cDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.cDiagnosisChosen == 'Cholesterol') {
        predictedTime = await model.loadModel(cholesterol);
        await FirebaseFirestore.instance
            .collection('cardiologist')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.cDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.cDiagnosisChosen == 'Fever') {
        predictedTime = await model.loadModel(feverCardio);
        await FirebaseFirestore.instance
            .collection('cardiologist')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.cDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      } else if (widget.cDiagnosisChosen == 'Other') {
        predictedTime = await model.loadModel(otherCardio);
        await FirebaseFirestore.instance
            .collection('cardiologist')
            .doc(patientId.id)
            .update({
          'predictedTime': predictedTime,
          'issue': widget.cDiagnosisChosen,
        });
        await collectionReference
            .orderBy('join_time')
            .get()
            .then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
            count = count + 1;
            documentData = documentSnapshot.data();
            documentDataList.add(documentData);
          });
          for (i = 0; i < count - 1; i++) {
            sum = sum + documentDataList[i]['predictedTime'];
          }
        });
      }
    });
    return sum;
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Card(
                  color: Colors.blue,
                  elevation: 10,
                  child: Image.asset(
                    'assets/queue.jpg',
                    fit: BoxFit.cover,
                  ),
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
            "CONSULTATION",
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
              'assets/consultation.jpg',
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
                  'Join Consultation Queue',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  navigateDoctor(context);
                }),
          ),
        ],
      ),
    );
  }
}
