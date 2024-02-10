import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasetest/listpage.dart';
import 'package:firebasetest/main.dart';
import 'package:firebasetest/paketleme.dart';
import 'package:flutter/material.dart';

class Hesaplama extends StatefulWidget {
  final String siyezHesaplanan;
  final String tamBugdayHesaplanan;
  final String cavdarHesaplanan;
  final String kim;

  Hesaplama({
    required this.tamBugdayHesaplanan,
    required this.cavdarHesaplanan,
    required this.siyezHesaplanan,
    required this.kim,
  });

  @override
  _HesaplamaState createState() => _HesaplamaState();
}

class _HesaplamaState extends State<Hesaplama> {
  final db = FirebaseFirestore.instance;
  void setDataEkmek(String gelen) async {
    final usersCollection = db.collection('Urunler');
    final user = {
      'Isım': gelen,
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
        title: Text("Hesaplama - ${widget.kim}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: widget.siyezHesaplanan != '0',
              child: Text("Siyez: ${widget.siyezHesaplanan}"),
            ),
            Visibility(
              visible: widget.tamBugdayHesaplanan != '0',
              child: Text("Tam Buğday: ${widget.tamBugdayHesaplanan}"),
            ),
            Visibility(
              visible: widget.cavdarHesaplanan != '0',
              child: Text("Çavdar: ${widget.cavdarHesaplanan}"),
            ),
            ElevatedButton(
                onPressed: () {
                  setDataEkmek(
                    widget.kim,
                  );
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => testWidget()));
                },
                child: Text("Onayla"))
          ],
        ),
      ),
    );
  }
}
