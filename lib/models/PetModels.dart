import 'package:flutter/foundation.dart';

class PetModels {
  final String? id;
  final String? hardwareId;
  final String? name;
  final String? photo;
  final String? species;
  final String? breed;
  final String? gender;
  final int? weight;
  final int? age;
  final String? lat;
  final String? long;
  final DateTime? lastUpdated;
  final DateTime? lastPing;

  PetModels({
    @required this.id,
    @required this.hardwareId,
    @required this.name,
    @required this.photo,
    @required this.species,
    @required this.breed,
    @required this.gender,
    @required this.weight,
    @required this.age,
    @required this.lat,
    @required this.long,
    @required this.lastUpdated,
    @required this.lastPing,
  });
}
