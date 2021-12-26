import 'package:cloud_firestore/cloud_firestore.dart';

class Documents {
  final patientsRef = FirebaseFirestore.instance.collection('registration');
  var count = 0;
  getNumber() async {
    await patientsRef.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
        count = count + 1;
        documentSnapshot.data();
      });
      print("In getNumbers Method $count");
    });
    return count;
  }
}
