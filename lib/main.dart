import 'package:atec/services/services.dart';
import 'package:atec/states/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:atec/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the provider container before initializing the app
  // to allow us to asynchronously load data before rendering the app.
  final container = ProviderContainer();

  final randomPatients = await RandomUserService.instance.fetchPatients();

  container.read(patientsStateNotifierProvider.notifier).setPatients(randomPatients);

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const App(),
    ),
  );
}
