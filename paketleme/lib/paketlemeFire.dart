import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:paketleme/paketlemeHesaplama.dart';

class PaketlemeFire extends StatefulWidget {
  final bool siyezTikli;
  final String siyezText;
  final bool tamBugdayTikli;
  final String tamBugdayText;
  final bool cavdarTikli;
  final String cavdarText;
  final String kim;
  PaketlemeFire({
    required this.siyezTikli,
    required this.siyezText,
    required this.tamBugdayTikli,
    required this.tamBugdayText,
    required this.cavdarTikli,
    required this.cavdarText,
    required this.kim,
  });

  @override
  State<PaketlemeFire> createState() => _PaketlemeFireState();
}

class _PaketlemeFireState extends State<PaketlemeFire> {
  TextEditingController siyezYanikController = TextEditingController();
  TextEditingController siyezParcalandiController = TextEditingController();
  TextEditingController siyezPismediController = TextEditingController();
  TextEditingController tambugdayYanikController = TextEditingController();
  TextEditingController tambugdayParcalandiController = TextEditingController();
  TextEditingController tambugdayPismediController = TextEditingController();
  TextEditingController cavdarYanikController = TextEditingController();
  TextEditingController cavdarParcalandiController = TextEditingController();
  TextEditingController cavdarPismediController = TextEditingController();
  bool siyezYanik = false;
  bool siyezParcalandi = false;
  bool siyezPismedi = false;
  bool tambugdayYanik = false;
  bool tambugdayParcalandi = false;
  bool tambugdayPismedi = false;
  bool cavdarYanik = false;
  bool cavdarParcalandi = false;
  bool cavdarPismedi = false;
  int siyezToplam = 0;
  int cavdarToplam = 0;
  int tamBugdayToplam = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.kim),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              child: Visibility(
                visible: widget.siyezTikli,
                child: Column(
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        border: Border.all(
                          color: Colors.red,
                          width: 4,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text("Siyez"),
                          Row(
                            children: [
                              Text("Yanık:"),
                              Checkbox(
                                value: siyezYanik,
                                onChanged: (value) {
                                  setState(() {
                                    siyezYanik = value!;
                                  });
                                },
                              ),
                              Visibility(
                                visible: siyezYanik,
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  child: TextField(
                                    controller: siyezYanikController,
                                    decoration: InputDecoration(
                                      hintText: 'Yanık',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Parçalandı:"),
                              Checkbox(
                                value: siyezParcalandi,
                                onChanged: (value) {
                                  setState(() {
                                    siyezParcalandi = value!;
                                  });
                                },
                              ),
                              Visibility(
                                visible: siyezParcalandi,
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  child: TextField(
                                    controller: siyezParcalandiController,
                                    decoration: InputDecoration(
                                      hintText: 'Parçalandı',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Pişmedi:"),
                              Checkbox(
                                value: siyezPismedi,
                                onChanged: (value) {
                                  setState(() {
                                    siyezPismedi = value!;
                                  });
                                },
                              ),
                              Visibility(
                                visible: siyezPismedi,
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  child: TextField(
                                    controller: siyezPismediController,
                                    decoration: InputDecoration(
                                      hintText: 'Pişmedi',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Visibility(
                visible: widget.tamBugdayTikli,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    border: Border.all(
                      color: Colors.red,
                      width: 4,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text("Tam Buğday"),
                      Row(
                        children: [
                          Text("Yanık:"),
                          Checkbox(
                            value: tambugdayYanik,
                            onChanged: (value) {
                              setState(() {
                                tambugdayYanik = value!;
                              });
                            },
                          ),
                          Visibility(
                            visible: tambugdayYanik,
                            child: Container(
                              width: 50,
                              height: 50,
                              child: TextField(
                                controller: tambugdayYanikController,
                                decoration: InputDecoration(
                                  hintText: 'Yanık',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Parçalandı:"),
                          Checkbox(
                            value: tambugdayParcalandi,
                            onChanged: (value) {
                              setState(() {
                                tambugdayParcalandi = value!;
                              });
                            },
                          ),
                          Visibility(
                            visible: tambugdayParcalandi,
                            child: Container(
                              width: 50,
                              height: 50,
                              child: TextField(
                                controller: tambugdayParcalandiController,
                                decoration: InputDecoration(
                                  hintText: 'Parçalandı',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Pişmedi:"),
                          Checkbox(
                            value: tambugdayPismedi,
                            onChanged: (value) {
                              setState(() {
                                tambugdayPismedi = value!;
                              });
                            },
                          ),
                          Visibility(
                            visible: tambugdayPismedi,
                            child: Container(
                              width: 50,
                              height: 50,
                              child: TextField(
                                controller: tambugdayPismediController,
                                decoration: InputDecoration(
                                  hintText: 'Pişmedi',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              child: Visibility(
                visible: widget.cavdarTikli,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    border: Border.all(
                      color: Colors.red,
                      width: 4,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text("Çavdar"),
                      Row(
                        children: [
                          Text("Yanık:"),
                          Checkbox(
                            value: cavdarYanik,
                            onChanged: (value) {
                              setState(() {
                                cavdarYanik = value!;
                              });
                            },
                          ),
                          Visibility(
                            visible: cavdarYanik,
                            child: Container(
                              width: 50,
                              height: 50,
                              child: TextField(
                                controller: cavdarYanikController,
                                decoration: InputDecoration(
                                  hintText: 'Yanık',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Parçalandı:"),
                          Checkbox(
                            value: cavdarParcalandi,
                            onChanged: (value) {
                              setState(() {
                                cavdarParcalandi = value!;
                              });
                            },
                          ),
                          Visibility(
                            visible: cavdarParcalandi,
                            child: Container(
                              width: 50,
                              height: 50,
                              child: TextField(
                                controller: cavdarParcalandiController,
                                decoration: InputDecoration(
                                  hintText: 'Parçalandı',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Pişmedi:"),
                          Checkbox(
                            value: cavdarPismedi,
                            onChanged: (value) {
                              setState(() {
                                cavdarPismedi = value!;
                              });
                            },
                          ),
                          Visibility(
                            visible: cavdarPismedi,
                            child: Container(
                              width: 50,
                              height: 50,
                              child: TextField(
                                controller: cavdarPismediController,
                                decoration: InputDecoration(
                                  hintText: 'Pişmedi',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                siyezToplam = (widget.siyezTikli
                        ? int.tryParse(siyezYanikController.text) ?? 0
                        : 0) +
                    (widget.siyezTikli
                        ? int.tryParse(siyezParcalandiController.text) ?? 0
                        : 0) +
                    (widget.siyezTikli
                        ? int.tryParse(siyezPismediController.text) ?? 0
                        : 0);

                cavdarToplam = (widget.cavdarTikli
                        ? int.tryParse(cavdarParcalandiController.text) ?? 0
                        : 0) +
                    (widget.cavdarTikli
                        ? int.tryParse(cavdarYanikController.text) ?? 0
                        : 0) +
                    (widget.cavdarTikli
                        ? int.tryParse(cavdarPismediController.text) ?? 0
                        : 0);

                tamBugdayToplam = (widget.tamBugdayTikli
                        ? int.tryParse(tambugdayParcalandiController.text) ?? 0
                        : 0) +
                    (widget.tamBugdayTikli
                        ? int.tryParse(tambugdayYanikController.text) ?? 0
                        : 0) +
                    (widget.tamBugdayTikli
                        ? int.tryParse(tambugdayPismediController.text) ?? 0
                        : 0);

                siyezToplam = int.tryParse(widget.siyezText)! - siyezToplam;
                cavdarToplam = int.tryParse(widget.cavdarText)! - cavdarToplam;
                tamBugdayToplam =
                    int.tryParse(widget.tamBugdayText)! - tamBugdayToplam;

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PaketlemeHesaplama(
                      siyezHesaplanan: siyezToplam.toString(),
                      kim: widget.kim,
                      tamBugdayHesaplanan: tamBugdayToplam.toString(),
                      cavdarHesaplanan: cavdarToplam.toString(),
                    ),
                  ),
                );
              },
              child: Text("Devam Et"),
            ),
          ],
        ),
      ),
    );
  }
}
