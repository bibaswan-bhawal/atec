import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:atec/models/models.dart';

part 'patients.state.g.dart';

@Riverpod(keepAlive: true)
class PatientsStateNotifier extends _$PatientsStateNotifier {
  @override
  List<Patient> build() => <Patient>[];

  void addPatient(Patient patient) {
    state = [...state, patient];
  }

  void removePatient(Patient patient) {
    state = state.where((p) => p != patient).toList();
  }
}
