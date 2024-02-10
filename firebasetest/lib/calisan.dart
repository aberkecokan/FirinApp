import 'package:cloud_firestore/cloud_firestore.dart';

class Calisan {
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('Çalışanlar');

  Stream<QuerySnapshot> getNotesStream() {
    final notesStream =
        notes.orderBy('Çalışanlar', descending: true).snapshots();
    return notesStream;
  }
}
