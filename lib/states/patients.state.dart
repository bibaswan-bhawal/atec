import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:atec/models/models.dart';

part 'patients.state.g.dart';

/*
* This is the state notifier for the patients
* It is used to manage the state of the patients.
* It is used to add, remove and set the patients
* */
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

/*
* Filtered patients state notifier uses the current requested page to
* limit the number of patients to be displayed
*/
@riverpod
List<Patient> paginatedPatients(PaginatedPatientsRef ref) {
  final patients = ref.watch(patientsStateNotifierProvider);
  final page = ref.watch(patientsListPageNotiferProvider);

  if (patients.length <= 25) return patients;

  final itemCount = ((page) * 25) > patients.length ? patients.length : (page) * 25;

  return patients.take(itemCount).toList();
}

/* Stores the current requested page of the patients list */
@riverpod
class PatientsListPageNotifer extends _$PatientsListPageNotifer {
  @override
  int build() => 1;

  void nextPage() => state += 1;

  void previousPage() {
    if (state > 1) state -= 1;
  }
}
