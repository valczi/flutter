import 'dart:math';

class Warrior {
  int damage = 1;
  int critChance = 5;
  int level=1;
  double critMultiplier = 1.2;

  Warrior();

  Warrior.fromJson(Map<String, dynamic> json)
      : damage = json['damage'],
        critChance = json['critChance'],
        level=json['level'],
        critMultiplier=json['critMultiplier'];

  Map<String, dynamic> toJson() => {
    'damage': damage,
    'critChance': critChance,
    'level': level,
    'critMultiplier': critMultiplier,
  };

  increaseDamage() {
    damage += 1;
  }

  increaseCritChance() {
    critChance += 1;
  }

  increasecritMultiplier() {
    critMultiplier = ((critMultiplier + 0.1) * 10).roundToDouble() / 10;
  }

  increaseLevel() {
    level+=1;
  }

  int getDamage() {
    return damage;
  }

  int getCritChance() {
    return critChance;
  }

  double getCritMultiplier() {
    return critMultiplier;
  }

  int getLevel() {
    return level;
  }

  double getHit() {
    var rng = Random();
    double crit = rng.nextInt(1000).toDouble();

    double hit = damage.toDouble();
    if (crit < critChance * 10) hit += damage;

    return hit;
  }
}
