import 'dart:math';

class Equipement {
  int damage=0;
  int critChance=0;
  double level=0;
  String imgLink='';
  bool unlocked=false;
  int price=0;
  String name='';



  Equipement(this.damage, this.critChance, this.level, this.price,this.imgLink,this.name);

  Equipement.fromJson(Map<String, dynamic> json)
      : damage = json['_damage'],
        critChance = json['_critChance'],
        level=json['_level'],
        imgLink=json['_imgLink'],
        price=json['_price'],
        unlocked=json['_unlocked'],
        name=json['_name'];

  Map<String, dynamic> toJson() => {
    '_damage': damage,
    '_critChance': critChance,
    '_level': level,
    '_imgLink': imgLink,
    '_price':price,
    '_unlocked':unlocked,
    '_name':name,
  };

  @override
  String toString() {
    return 'Equipement{damage: $damage, critChance: $critChance, level: $level, imgLink: $imgLink, unlocked: $unlocked, price: $price, name: $name}';
  }
}