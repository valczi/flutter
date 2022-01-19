import 'dart:math';

class Warrior {
  int damage = 1;
  int critChance = 5;
  double critMultiplier = 1.2;

  Warrior();

  increaseDamage() {
    damage += 1;
  }

  increaseCritChance() {
    critChance += 1;
  }

  increasecritMultiplier() {
    critMultiplier = ((critMultiplier + 0.1) * 10).roundToDouble() / 10;
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

  double getHit() {
    var rng = Random();
    double crit = rng.nextInt(1000).toDouble();

    double hit = damage.toDouble();
    if (crit < critChance * 10) hit += damage;
    return hit;
  }
}
