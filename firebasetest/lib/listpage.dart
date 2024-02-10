import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebasetest/main.dart';
import 'package:firebasetest/uretim.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class testWidget extends StatelessWidget {
  const testWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Page(),
    );
  }
}

class Page extends StatefulWidget {
  const Page({super.key});

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  final db = FirebaseFirestore.instance;
  int countvalue = 0;
  String deneme = " ";
  final text = TextEditingController();
  List<String> ustalar = [];
  List<String> urunler = ["Siyez", "Tam Buğday", "Köy ekmeği", "Çavdar"];

  String secilen = "";
  String secilenurun = "";
  String calisanlar = "";
  String saat = "";

  @override
  void initState() {
    getDocumentsInDateRange();
    super.initState();
  }

  /*updateData() async {
    print("Girdi");
    dbref = FirebaseDatabase.instance.ref("Çalışanlar");
    DatabaseEvent event = await dbref.once();
    print(event.snapshot.value);
  }
  */

  void getData() async {
    final usersCollection = db.collection('Calisanlar');

    final users = await usersCollection.get();

    setState(() {
      ustalar = users.docs.map((user) => user['Isım'] as String).toList();
    });
  }

  void setData(String gelen) async {
    final usersCollection = db.collection('Calisanlar');
    final user = {'Isım': gelen, 'TimeStamp': DateTime.now()};
    await usersCollection.doc().set(user);
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

  Future<void> getDocumentsInDateRange() async {
    String collectionName = 'Urunler';

    QuerySnapshot querySnapshot = await db
        .collection(collectionName)
        .where('TimeStamp',
            isGreaterThanOrEqualTo:
                Timestamp.fromDate(DateTime.now().subtract(Duration(days: 1))))
        .where('TimeStamp',
            isLessThanOrEqualTo: Timestamp.fromDate(DateTime.now()))
        .where('Isım', isEqualTo: 'Ayse')
        .orderBy('TimeStamp', descending: true)
        .get();

    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      setState(() {});
      print(document.data());
    }
  }

  void setDataEkmek(String gelen, String uruntipi, String kacEkmek) async {
    final usersCollection = db.collection('Urunler');
    final user = {
      'Isım': gelen,
      'TimeStamp': DateTime.now(),
      'Ekmek Tipi': uruntipi,
      'Kac Ekmek': kacEkmek,
    };
    await usersCollection.doc().set(user);
  }

  void clear() {}

  @override
  Widget build(BuildContext context) {
    getData();
    getDocumentsInDateRange();

    final Stream<QuerySnapshot> _usersStream =
        FirebaseFirestore.instance.collection('Çalışanlar').snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: Center(
          child: Column(
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
          Container(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Uretim(
                      secilenUsta: secilen,
                    ),
                  ));
                },
                child: Text("Üretime Başla")),
          ),
          Container(
            child: ElevatedButton(
                onPressed: () {
                  deleteData(secilen);
                },
                child: Text("Sil")),
          ),
        ],
      )),
    );
  }
}
