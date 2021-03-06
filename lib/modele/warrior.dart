import 'dart:math';
import 'equipement.dart';

class Warrior {
  int _damage = 5;
  int _critChance = 5;
  int _level = 1;
  double _critMultiplier = 1.2;
  int _coins = 0;
  Equipement? _equipement;

  Warrior();

  Warrior.name(this._damage, this._critChance, this._level,
      this._critMultiplier, this._coins, this._equipement);

  @override
  String toString() {
    return 'Warrior{_damage: $_damage, _critChance: $_critChance, _level: $_level, _critMultiplier: $_critMultiplier, _coins: $_coins, _equipement: $_equipement}';
  }

  Warrior.fromJson(Map<String, dynamic> json)
      : _damage = json['_damage'],
        _critChance = json['_critChance'],
        _level = json['_level'],
        _critMultiplier = json['_critMultiplier'],
        _coins = json['_coins'],
        _equipement = (json['_equipement']!=null) ? Equipement.fromJson(json['_equipement']): null;


  Map<String, dynamic> toJson() => {
        '_damage': _damage,
        '_critChance': _critChance,
        '_level': _level,
        '_critMultiplier': _critMultiplier,
        '_coins': _coins,
        '_equipement':(_equipement != null ) ? _equipement!.toJson() : null,
      };

  Equipement? getEquipement() {
    return _equipement;
  }

  set equipement(Equipement value) {
    _equipement = value;
  }

  int get coins => _coins;

  set coins(int value) {
    _coins = value;
  }

  increaseCoins() {
    _coins += 2 + (_level / 50).floor();
  }

  buyEquipement(Equipement e) {
    if (!e.unlocked) {
      if (e.price <= _coins && e.level <= _level) {
        _coins -= e.price;
        e.unlocked=true;
        equipement=e;
      }
    }else{
      equipement=e;
    }
  }

  increaseDamage() {
    if (_coins > 0) {
      _damage += 1;
      _coins -= 1;
    }
  }



  increaseCritChance() {
    if (_coins > 1) {
      _critChance += 1;
      _coins -= 2;
    }
  }

  increaseCritMultiplier() {
    if (_coins > 2) {
      _critMultiplier = ((_critMultiplier + 0.1) * 10).roundToDouble() / 10;
      _coins -= 3;
    }
  }

  increaseLevel() {
    _level += 1;
  }

  int getDamage() {
    return _damage;
  }

  int getCritChance() {
    return _critChance;
  }

  double getCritMultiplier() {
    return _critMultiplier;
  }

  String getDamageString() {
    String damage=_damage.toString();
    if(_equipement!=null) {
      damage+=' + ('+_equipement!.damage.toString()+')';
    }
    return damage;
  }

  String getCritChanceString() {
    String critChance=_critChance.toString();
    if(_equipement!=null) {
      critChance+=' + ('+_equipement!.critChance.toString()+')';
    }
    return critChance;
  }

  String getCritMultiplierString() {
    return _critMultiplier.toString();
  }

  int getLevel() {
    return _level;
  }

  double getHit() {
    var rng = Random();
    int critchance = _critChance;
    double leftCrit = critchance % 100;
    double nbCrit = (critchance / 100).floorToDouble();
    double crit = rng.nextInt(100).toDouble();
    double hit = _damage.toDouble();
    if (_equipement != null) {
      critchance = critchance + _equipement!.critChance;
      hit = hit + _equipement!.damage.toDouble();
    }

    if (nbCrit != 0) {
      hit = hit * pow(_critMultiplier, nbCrit + 1).toDouble();
    }
    if (crit < leftCrit) {
      hit *= _critMultiplier;
    }
/*
    print('Original dmg : '+_damage.toString());
    print('leftCrit : '+leftCrit.toString() );
    print('critchance : '+_critChance.toString());
    print('crit to attain : '  +crit.toString());
    print('nbCrit : '+nbCrit.toString());
*/
    return hit;
  }
}
