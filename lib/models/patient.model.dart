// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'patient.model.g.dart';
part 'patient.model.freezed.dart';

enum PatientType { manual, remote }

@freezed
sealed class Patient with _$Patient {
  const factory Patient({
    @JsonKey(name: 'first') required String firstName,
    @JsonKey(name: 'last') required String lastName,
    @Default(PatientType.remote) PatientType type,
  }) = _Patient;

  factory Patient.fromJson(Map<String, Object?> json) => _$PatientFromJson(json);
}
