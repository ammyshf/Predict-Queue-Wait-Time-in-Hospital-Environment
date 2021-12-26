import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pqt_fourth/tflitemodels/billing_ann.dart';
import 'package:pqt_fourth/tflitemodels/registration_ann.dart';

import 'data/encoded_values.dart';
import 'tflitemodels/cardiologist_ann.dart';
import 'tflitemodels/gynaecologist_ann.dart';
import 'tflitemodels/medical_ann.dart';
import 'tflitemodels/pediatric_ann.dart';
import 'tflitemodels/physician_ann.dart';

class EntireTime {
  var positionEJ,
      doctorChosen,
      pDiagnosisChosen,
      gDiagnosisChosen,
      pedDiagnosisChosen,
      cDiagnosisChosen;

  int entireJourney = 0,
      i = 0,
      sum = 0,
      count = 0,
      entireRegistrationTime = 0,
      entirePhysicianTime = 0,
      entireGynaecologistTime = 0,
      entirePediatricTime = 0,
      entireCardiologistTime = 0,
      entireBillingTime = 0,
      entirePharmacyTime = 0;

  Map documentDataRegistration,
      documentDataBilling,
      documentDataPharmacy,
      documentDataPhysician,
      documentDataGynaecologist,
      documentDataPediatric,
      documentDataCardiologist;

  List documentDataListRegistration = [],
      documentDataListBilling = [],
      documentDataListPharmacy = [],
      documentDataListPhysician = [],
      documentDataListGynaecologist = [],
      documentDataListPediatric = [],
      documentDataListCardiologist = [];

  final registrationCollection =
      FirebaseFirestore.instance.collection('registration');
  final consultationBillingCollection =
      FirebaseFirestore.instance.collection('billing');
  final pharmacyCollection = FirebaseFirestore.instance.collection('pharmacy');
  final physicianCollection =
      FirebaseFirestore.instance.collection('physician');
  final gynaecologistCollection =
      FirebaseFirestore.instance.collection('gynaecologist');
  final pediatricCollection =
      FirebaseFirestore.instance.collection('pediatric');
  final cardiologistCollection =
      FirebaseFirestore.instance.collection('cardiologist');

  EntireTime({
    this.positionEJ,
    this.doctorChosen,
    this.pDiagnosisChosen,
    this.gDiagnosisChosen,
    this.pedDiagnosisChosen,
    this.cDiagnosisChosen,
  });

  entireJourneyTime() async {
    entireJourney = 0;

    if (positionEJ == 1.0) {
      if (doctorChosen == 'Dr. Saiqa Khan (Physician)') {
        entireRegistrationTime = 5;
        entireBillingTime = 8;
        entirePharmacyTime = 7;

        if (pDiagnosisChosen == 'Fever') {
          entirePhysicianTime = 6;
        } else if (pDiagnosisChosen == 'Common Cold') {
          entirePhysicianTime = 6;
        } else if (pDiagnosisChosen == 'Throat Pain') {
          entirePhysicianTime = 6;
        } else if (pDiagnosisChosen == 'Loose Motions') {
          entirePhysicianTime = 9;
        } else if (pDiagnosisChosen == 'High/Low BP') {
          entirePhysicianTime = 9;
        } else if (pDiagnosisChosen == 'Headache') {
          entirePhysicianTime = 6;
        } else if (pDiagnosisChosen == 'Small Injuries') {
          entirePhysicianTime = 15;
        } else if (pDiagnosisChosen == 'Stomach Ache') {
          entirePhysicianTime = 9;
        } else if (pDiagnosisChosen == 'Chest Pain') {
          entirePhysicianTime = 9;
        } else if (pDiagnosisChosen == 'Constipation') {
          entirePhysicianTime = 9;
        } else if (pDiagnosisChosen == 'Vomiting/Nausea') {
          entirePhysicianTime = 9;
        } else if (pDiagnosisChosen == 'Diabetes') {
          entirePhysicianTime = 14;
        } else if (pDiagnosisChosen == 'Back Pain') {
          entirePhysicianTime = 14;
        } else if (pDiagnosisChosen == 'Gas') {
          entirePhysicianTime = 9;
        } else if (pDiagnosisChosen == 'High Cholesterol') {
          entirePhysicianTime = 9;
        } else if (pDiagnosisChosen == 'Migraine') {
          entirePhysicianTime = 13;
        } else if (pDiagnosisChosen == 'Viral Fever') {
          entirePhysicianTime = 9;
        } else if (pDiagnosisChosen == 'Dizziness') {
          entirePhysicianTime = 9;
        } else if (pDiagnosisChosen == 'Unconciousness') {
          entirePhysicianTime = 18;
        } else {
          entirePhysicianTime = 15;
        }

        entireJourney = entireRegistrationTime +
            entirePhysicianTime +
            entireBillingTime +
            entirePharmacyTime +
            15;
      } else if (doctorChosen == 'Dr. Maryam Ansari (Gynaecologist)') {
        entireRegistrationTime = 5;
        entireBillingTime = 8;
        entirePharmacyTime = 7;

        if (gDiagnosisChosen == 'Period Issues') {
          entireGynaecologistTime = 9;
        } else if (gDiagnosisChosen == 'Breast Scan') {
          entireGynaecologistTime = 10;
        } else if (gDiagnosisChosen == 'Pregnancy Issues') {
          entireGynaecologistTime = 13;
        } else if (gDiagnosisChosen == 'Fertility Issues') {
          entireGynaecologistTime = 9;
        } else if (gDiagnosisChosen == 'Urinary Tract Infection') {
          entireGynaecologistTime = 9;
        } else if (gDiagnosisChosen == 'Pregnancy Routine Checkup') {
          entireGynaecologistTime = 11;
        } else if (gDiagnosisChosen == 'Sexuality Health Issues') {
          entireGynaecologistTime = 11;
        } else if (gDiagnosisChosen == 'Pain in Lower Abdomen') {
          entireGynaecologistTime = 9;
        } else if (gDiagnosisChosen == 'Excessive Bleeding during Periods') {
          entireGynaecologistTime = 9;
        } else if (gDiagnosisChosen == 'Vomiting/Nausea') {
          entireGynaecologistTime = 9;
        } else if (gDiagnosisChosen == 'Routine Checkup') {
          entireGynaecologistTime = 9;
        } else if (gDiagnosisChosen == 'Polycystic Ovary Syndrome') {
          entireGynaecologistTime = 11;
        } else if (gDiagnosisChosen == 'Bleeding After Intercourse') {
          entireGynaecologistTime = 15;
        } else {
          entireGynaecologistTime = 15;
        }

        entireJourney = entireRegistrationTime +
            entireGynaecologistTime +
            entireBillingTime +
            entirePharmacyTime +
            15;
      } else if (doctorChosen == 'Dr. Zafar Shaikh (Pediatrician)') {
        entireRegistrationTime = 5;
        entireBillingTime = 8;
        entirePharmacyTime = 7;

        if (pedDiagnosisChosen == 'Teething') {
          entirePediatricTime = 9;
        } else if (pedDiagnosisChosen == 'Fever') {
          entirePediatricTime = 9;
        } else if (pedDiagnosisChosen == 'Common Cold') {
          entirePediatricTime = 9;
        } else if (pedDiagnosisChosen == 'Fracture') {
          entirePediatricTime = 28;
        } else if (pedDiagnosisChosen == 'Ear Pain') {
          entirePediatricTime = 13;
        } else if (pedDiagnosisChosen == 'Stomach Ache') {
          entirePediatricTime = 9;
        } else if (pedDiagnosisChosen == 'Chest Pain') {
          entirePediatricTime = 9;
        } else if (pedDiagnosisChosen == 'Vomiting') {
          entirePediatricTime = 9;
        } else if (pedDiagnosisChosen == 'Diarrhoea') {
          entirePediatricTime = 9;
        } else if (pedDiagnosisChosen == 'Breathing Problem') {
          entirePediatricTime = 9;
        } else if (pedDiagnosisChosen == 'Skin Infection') {
          entirePediatricTime = 13;
        } else if (pedDiagnosisChosen == 'Sinus') {
          entirePediatricTime = 9;
        } else {
          entirePediatricTime = 15;
        }
        entireJourney = entireRegistrationTime +
            entirePediatricTime +
            entireBillingTime +
            entirePharmacyTime +
            15;
      } else {
        entireRegistrationTime = 5;
        entireBillingTime = 8;
        entirePharmacyTime = 7;

        if (cDiagnosisChosen == 'Chest Pain') {
          entireCardiologistTime = 13;
        } else if (cDiagnosisChosen == 'Irregular Heartrate') {
          entireCardiologistTime = 13;
        } else if (cDiagnosisChosen == 'High/Low BP') {
          entireCardiologistTime = 18;
        } else if (cDiagnosisChosen == 'Routine Checkup') {
          entireCardiologistTime = 18;
        } else if (cDiagnosisChosen == 'Cholesterol') {
          entireCardiologistTime = 18;
        } else if (cDiagnosisChosen == 'Fever') {
          entireCardiologistTime = 11;
        } else {
          entireCardiologistTime = 25;
        }

        entireJourney = entireRegistrationTime +
            entireCardiologistTime +
            entireBillingTime +
            entirePharmacyTime +
            15;
      }
    } else {
      entireRegistrationTime = await registrationTime();

      if (doctorChosen == 'Dr. Saiqa Khan (Physician)') {
        entirePhysicianTime = await physicianTime();
      } else if (doctorChosen == 'Dr. Maryam Ansari (Gynaecologist)') {
        entireGynaecologistTime = await gynaecologistTime();
      } else if (doctorChosen == 'Dr. Zafar Shaikh (Pediatrician)') {
        entirePediatricTime = await pediatricTime();
      } else {
        entireCardiologistTime = await cardiologistTime();
      }

      entireBillingTime = await billingTime();

      entirePharmacyTime = await pharmacyTime();

      entireJourney = entireRegistrationTime +
          entirePhysicianTime +
          entireGynaecologistTime +
          entirePediatricTime +
          entireCardiologistTime +
          entireBillingTime +
          entirePharmacyTime;
    }
    print('The entireJourneyTime is : $entireJourney');
    return entireJourney;
  }

  registrationTime() async {
    count = 0;

    int predictedTime;
    await registrationCollection
        .orderBy('join_time')
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
        count = count + 1;
      });
    });
    var model = RegistrationModel();
    predictedTime = await model.loadModel(count + 1.0);
    return predictedTime;
  }

  billingTime() async {
    int predictedTime;
    count = 0;

    await consultationBillingCollection
        .orderBy('join_time')
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
        count = count + 1;
      });
    });
    var model = BillingModel();
    predictedTime = await model.loadModel(count + 1.0);
    return predictedTime;
  }

  pharmacyTime() async {
    int predictedTime;
    count = 0;

    await pharmacyCollection
        .orderBy('join_time')
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
        count = count + 1;
      });
    });
    var model = MedicalModel();
    predictedTime = await model.loadModel(count + 1.0);
    return predictedTime;
  }

  physicianTime() async {
    int predictedTime;
    count = 0;
    sum = 0;

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

    if (pDiagnosisChosen == 'Fever') {
      predictedTime = await model.loadModel(fever);
      await physicianCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataPhysician = documentSnapshot.data();
          documentDataListPhysician.add(documentDataPhysician);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListPhysician[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (pDiagnosisChosen == 'Common Cold') {
      predictedTime = await model.loadModel(commonCold);
      await physicianCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataPhysician = documentSnapshot.data();
          documentDataListPhysician.add(documentDataPhysician);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListPhysician[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (pDiagnosisChosen == 'Throat Pain') {
      predictedTime = await model.loadModel(throatPain);
      await physicianCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataPhysician = documentSnapshot.data();
          documentDataListPhysician.add(documentDataPhysician);
          print(documentDataListPhysician);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListPhysician[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (pDiagnosisChosen == 'Loose Motions') {
      predictedTime = await model.loadModel(looseMotion);
      await physicianCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataPhysician = documentSnapshot.data();
          documentDataListPhysician.add(documentDataPhysician);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListPhysician[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (pDiagnosisChosen == 'High/Low BP') {
      predictedTime = await model.loadModel(highLowBp);
      await physicianCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataPhysician = documentSnapshot.data();
          documentDataListPhysician.add(documentDataPhysician);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListPhysician[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (pDiagnosisChosen == 'Headache') {
      predictedTime = await model.loadModel(headache);
      await physicianCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataPhysician = documentSnapshot.data();
          documentDataListPhysician.add(documentDataPhysician);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListPhysician[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (pDiagnosisChosen == 'Small Injuries') {
      predictedTime = await model.loadModel(smallInjuries);
      await physicianCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataPhysician = documentSnapshot.data();
          documentDataListPhysician.add(documentDataPhysician);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListPhysician[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (pDiagnosisChosen == 'Stomach Ache') {
      predictedTime = await model.loadModel(stomachAche);
      await physicianCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataPhysician = documentSnapshot.data();
          documentDataListPhysician.add(documentDataPhysician);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListPhysician[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (pDiagnosisChosen == 'Chest Pain') {
      predictedTime = await model.loadModel(chestPain);
      await physicianCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataPhysician = documentSnapshot.data();
          documentDataListPhysician.add(documentDataPhysician);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListPhysician[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (pDiagnosisChosen == 'Constipation') {
      predictedTime = await model.loadModel(constipation);
      await physicianCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataPhysician = documentSnapshot.data();
          documentDataListPhysician.add(documentDataPhysician);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListPhysician[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (pDiagnosisChosen == 'Vomiting/Nausea') {
      predictedTime = await model.loadModel(vomitingNausea);
      await physicianCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataPhysician = documentSnapshot.data();
          documentDataListPhysician.add(documentDataPhysician);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListPhysician[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (pDiagnosisChosen == 'Diabetes') {
      predictedTime = await model.loadModel(diabetes);
      await physicianCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataPhysician = documentSnapshot.data();
          documentDataListPhysician.add(documentDataPhysician);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListPhysician[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (pDiagnosisChosen == 'Back Pain') {
      predictedTime = await model.loadModel(backPain);
      await physicianCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataPhysician = documentSnapshot.data();
          documentDataListPhysician.add(documentDataPhysician);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListPhysician[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (pDiagnosisChosen == 'Gas') {
      predictedTime = await model.loadModel(gas);
      await physicianCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataPhysician = documentSnapshot.data();
          documentDataListPhysician.add(documentDataPhysician);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListPhysician[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (pDiagnosisChosen == 'High Cholesterol') {
      predictedTime = await model.loadModel(highCholesterol);
      await physicianCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataPhysician = documentSnapshot.data();
          documentDataListPhysician.add(documentDataPhysician);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListPhysician[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (pDiagnosisChosen == 'Migraine') {
      predictedTime = await model.loadModel(migraine);
      await physicianCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataPhysician = documentSnapshot.data();
          documentDataListPhysician.add(documentDataPhysician);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListPhysician[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (pDiagnosisChosen == 'Viral Fever') {
      predictedTime = await model.loadModel(viralFever);
      await physicianCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataPhysician = documentSnapshot.data();
          documentDataListPhysician.add(documentDataPhysician);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListPhysician[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (pDiagnosisChosen == 'Dizziness') {
      predictedTime = await model.loadModel(dizziness);
      await physicianCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataPhysician = documentSnapshot.data();
          documentDataListPhysician.add(documentDataPhysician);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListPhysician[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (pDiagnosisChosen == 'Unconciousness') {
      predictedTime = await model.loadModel(unconciousness);
      await physicianCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataPhysician = documentSnapshot.data();
          documentDataListPhysician.add(documentDataPhysician);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListPhysician[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (pDiagnosisChosen == 'Other') {
      predictedTime = await model.loadModel(other);
      await physicianCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataPhysician = documentSnapshot.data();
          documentDataListPhysician.add(documentDataPhysician);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListPhysician[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    }
    return predictedTime;
  }

  gynaecologistTime() async {
    int predictedTime;
    count = 0;
    sum = 0;

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

    if (gDiagnosisChosen == 'Period Issues') {
      predictedTime = await model.loadModel(periodIssues);
      await gynaecologistCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataGynaecologist = documentSnapshot.data();
          documentDataListGynaecologist.add(documentDataGynaecologist);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListGynaecologist[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (gDiagnosisChosen == 'Breast Scan') {
      predictedTime = await model.loadModel(breastScan);
      await gynaecologistCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataGynaecologist = documentSnapshot.data();
          documentDataListGynaecologist.add(documentDataGynaecologist);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListGynaecologist[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (gDiagnosisChosen == 'Pregnancy Issues') {
      predictedTime = await model.loadModel(pregnancyIssues);
      await gynaecologistCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataGynaecologist = documentSnapshot.data();
          documentDataListGynaecologist.add(documentDataGynaecologist);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListGynaecologist[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (gDiagnosisChosen == 'Fertility Issues') {
      predictedTime = await model.loadModel(fertlityIssues);
      await gynaecologistCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataGynaecologist = documentSnapshot.data();
          documentDataListGynaecologist.add(documentDataGynaecologist);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListGynaecologist[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (gDiagnosisChosen == 'Urinary Tract Infection') {
      predictedTime = await model.loadModel(urinaryTractInfection);
      await gynaecologistCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataGynaecologist = documentSnapshot.data();
          documentDataListGynaecologist.add(documentDataGynaecologist);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListGynaecologist[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (gDiagnosisChosen == 'Pregnancy Routine Checkup') {
      predictedTime = await model.loadModel(pregnancyRoutineCheckUp);
      await gynaecologistCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataGynaecologist = documentSnapshot.data();
          documentDataListGynaecologist.add(documentDataGynaecologist);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListGynaecologist[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (gDiagnosisChosen == 'Sexuality Health Issues') {
      predictedTime = await model.loadModel(sexualityHealthIssues);
      await gynaecologistCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataGynaecologist = documentSnapshot.data();
          documentDataListGynaecologist.add(documentDataGynaecologist);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListGynaecologist[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (gDiagnosisChosen == 'Pain in Lower Abdomen') {
      predictedTime = await model.loadModel(painInLowerAbdomen);
      await gynaecologistCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataGynaecologist = documentSnapshot.data();
          documentDataListGynaecologist.add(documentDataGynaecologist);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListGynaecologist[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (gDiagnosisChosen == 'Excessive Bleeding during Periods') {
      predictedTime = await model.loadModel(excessiveBleeding);
      await gynaecologistCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataGynaecologist = documentSnapshot.data();
          documentDataListGynaecologist.add(documentDataGynaecologist);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListGynaecologist[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (gDiagnosisChosen == 'Vomiting/Nausea') {
      predictedTime = await model.loadModel(vomitingNauseaGynaec);
      await gynaecologistCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataGynaecologist = documentSnapshot.data();
          documentDataListGynaecologist.add(documentDataGynaecologist);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListGynaecologist[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (gDiagnosisChosen == 'Routine Checkup') {
      predictedTime = await model.loadModel(routineCheckUp);
      await gynaecologistCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataGynaecologist = documentSnapshot.data();
          documentDataListGynaecologist.add(documentDataGynaecologist);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListGynaecologist[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (gDiagnosisChosen == 'Polycystic Ovary Syndrome') {
      predictedTime = await model.loadModel(polycysticOvarySyndrome);
      await gynaecologistCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataGynaecologist = documentSnapshot.data();
          documentDataListGynaecologist.add(documentDataGynaecologist);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListGynaecologist[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (gDiagnosisChosen == 'Bleeding After Intercourse') {
      predictedTime = await model.loadModel(bleedingAfterIntercourse);
      await gynaecologistCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataGynaecologist = documentSnapshot.data();
          documentDataListGynaecologist.add(documentDataGynaecologist);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListGynaecologist[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (gDiagnosisChosen == 'Other') {
      predictedTime = await model.loadModel(otherGynaec);
      await gynaecologistCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataGynaecologist = documentSnapshot.data();
          documentDataListGynaecologist.add(documentDataGynaecologist);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListGynaecologist[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    }
    return predictedTime;
  }

  pediatricTime() async {
    int predictedTime;
    count = 0;
    sum = 0;

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

    if (pedDiagnosisChosen == 'Teething') {
      predictedTime = await model.loadModel(teething);

      await pediatricCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataPediatric = documentSnapshot.data();
          documentDataListPediatric.add(documentDataPediatric);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListPediatric[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (pedDiagnosisChosen == 'Fever') {
      predictedTime = await model.loadModel(feverPediatric);

      await pediatricCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataPediatric = documentSnapshot.data();
          documentDataListPediatric.add(documentDataPediatric);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListPediatric[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (pedDiagnosisChosen == 'Common Cold') {
      predictedTime = await model.loadModel(commonColdPediatric);

      await pediatricCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataPediatric = documentSnapshot.data();
          documentDataListPediatric.add(documentDataPediatric);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListPediatric[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (pedDiagnosisChosen == 'Fracture') {
      predictedTime = await model.loadModel(fracture);

      await pediatricCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataPediatric = documentSnapshot.data();
          documentDataListPediatric.add(documentDataPediatric);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListPediatric[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (pedDiagnosisChosen == 'Ear Pain') {
      predictedTime = await model.loadModel(earPain);

      await pediatricCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataPediatric = documentSnapshot.data();
          documentDataListPediatric.add(documentDataPediatric);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListPediatric[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (pedDiagnosisChosen == 'Stomach Ache') {
      predictedTime = await model.loadModel(stomachAchePediatric);

      await pediatricCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataPediatric = documentSnapshot.data();
          documentDataListPediatric.add(documentDataPediatric);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListPediatric[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (pedDiagnosisChosen == 'Chest Pain') {
      predictedTime = await model.loadModel(chestPainPediatric);

      await pediatricCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataPediatric = documentSnapshot.data();
          documentDataListPediatric.add(documentDataPediatric);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListPediatric[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (pedDiagnosisChosen == 'Vomiting') {
      predictedTime = await model.loadModel(vomiting);

      await pediatricCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataPediatric = documentSnapshot.data();
          documentDataListPediatric.add(documentDataPediatric);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListPediatric[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (pedDiagnosisChosen == 'Diarrhoea') {
      predictedTime = await model.loadModel(diarrhoea);

      await pediatricCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataPediatric = documentSnapshot.data();
          documentDataListPediatric.add(documentDataPediatric);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListPediatric[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (pedDiagnosisChosen == 'Breathing Problem') {
      predictedTime = await model.loadModel(breathingProblem);

      await pediatricCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataPediatric = documentSnapshot.data();
          documentDataListPediatric.add(documentDataPediatric);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListPediatric[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (pedDiagnosisChosen == 'Skin Infection') {
      predictedTime = await model.loadModel(skinInfection);

      await pediatricCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataPediatric = documentSnapshot.data();
          documentDataListPediatric.add(documentDataPediatric);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListPediatric[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (pedDiagnosisChosen == 'Sinus') {
      predictedTime = await model.loadModel(sinus);

      await pediatricCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataPediatric = documentSnapshot.data();
          documentDataListPediatric.add(documentDataPediatric);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListPediatric[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (pedDiagnosisChosen == 'Other') {
      predictedTime = await model.loadModel(otherPediatric);

      await pediatricCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataPediatric = documentSnapshot.data();
          documentDataListPediatric.add(documentDataPediatric);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListPediatric[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    }
    return predictedTime;
  }

  cardiologistTime() async {
    int predictedTime;
    count = 0;
    sum = 0;

    var encodedData = EncodedValues();
    var chestPainCardio = encodedData.chestPainCardio;
    var irregularHeartRate = encodedData.irregularHeartrate;
    var highLowBpCardio = encodedData.highLowBpCardio;
    var routineCheckup = encodedData.routineCheckupCardio;
    var cholesterol = encodedData.cholesterol;
    var feverCardio = encodedData.feverCardio;
    var otherCardio = encodedData.otherCardio;

    var model = CardiologistModel();

    if (cDiagnosisChosen == 'Chest Pain') {
      predictedTime = await model.loadModel(chestPainCardio);

      await cardiologistCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataCardiologist = documentSnapshot.data();
          documentDataListCardiologist.add(documentDataCardiologist);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListCardiologist[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (cDiagnosisChosen == 'Irregular Heartrate') {
      predictedTime = await model.loadModel(irregularHeartRate);

      await cardiologistCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataCardiologist = documentSnapshot.data();
          documentDataListCardiologist.add(documentDataCardiologist);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListCardiologist[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (cDiagnosisChosen == 'High/Low BP') {
      predictedTime = await model.loadModel(highLowBpCardio);

      await cardiologistCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataCardiologist = documentSnapshot.data();
          documentDataListCardiologist.add(documentDataCardiologist);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListCardiologist[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (cDiagnosisChosen == 'Routine Checkup') {
      predictedTime = await model.loadModel(routineCheckup);

      await cardiologistCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataCardiologist = documentSnapshot.data();
          documentDataListCardiologist.add(documentDataCardiologist);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListCardiologist[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (cDiagnosisChosen == 'Cholesterol') {
      predictedTime = await model.loadModel(cholesterol);

      await cardiologistCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataCardiologist = documentSnapshot.data();
          documentDataListCardiologist.add(documentDataCardiologist);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListCardiologist[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (cDiagnosisChosen == 'Fever') {
      predictedTime = await model.loadModel(feverCardio);

      await cardiologistCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataCardiologist = documentSnapshot.data();
          documentDataListCardiologist.add(documentDataCardiologist);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListCardiologist[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    } else if (cDiagnosisChosen == 'Other') {
      predictedTime = await model.loadModel(otherCardio);

      await cardiologistCollection
          .orderBy('join_time')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          count = count + 1;
          documentDataCardiologist = documentSnapshot.data();
          documentDataListCardiologist.add(documentDataCardiologist);
        });
        for (i = 0; i < count; i++) {
          sum = sum + documentDataListCardiologist[i]['predictedTime'];
        }
      });
      predictedTime = predictedTime + sum;
    }
    return predictedTime;
  }
}
