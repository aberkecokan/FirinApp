import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paketleme/main.dart';

class Silme extends StatefulWidget {
  Silme({super.key});

  @override
  State<Silme> createState() => SilmeEkrani();
}

class SilmeEkrani extends State<Silme> {
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

  void deleteData(String gelen) async {
    final usersCollection = FirebaseFirestore.instance.collection('Calisanlar');

    QuerySnapshot querySnapshot =
        await usersCollection.where('Isım', isEqualTo: gelen).get();

    if (querySnapshot.docs.isNotEmpty) {
      await usersCollection.doc(querySnapshot.docs.first.id).delete();
      print('Belge silindi');
    } else {
      print('Belge bulunamadı');
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
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
          Padding(
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      deleteData(secilen);
                    });
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => MyApp()));
                  },
                  child: Text("Ustayı Sil")))
        ],
      ),
    );
  }
}
