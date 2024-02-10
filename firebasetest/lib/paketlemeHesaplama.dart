import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasetest/paketleme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PaketlemeHesaplama extends StatefulWidget {
  final String siyezHesaplanan;
  final String tamBugdayHesaplanan;
  final String cavdarHesaplanan;
  final String kim;
  PaketlemeHesaplama({
    required this.siyezHesaplanan,
    required this.tamBugdayHesaplanan,
    required this.cavdarHesaplanan,
    required this.kim,
  });

  @override
  State<PaketlemeHesaplama> createState() => _PaketlemeHesaplamaState();
}

class _PaketlemeHesaplamaState extends State<PaketlemeHesaplama> {
  final db = FirebaseFirestore.instance;
  void setDataEkmek(String kim) async {
    final usersCollection = db.collection('Paketlenen');
    final user = {
      'Isım': kim,
      'TimeStamp': DateTime.now(),
      'Kac EkmekSiyez': widget.siyezHesaplanan,
      'Kac EkmekCavdar': widget.cavdarHesaplanan,
      'Kac EkmekTamBugday': widget.tamBugdayHesaplanan,
    };
    await usersCollection.doc().set(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paketleme Onay"),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              child: Visibility(
                  visible: widget.siyezHesaplanan != "0",
                  child: Text("Siyez : ${widget.siyezHesaplanan}")),
            ),
            Container(
              child: Visibility(
                  visible: widget.cavdarHesaplanan != "0",
                  child: Text("Çavdar : ${widget.cavdarHesaplanan}")),
            ),
            Container(
              child: Visibility(
                  visible: widget.tamBugdayHesaplanan != "0",
                  child: Text("Tam Buğday : ${widget.tamBugdayHesaplanan}")),
            ),
            ElevatedButton(
                onPressed: () {
                  setDataEkmek(widget.kim);
                },
                child: Text("Onayla")),
          ],
        ),
      ),
    );
  }
}
