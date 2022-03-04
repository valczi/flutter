import 'dart:convert';

import 'package:http/http.dart' as http;
import '../modele/enemy.dart';
import 'dart:math';

class PokemonChoser{

  Future<Enemy> getPokemon() async{
    var rng = Random();
    var response= await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/'+rng.nextInt(600).toString()));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Enemy.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }


}