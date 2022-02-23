import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'second.dart';
import 'modele/warrior.dart';
import 'modele/enemy.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fighting game',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: _fbApp,
        builder:(context,snapshot){
          if(snapshot.hasError) {
            print('You have an error! ${snapshot.error.toString()}');
            return Text('Error');
          }else if (snapshot.hasData){
            return MyHomePage(title: 'Here to fight montser !');
          }else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      )
      //const
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Warrior _warrior = Warrior();
  final _database = FirebaseDatabase.instance.ref();

  Enemy _enemy = Enemy('ghost',10, 10, 0, 'assets/images/ghost.png');
  double _percentage = 1;
  late File jsonFile;
  bool fileExist=false;
  late Directory dir;
  final String fileName='warrior.json';
  String fileContent="reading file";

  @override
  void initState(){
    super.initState();
    getApplicationDocumentsDirectory().then((Directory directory){
      dir=directory;
      jsonFile=new File(dir.path + '/' + fileName);
      fileExist= jsonFile.existsSync();
      if(fileExist){
       setState(() {
         Map<String, dynamic> userMap = jsonDecode(jsonFile.readAsStringSync());
         //print(fileContent);
         _warrior=Warrior.fromJson(userMap);
       });
      }
    });
  }

  File createFile(Map<String,dynamic> content){
    print('Creating file');
    File file = File(dir.path+ '/' +fileName);
    file.createSync();
    fileExist=true;
    file.writeAsStringSync(json.encode(content));
    return file;
  }

  void writeToFile(){
    if(fileExist){
      print('Writing in file');
      jsonFile.writeAsStringSync(json.encode(_warrior));
      print(json.decode(jsonFile.readAsStringSync()));
    }else{
      createFile(_warrior.toJson());
    }
  }




  void _incrementCounter() {
    setState(() {
      double hit = _warrior.getHit();
      _enemy.beHit(hit);
    });
    _percentageHealth();
  }

  void _onClicEnvoi() {
    _appelEcranSuivant();
  }

  // Appel du second écran et attente du résultat
  void _appelEcranSuivant() async {
    Warrior result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => MySecondScreen(_warrior)));

    setState(() {
      _warrior = result;
    });
  }

  void _percentageHealth() {
    setState(() {
      print(_enemy.getPercentageHealth());
      print(_warrior.getLevel());
      _percentage = _enemy.getPercentageHealth()/100;
    });
    if (_enemy.isDead()) {
      setState(() {
        _percentage = 1;
        _warrior.increaseLevel();
        double level=_warrior.getLevel().toDouble();
        _enemy = Enemy('slime' ,10+level, 10+level, 0, 'assets/images/slime.png');
        writeToFile();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You\'re fighting a : '+_enemy.getName(),
              style: Theme.of(context).textTheme.headline4,
            ),
            LinearProgressIndicator(
              value: _percentage,
              backgroundColor: Colors.black,
              color: Colors.red,
            ),
            IconButton(
              icon: Image.asset(_enemy.imgLink),
              onPressed: _incrementCounter,
              iconSize: 200,
            ),
            ElevatedButton(
              onPressed: _onClicEnvoi,
              child: const Text('Profile'),
            )
          ],
        ),
      ),
    );
  }
}
