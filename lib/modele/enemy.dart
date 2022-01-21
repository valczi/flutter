class Enemy {
  double health;
  double maxHealth;
  double defence;
  String imgLink;

  Enemy(this.health, this.maxHealth, this.defence, this.imgLink);

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

  getDefence() {
    return defence;
  }

  getImageLink() {
    return imgLink;
  }

  double getPercentageHealth() {
    return health * maxHealth / 100.0;
  }
}
