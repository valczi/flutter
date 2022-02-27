import 'dart:math';

class Warrior {
  int _damage = 5;
  int _critChance = 5;
  int _level=1;
  double _critMultiplier = 1.2;
  int _coins=0;

  Warrior();



  Warrior.fromJson(Map<String, dynamic> json)
      : _damage = json['_damage'],
        _critChance = json['_critChance'],
        _level=json['_level'],
        _critMultiplier=json['_critMultiplier'],
        _coins=json['_coins'];

  Map<String, dynamic> toJson() => {
    '_damage': _damage,
    '_critChance': _critChance,
    '_level': _level,
    '_critMultiplier': _critMultiplier,
    '_coins':_coins,
  };

  int get coins => _coins;

  set coins(int value) {
    _coins = value;
  }

  increaseCoins(){
    _coins+=1+(_level/50).floor();
  }

  increaseDamage() {
    if(_coins>0) {
      _damage += 1;
      _coins-=1;
    }
  }

  increaseCritChance() {
    if(_coins>0) {
      _critChance += 1;
      _coins-=1;
    }
  }

  increaseCritMultiplier() {
    if(_coins>0) {
      _critMultiplier = ((_critMultiplier + 0.1) * 10).roundToDouble() / 10;
      _coins-=1;
    }
  }

  increaseLevel() {
    _level+=1;
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

  int getLevel() {
    return _level;
  }

  double getHit() {
    var rng = Random();
    double leftCrit=_critChance%100;
    double nbCrit=(_critChance/100).floorToDouble();
    double crit = rng.nextInt(100).toDouble();
    double hit = _damage.toDouble();
    if(nbCrit!=0) {
      hit=hit*pow(_critMultiplier, nbCrit+1).toDouble();
    }
    if(crit<leftCrit) {
      hit*=_critMultiplier;
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
