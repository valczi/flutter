class Enemy {
  double health;
  double maxHealth;
  double defence;
  String imgLink;
  String name;

  Enemy(this.name,this.health, this.maxHealth, this.defence, this.imgLink);

  beHit(double dmg) {
    if (defence < dmg) health -= double.parse((dmg - defence).toStringAsFixed(0));
  }


  isDead() {
    if (health <= 0) return true;
    return false;
  }

  getHealth() {
    return health;
  }

  getMaxHealth() {
    return maxHealth;
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

  getToLevel(double level){
    health*=((level+9+(level/50).floorToDouble())/10);
    health=double.parse(( health ).toStringAsFixed(0));
    maxHealth=health;
    defence*=level/25;
    defence=double.parse(( defence ).toStringAsFixed(0));
  }

  Enemy.fromJson(Map<String, dynamic> json)
      : health = json['stats'][0]['base_stat'].toDouble(),
        maxHealth= json['stats'][0]['base_stat'].toDouble(),
        defence = double.parse(( (json['weight'].toDouble()/100)).toStringAsFixed(1)),
        imgLink=json['sprites']['front_default'],
        name=json['name'];

  @override
  String toString() {
    return 'Enemy{health: $health, maxHealth: $maxHealth, defence: $defence, imgLink: $imgLink, name: $name}';
  }
}
