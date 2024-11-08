import 'dart:convert';

import 'package:hive/hive.dart';
import '../models/single_pokemon.dart';

class HiveInstance {
  HiveInstance._();

  static final HiveInstance shared = HiveInstance._();

  factory HiveInstance() {
    return shared;
  }

  Future<List<SinglePokemon>> getAllPokemons() async {
    final box = await Hive.openBox('secureHive');
    List<SinglePokemon> list = [];
    for (int i=0; i < box.length; i++) {
      final key = box.keyAt(i);
      final value = box.get(key);
      final singlePokemon = SinglePokemon.fromJson(jsonDecode(value));
      list.add(singlePokemon);
    }
    return list;
  }

  Future write({required String key, required String value}) async {
    final box = await Hive.openBox('secureHive');
    await box.put(key, value);
    await box.close();
  }

  Future<String?> read({required String key}) async {
    final box = await Hive.openBox('secureHive');
    final value = box.get(key);
    await box.close();
    return value;
  }

  Future<bool> containsKey({required String key}) async {
    final box = await Hive.openBox('secureHive');
    final contains = box.containsKey(key);
    await box.close();
    return contains;
  }

  Future<void> delete({required String key}) async {
    final box = await Hive.openBox('secureHive');
    await box.delete(key);
    await box.close();
  }

}