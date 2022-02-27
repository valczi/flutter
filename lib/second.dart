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
  // On initialise le warrior avec la donnée reçue par le widget
  @override
  initState() {
    _warrior = widget.warrior;
    super.initState();
  }

  // Retour à l'écran principal avec renvoi
  void onClicRetour() {
    Navigator.pop(context, _warrior);
  }

  void reset() {
    setState(() {
      _warrior = Warrior();
    });

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
      _warrior.increaseCritMultiplier();
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
        child: SingleChildScrollView(
          child: Center(
    child:Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Coins available : ' +
                    _warrior.coins.toString(),
                style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Open Sans',
                    fontSize: 40),
              ),
              Text(
                'Damage : ' + _warrior.getDamage().toString(),
                style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Open Sans',
                    fontSize: 20),
              ),
              IconButton(
                onPressed: _increaseDamage,
                icon: const Icon(
                  Icons.add,
                  color: Colors.grey,
                  size: 30,
                  semanticLabel: 'increase critical multiplier ',
                ),
              ),
              Text(
                'Critical multiplier : ' +
                    _warrior.getCritMultiplier().toString(),
                style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Open Sans',
                    fontSize: 20),
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
              Text(
                'Critical chance : ' + _warrior.getCritChance().toString(),
                style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Open Sans',
                    fontSize: 20),
              ),
              IconButton(
                onPressed: _increaseCritChance,
                icon: const Icon(
                  Icons.add,
                  color: Colors.grey,
                  size: 30,
                  semanticLabel: 'increase critical multiplier ',
                ),
              ),
            ],
          ),
          ),
        ),
      ),
    );
  }
}
