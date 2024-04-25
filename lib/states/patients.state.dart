import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:atec/models/models.dart';

part 'patients.state.g.dart';

@Riverpod(keepAlive: true)
class PatientsStateNotifier extends _$PatientsStateNotifier {
  @override
  List<Patient> build() => <Patient>[];

  void addPatient(Patient patient) {
    state = [patient, ...state];
  }

  void removePatient(Patient patient) {
    state = state.where((p) => p != patient).toList();
  }

  void setPatients(List<Patient> patients) {
    state = patients;
  }
}

@riverpod
List<Patient> paginatedPatients(PaginatedPatientsRef ref) {
  final patients = ref.watch(patientsStateNotifierProvider);
  final page = ref.watch(patientsListPageNotiferProvider);

  if (patients.length <= 25) return patients;

  final itemCount = ((page) * 25) > patients.length ? patients.length : (page) * 25;

  return patients.take(itemCount).toList();
}

@riverpod
class PatientsListPageNotifer extends _$PatientsListPageNotifer {
  @override
  int build() => 1;

  void nextPage() {
    state += 1;
  }

  void previousPage() {
    if (state > 1) state -= 1;
  }
}
