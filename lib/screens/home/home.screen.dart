import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:atec/theme/theme.dart';
import 'package:atec/utils/utils.dart';
import 'package:atec/models/models.dart';

class PatientIntakeForm {
  String _firstName = '';
  String _lastName = '';

  String get firstName => _firstName;
  String get lastName => _lastName;

  set firstName(String? value) => value != null ? _firstName = value : _firstName = '';
  set lastName(String? value) => value != null ? _lastName = value : _lastName = '';

  bool get isValid => _firstName.isNotEmpty && _lastName.isNotEmpty;

  Patient build() {
    assert(isValid, 'Patient intake form is not valid');
    return Patient(firstName: _firstName, lastName: _lastName, type: PatientType.manual);
  }
}

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final PatientIntakeForm _patientIntakeForm = PatientIntakeForm();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  void _submit() {
    final formState = _form.currentState!;
    if (formState.validate()) {
      // formState.save();
      if (kDebugMode) print('Patient: ${_patientIntakeForm.build()}');
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Gap(8),
                Center(
                  child: Container(
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                    child: Image.asset('assets/images/spine_image.png', fit: BoxFit.cover),
                  ),
                ),
                const Gap(20),
                Form(
                  key: _form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Add Patient', style: Theme.of(context).textTheme.titleLarge),
                      const Gap(8),
                      TextFormField(
                        enableSuggestions: false,
                        validator: Validators.isEmpty,
                        controller: _firstNameController,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        onSaved: (value) => _patientIntakeForm.firstName = value,
                        onChanged: (value) => setState(() => _patientIntakeForm.firstName = value),
                        decoration: InputDecoration(
                          label: const Text('First Name'),
                          hintText: 'John',
                          suffixIcon: _firstNameController.value.text.isNotEmpty
                              ? IconButton(
                                  onPressed: () => _firstNameController.clear(),
                                  icon: AppIcons.close_circle_gray,
                                )
                              : null,
                        ),
                      ),
                      const Gap(20.0),
                      TextFormField(
                        enableSuggestions: false,
                        validator: Validators.isEmpty,
                        controller: _lastNameController,
                        keyboardType: TextInputType.name,
                        onFieldSubmitted: (_) => _submit(),
                        textInputAction: TextInputAction.done,
                        onSaved: (value) => _patientIntakeForm.lastName = value,
                        onChanged: (value) => setState(() => _patientIntakeForm.lastName = value),
                        decoration: InputDecoration(
                          label: const Text('Last Name'),
                          hintText: 'Doe',
                          suffixIcon: _lastNameController.value.text.isNotEmpty
                              ? IconButton(
                                  onPressed: () => _lastNameController.clear(),
                                  icon: AppIcons.close_circle_gray,
                                )
                              : null,
                        ),
                      ),
                      const Gap(20.0),
                      FilledButton(onPressed: _submit, child: const Text('Add Patient')),
                      const Gap(20.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
