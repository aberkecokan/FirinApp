import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:paketleme/paketlemefire.dart';

class Paketleme extends StatefulWidget {
  final String secilenUsta;

  Paketleme({
    required this.secilenUsta,
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

  bool siyezTikli = false;
  bool tamBugdayTikli = false;
  bool cavdarTikli = false;

  TextEditingController siyezController = TextEditingController();
  TextEditingController tamBugdayController = TextEditingController();
  TextEditingController cavdarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paketleme Sayfası'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(
                  value: siyezTikli,
                  onChanged: (value) {
                    setState(() {
                      siyezTikli = value!;
                      if (!siyezTikli) {
                        siyezController.clear();
                      }
                    });
                  },
                ),
                Text("Siyez"),
                if (siyezTikli)
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: SizedBox(
                      width: 150,
                      child: TextField(
                        controller: siyezController,
                        enabled: true,
                        decoration: InputDecoration(
                          hintText: 'Buraya yazılabilir',
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: tamBugdayTikli,
                  onChanged: (value) {
                    setState(() {
                      tamBugdayTikli = value!;
                      if (!tamBugdayTikli) {
                        tamBugdayController.clear();
                      }
                    });
                  },
                ),
                Text("Tam Buğday"),
                if (tamBugdayTikli)
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: SizedBox(
                      width: 150,
                      child: TextField(
                        controller: tamBugdayController,
                        enabled: true,
                        decoration: InputDecoration(
                          hintText: 'Buraya yazılabilir',
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: cavdarTikli,
                  onChanged: (value) {
                    setState(() {
                      cavdarTikli = value!;
                      if (!cavdarTikli) {
                        cavdarController.clear();
                      }
                    });
                  },
                ),
                Text("Çavdar"),
                if (cavdarTikli)
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: SizedBox(
                      width: 150,
                      child: TextField(
                        controller: cavdarController,
                        enabled: true,
                        decoration: InputDecoration(
                          hintText: 'Buraya yazılabilir',
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PaketlemeFire(
                            siyezTikli: siyezTikli,
                            siyezText: siyezTikli ? siyezController.text : "0",
                            tamBugdayTikli: tamBugdayTikli,
                            tamBugdayText:
                                tamBugdayTikli ? tamBugdayController.text : "0",
                            cavdarTikli: cavdarTikli,
                            cavdarText:
                                cavdarTikli ? cavdarController.text : "0",
                            kim: widget.secilenUsta,
                          )));
                },
                child: Text("Devam Et"))
          ],
        ),
      ),
    );
  }
}
