import 'package:firebase_core/firebase_core.dart';
import 'package:firebasetest/services/auth_service.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final _tname = TextEditingController();
  final _temail = TextEditingController();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                child: Text("TEST"),
              ),
            ),
            Container(
              width: 300,
              height: 60,
              child: TextField(
                controller: _temail,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Deneme"),
              ),
            ),
            Container(
              width: 300,
              height: 60,
              child: TextField(
                controller: _tname,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Test"),
              ),
            ),
            ElevatedButton(
                onPressed: (() {
                  AuthService().signUp(context,
                      name: _temail.text,
                      email: _temail.text,
                      password: _tname.text);
                }),
                child: Text("Login"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
