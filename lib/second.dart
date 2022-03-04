import 'package:flutter/material.dart';
import 'modele/warrior.dart';
import 'modele/equipement.dart';

class MySecondScreen extends StatefulWidget {
  MySecondScreen(this.warrior, this.equipements, {Key? key}) : super(key: key);

  // Un StatefulWidget est immuable, la variable compteur est donc constante
  Warrior warrior;
  List<Equipement> equipements;

  @override
  State<MySecondScreen> createState() => _MySecondScreenState();
}

class _MySecondScreenState extends State<MySecondScreen> {
  // variable d'état qui, elle, peut être modifiée
  Warrior _warrior = Warrior();
  List<Equipement> _equipements = [];

  // Fonction appelée automatiquement à la création de l'état
  // On initialise le warrior avec la donnée reçue par le widget
  @override
  initState() {
    _warrior = widget.warrior;
    _equipements = widget.equipements;
    super.initState();
  }

  // Retour à l'écran principal avec renvoi
  void onClicRetour() {
    Navigator.pop(context, [_warrior,_equipements]);
  }

  void reset() {
    setState(() {
      _warrior = Warrior(); Navigator.pop(context, [_warrior,_equipements]);
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

  void _BuyEquip(Equipement equipement) {
    setState(() {
      equipement.unlocked = true;
      _warrior.equipement = equipement;

      //_equipements=_equipements;
    });
  }

  void _increaseCritMultiplier() {
    setState(() {
      _warrior.increaseCritMultiplier();
    });
  }

  Widget _buildPopupDialog(BuildContext context, Equipement element) {
    return AlertDialog(
      title: const Text('Weapon info :'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'minimal Level : ' + element.level.toString(),
              style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontFamily: 'Open Sans',
                fontSize: 15,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'Damage : ' + element.damage.toString(),
              style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontFamily: 'Open Sans',
                fontSize: 15,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'Additionnal crit chance: ' + element.critChance.toString(),
              style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontFamily: 'Open Sans',
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }

  List<Widget> _Equipment() {
    List<Widget> list = [];
    for (var element in _equipements) {
      MaterialColor color = Colors.grey;
      String buy = 'Buy';
      if (element.unlocked) {
        color = Colors.green;
        buy = 'Equip';
      }
      if (_warrior.getEquipement() == element) {
        color = Colors.lightBlue;
      }

      list.add(
        Container(
          width: 150,
          height: 150,
          padding: const EdgeInsets.only(top: 10),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(
            color: color,
            width: 2,
          )),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Prix : ' + element.price.toString()),
              Container(
                padding: const EdgeInsets.only(top: 15),
                child: Image.asset(
                  element.imgLink,
                ),
                constraints: const BoxConstraints(
                  maxHeight: 60,
                  maxWidth: 75,
                ),
              ),
              Wrap(
                spacing: 2,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _BuyEquip(element);
                    },
                    child: Text(buy),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        textStyle: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _BuyEquip(element);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialog(context, element),
                      );
                    },
                    child: const Text('Info'),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        textStyle: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }

    return list;
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
          Navigator.pop(context,[_warrior,_equipements]);
          return false;
        },
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Coins available : ' + _warrior.coins.toString(),
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Open Sans',
                      fontSize: 40),
                ),
                Container(
                  width: 350,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.lightBlue,
                    ),
                  ),
                  child: Center(
                    child: Wrap(
                      direction: Axis.vertical,
                      alignment: WrapAlignment.spaceEvenly,
                      spacing: 10,
                      children: [
                        Wrap(
                          alignment: WrapAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 0, top: 12, right: 0, bottom: 0),
                              child: Text(
                                'Damage : ' + _warrior.getDamageString(),
                                style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontFamily: 'Open Sans',
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: _increaseDamage,
                              icon: const Icon(
                                Icons.add,
                                color: Colors.lightGreen,
                                size: 30,
                                semanticLabel: 'increase critical multiplier ',
                              ),
                              splashRadius: 1,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                        Wrap(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 0, top: 12, right: 0, bottom: 0),
                              child: Text(
                                'Critical multiplier : ' +
                                    _warrior.getCritMultiplierString(),
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    fontFamily: 'Open Sans',
                                    fontSize: 20),
                              ),
                            ),
                            IconButton(
                              onPressed: _increaseCritMultiplier,
                              constraints: const BoxConstraints(),
                              icon: const Icon(
                                Icons.add,
                                color: Colors.lightGreen,
                                size: 30,
                                semanticLabel: 'increase critical multiplier ',
                              ),
                            ),
                          ],
                        ),
                        Wrap(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 0, top: 12, right: 0, bottom: 0),
                              child: Text(
                                'Critical chance : ' +
                                    _warrior.getCritChanceString(),
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    fontFamily: 'Open Sans',
                                    fontSize: 20),
                              ),
                            ),
                            IconButton(
                              onPressed: _increaseCritChance,
                              constraints: const BoxConstraints(),
                              icon: const Icon(
                                Icons.add,
                                color: Colors.lightGreen,
                                size: 30,
                                semanticLabel: 'increase critical multiplier ',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  'Equipements : ',
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Open Sans',
                      fontSize: 40),
                ),
                Flexible(
                  child: Wrap(
                    children: _Equipment(),
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
