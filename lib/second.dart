import 'package:flutter/material.dart';
import 'modele/warrior.dart';

class MySecondScreen extends StatefulWidget {
  MySecondScreen(this.warrior, {Key? key}) : super(key: key);

  // Un StatefulWidget est immuable, la variable compteur est donc constante
  Warrior warrior;

  @override
  State<MySecondScreen> createState() => _MySecondScreenState();
}

class _MySecondScreenState extends State<MySecondScreen> {
  // variable d'état qui, elle, peut être modifiée
  Warrior _warrior = Warrior();

  // Fonction appelée automatiquement à la création de l'état
  // On initialise le compteur avec la donnée reçue par le widget
  @override
  initState() {
    _warrior = widget.warrior;
    super.initState();
  }

  // Retour à l'écran principal avec renvoi du compteur
  void onClicRetour() {
    Navigator.pop(context, _warrior);
  }

  void reset() {
    _warrior = Warrior();
  }

  void _increaseDamage() {
    setState(() {
      _warrior.increaseDamage();
    });
  }

  void _increaseCritChance() {
    setState(() {
      _warrior.increaseCritChance();
    });
  }

  void _increaseCritMultiplier() {
    setState(() {
      _warrior.increasecritMultiplier();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        Padding(
          padding: const EdgeInsets.only(right: 40),
          child: IconButton(
            icon: const Icon(Icons.autorenew),
            tooltip: 'Reinialisation',
            onPressed: reset,
          ),
        ),
      ]),
      body:
          // Gestion du bouton back de l'appBar ET du téléphone
          WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, _warrior);
          return false;
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
                  child: Wrap(
                      direction: Axis.vertical,
                      spacing: 30,
                      children: <Widget>[
                        Text(
                          'Degat : ' + _warrior.getDamage().toString(),
                        ),
                        IconButton(
                          onPressed: _increaseDamage,
                          icon: const Icon(
                            Icons.add,
                            color: Colors.grey,
                            size: 30,
                            semanticLabel: 'increase damage',
                          ),
                        ),
                        Text(
                          'Chance de critique : ' +
                              _warrior.getCritChance().toString(),
                        ),
                        IconButton(
                          onPressed: _increaseCritChance,
                          icon: const Icon(
                            Icons.add,
                            color: Colors.grey,
                            size: 30,
                            semanticLabel: 'increase critical chance',
                          ),
                        ),
                        Text(
                          'Multiplicateur critique : ' +
                              _warrior.getCritMultiplier().toString(),
                        ),
                        IconButton(
                          onPressed: _increaseCritMultiplier,
                          icon: const Icon(
                            Icons.add,
                            color: Colors.grey,
                            size: 30,
                            semanticLabel: 'increase critical multiplier ',
                          ),
                        ),
                      ]),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: onClicRetour,
                    child: const Text('Retour'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
