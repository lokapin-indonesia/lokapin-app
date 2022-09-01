import 'package:flutter/foundation.dart';

class PetModels {
  final String? id;
  final String? name;
  final String? image;
  final String? breeds;
  final String? gender;
  final int? weight;
  final DateTime? birthDate;
  final DateTime? vaccinationActivity;
  final DateTime? medicalCheckUpActivity;

  PetModels({
    @required this.id,
    @required this.name,
    @required this.image,
    @required this.breeds,
    @required this.gender,
    @required this.weight,
    @required this.birthDate,
    @required this.vaccinationActivity,
    @required this.medicalCheckUpActivity,
  });
}
