import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'second.dart';
import 'modele/warrior.dart';
import 'modele/enemy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          appId: '1:457715692972:android:214bd8a20cf03a92753609',
          apiKey: 'AIzaSyCJqgGTVanOWWPZJ3DK7-gfZCb5HIj3-YM',
          messagingSenderId: 'my_messagingSenderId',
          projectId: 'projetflutter-8ef69'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  Enemy _enemy = Enemy(10, 10, 0, 'images/ghost.png');
  double _percentage = 1;
  double _heatlh = 100;

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
      _percentage = _enemy.getPercentageHealth();
    });
    if (_enemy.isDead()) {
      setState(() {
        _percentage = 1;
        _enemy = Enemy(10, 10, 0, 'images/slime.png');
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
              'You re fighting a : ',
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
