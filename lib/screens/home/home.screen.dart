import 'package:atec/router/routes.dart';
import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:atec/theme/theme.dart';
import 'package:atec/utils/utils.dart';
import 'package:atec/models/models.dart';
import 'package:atec/states/states.dart';

/* Model to store the patient intake form
*  data and verify if the form is valid and
*  build the patient object.
* */
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
  final GlobalKey<FormState> _form = GlobalKey<FormState>(); // key to form state

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();

  PatientIntakeForm _patientIntakeForm = PatientIntakeForm();

  // Validate form and show dialog
  void _submit() {
    final formState = _form.currentState!;
    if (formState.validate()) {
      formState.save();

      _showDialog();
    }
  }

  // Adds patient to the list and clears form.
  void _addPatient(BuildContext dialogContext) async {
    final patientsProvider = ref.read(patientsStateNotifierProvider.notifier);

    patientsProvider.addPatient(_patientIntakeForm.build());

    _patientIntakeForm = PatientIntakeForm();

    _form.currentState!.reset();

    _firstNameController.clear();
    _lastNameController.clear();

    _firstNameFocusNode.unfocus();
    _lastNameFocusNode.unfocus();

    Navigator.pop(dialogContext);
  }

  // Confirmation dialog to add patient
  Future<void> _showDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: AppColors.gray[900]!.withOpacity(0.6),
      builder: (context) => AlertDialog(
        title: const Text('Add new patient?'),
        content: Text('Do you want to add a new patient with the name ${_patientIntakeForm.firstName} ${_patientIntakeForm.lastName}?'),
        titleTextStyle: Theme.of(context).textTheme.headlineSmall,
        contentTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.gray[500]),
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.gray[25],
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(foregroundColor: AppColors.warning),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => _addPatient(context),
            style: TextButton.styleFrom(foregroundColor: AppColors.gray[900]),
            child: const Text('Add Patient'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: AppTheme.systemUiOverlayDark,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              reverse: true,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Gap(8),
                  Center(
                    child: Container(
                      width: double.infinity,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                      child: InkWell(
                        onTap: () => const InspectRoute().go(context),
                        child: Stack(
                          children: [
                            Image.asset('assets/images/spine_image.png', fit: BoxFit.cover),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Chip(
                                backgroundColor: AppColors.gray[900],
                                label: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AppIcons.magnify_plus_light,
                                    const Gap(8),
                                    Text(
                                      'Tap to enlarge',
                                      style: Theme.of(context).textTheme.labelLarge!.copyWith(color: AppColors.gray[25]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(20),
                  Form(
                    key: _form,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Add Patient', style: Theme.of(context).textTheme.titleLarge),
                        const Gap(20),
                        TextFormField(
                          enableSuggestions: false,
                          validator: Validators.isEmpty,
                          focusNode: _firstNameFocusNode,
                          controller: _firstNameController,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                          onSaved: (value) => _patientIntakeForm.firstName = value,
                          onChanged: (value) => setState(() => _patientIntakeForm.firstName = value),
                          onFieldSubmitted: (value) => FocusScope.of(context).nextFocus(),
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
                          focusNode: _lastNameFocusNode,
                          controller: _lastNameController,
                          onFieldSubmitted: (_) => _submit(),
                          textInputAction: TextInputAction.done,
                          textCapitalization: TextCapitalization.words,
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
      ),
    );
  }
}
