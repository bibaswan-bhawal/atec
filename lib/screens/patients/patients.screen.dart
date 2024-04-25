import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:atec/states/states.dart';
import 'package:atec/components/components.dart';

class PatientsScreen extends ConsumerStatefulWidget {
  const PatientsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends ConsumerState<PatientsScreen> {
  @override
  Widget build(BuildContext context) {
    // final patientsProvider = ref.watch(patientsStateNotifierProvider);

    return const Scaffold(
      appBar: PageAppBar(title: 'Patients'),
    );
  }
}
