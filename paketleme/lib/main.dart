import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:paketleme/firebase_options.dart';
import 'package:paketleme/paketleme.dart';
import 'package:paketleme/silme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Paketleme'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<String> ustalar = [];
  String secilen = "";
  String silinecekUsta = "";
  TextEditingController ustaController = TextEditingController();

  final db = FirebaseFirestore.instance;

  void setData(String gelen) async {
    final usersCollection = db.collection('Calisanlar');
    final user = {'Isım': gelen, 'TimeStamp': DateTime.now(), "Id": 0};
    await usersCollection.doc().set(user);
  }

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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                setState(() {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Paketleme(
                            secilenUsta: secilen,
                          )));
                });
              },
              child: Text("Bas"),
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
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {
                showDialog(
                    context: context,
                    builder: ((context) {
                      return AlertDialog(
                        title: Text("Usta Ekle"),
                        content: Column(
                          children: [
                            TextField(
                              controller: ustaController,
                            ),
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: ElevatedButton(
                                    onPressed: () {
                                      setData(ustaController.text);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Ustayı Kaydet")))
                          ],
                        ),
                      );
                    }));
              });
            },
            tooltip: 'Usta Ekle',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Silme()));
              });
            },
            tooltip: 'Usta Sil',
            child: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
}
