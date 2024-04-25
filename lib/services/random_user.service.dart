import 'dart:convert';

import 'package:atec/models/patient.model.dart';
import 'package:dio/dio.dart';

class RandomUserService {
  final Dio _dio = Dio();

  static RandomUserService? _instance;

  static RandomUserService get instance => _instance ??= RandomUserService._();

  RandomUserService._() {
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 5);
  }

  Future<List<Patient>> fetchPatients() async {
    final response = await _dio.get('https://randomapi.com/api/6de6abfedb24f889e0b5f675edc50deb?fmt=raw&sole');
    final List<Patient> patients = jsonDecode(response.data).map<Patient>((e) => Patient.fromJson(e)).toList();

    return patients.getRange(0, 50).toList();
  }
}
