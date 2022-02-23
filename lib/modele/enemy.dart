class Enemy {
  double health;
  double maxHealth;
  double defence;
  String imgLink;
  String name;

  Enemy(this.name,this.health, this.maxHealth, this.defence, this.imgLink);

  beHit(double dmg) {
    if (defence < dmg) health -= (dmg - defence);
  }

  isDead() {
    if (health <= 0) return true;
    return false;
  }

  getHealth() {
    return health;
  }
  getName() {
    return name;
  }

  getDefence() {
    return defence;
  }

  getImageLink() {
    return imgLink;
  }

  double getPercentageHealth() {
    return health * 100.0 / maxHealth;
  }
}
