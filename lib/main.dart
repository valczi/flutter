import 'dart:io';
import 'package:flutter/material.dart';
import 'second.dart';
import 'modele/warrior.dart';
import 'modele/enemy.dart';
import 'api/pokemonChoser.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

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
        home: MyHomePage(title: 'Here to fight montser !'),
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
  Enemy _enemy=Enemy('Base entity', 10, 10, 0, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png');
  double _percentage = 1;
  late File jsonFile;
  bool fileExist = false;
  late Directory dir;
  final String fileName = 'warrior.json';
  String fileContent = "reading file";
  double _iconeSize = 200;
  PokemonChoser _Poke=PokemonChoser();

  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = new File(dir.path + '/' + fileName);
      fileExist = jsonFile.existsSync();
      if (fileExist) {
        setState(() {
          Map<String, dynamic> userMap =
              jsonDecode(jsonFile.readAsStringSync());
          //print(fileContent);
          _warrior = Warrior.fromJson(userMap);
          setNewPokemon();
        });
      }
    });
  }

  File createFile(Map<String, dynamic> content) {
    //print('Creating file');
    File file = File(dir.path + '/' + fileName);
    file.createSync();
    fileExist = true;
    file.writeAsStringSync(json.encode(content));
    return file;
  }

  void writeToFile() {
    if (fileExist) {
      //print('Writing in file');
      jsonFile.writeAsStringSync(json.encode(_warrior));
     // print(json.decode(jsonFile.readAsStringSync()));
    } else {
      createFile(_warrior.toJson());
    }
  }

  void setNewPokemon() async{
    Enemy poke = await _Poke.getPokemon();
    poke.getToLevel(_warrior.getLevel().toDouble());
    setState(() {
      _enemy = poke;

    });
  }

  void _getHit() {
    setState(() {
      double hit = _warrior.getHit();
      print('damage : '+hit.toString());
      _enemy.beHit(hit);
      _iconeSize=_iconeSize*0.8;
    });
    Future.delayed(const Duration(milliseconds: 150), () {
      setState(() {
        _iconeSize = 200;
      });
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
      //print(_enemy.getPercentageHealth());
      //print(_warrior.getLevel());
      _percentage = _enemy.getPercentageHealth() / 100;
    });
    if (_enemy.isDead()) {
      setState(() {
        _percentage = 1;
        _warrior.increaseLevel();
        _warrior.increaseCoins();
        setNewPokemon();
        writeToFile();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _getHit method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: IconButton(
              icon: const Icon(Icons.autorenew),
              tooltip: 'Reinialisation',
              onPressed: setNewPokemon,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You\'re fighting : ' + _enemy.getName(),
              style: Theme.of(context).textTheme.headline4,
            ),
            Wrap(
              spacing: 25,
              children: [
                Text(
                  'Max Life : '+ _enemy.getMaxHealth().toString(),
                  style: const TextStyle(
                    color: Colors.blueGrey,
                    decorationStyle: TextDecorationStyle.solid,
                    fontSize: 25,
                  ),
                ),
                Text(
                  'Defence :'+ _enemy.getDefence().toString(),
                  style:const TextStyle(
                    color: Colors.blueGrey,
                    decorationStyle: TextDecorationStyle.solid,
                    fontSize: 25,
                  ),
                ),
                Text(
                  'Life left '+ _enemy.getHealth().toString(),
                  style: const TextStyle(
                    color: Colors.blueGrey,
                    decorationStyle: TextDecorationStyle.solid,
                    fontSize: 25,
                  ),
                ),
                Text(
                  'level : '+_warrior.getLevel().toString(),
                  style: const TextStyle(
                    color: Colors.blueGrey,
                    decorationStyle: TextDecorationStyle.solid,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
            //Bar de vie des enemies
            LinearProgressIndicator(
              value: _percentage,
              backgroundColor: Colors.black,
              color: Colors.red,
            ),
            //Box pour l'animation des enemies
            SizedBox(
              width: 200,
              height: 200,
              child: Center(
                child: IconButton(
                  icon: Image.network(
                      _enemy.imgLink,
                    fit: BoxFit.fill,
                    width: 200,
                    height: 200,
                  ),
                  onPressed: _getHit,
                  iconSize: _iconeSize,
                  splashColor: Colors.redAccent,
                  splashRadius: 100,

                ),
              ),
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
