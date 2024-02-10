import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasetest/paketlemeFire.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Paketleme extends StatefulWidget {
  final String siyezHesaplanan;
  final String tamBugdayHesaplanan;
  final String cavdarHesaplanan;

  Paketleme({
    required this.siyezHesaplanan,
    required this.tamBugdayHesaplanan,
    required this.cavdarHesaplanan,
  });

  @override
  State<Paketleme> createState() => _PaketlemeState();
}

class _PaketlemeState extends State<Paketleme> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  final db = FirebaseFirestore.instance;
  List<String> ustalar = [];
  String secilen = "";

  void getData() async {
    final usersCollection = db.collection('Calisanlar');

    final users = await usersCollection.get();

    setState(() {
      ustalar = users.docs.map((user) => user['Isım'] as String).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Paketleme"),
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
              Container(
                child: Text("Paketlemeyi Yapacak Ustayı seçin"),
              ),
              Container(
                width: 100,
                height: 100,
                child: DropdownButton(
                  value: secilen.isEmpty ? null : secilen,
                  items: ustalar.map((name) {
                    return DropdownMenuItem(value: name, child: Text(name));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      secilen = value!;
                    });
                  },
                ),
              ),
              Container(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PaketlemeFire(
                              siyezHesaplanan: widget.siyezHesaplanan,
                              tamBugdayHesaplanan: widget.tamBugdayHesaplanan,
                              cavdarHesaplanan: widget.cavdarHesaplanan,
                              kim: secilen)));
                    },
                    child: Text("Paketlemeye Başla")),
              )
            ],
          ),
        ));
  }
}
