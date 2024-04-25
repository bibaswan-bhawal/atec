import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:atec/theme/theme.dart';
import 'package:atec/models/models.dart';
import 'package:atec/states/states.dart';
import 'package:atec/components/components.dart';

class PatientsScreen extends ConsumerStatefulWidget {
  const PatientsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends ConsumerState<PatientsScreen> {
  final FocusNode _searchfocusNode = FocusNode();

  Widget? _buildRecents(BuildContext context, int index) {
    final recentPatients = ref.read(patientsStateNotifierProvider).where((client) => client.type == PatientType.manual).toList();

    final client = recentPatients[index];

    return Column(
      children: [
        CircleAvatar(
          radius: 38,
          backgroundColor: AppColors.gray[100]!,
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onLongPress: () {},
              borderRadius: BorderRadius.circular(38),
              child: SizedBox(
                width: 76,
                height: 76,
                child: Center(
                  child: Text(
                    '${client.firstName.characters.first}${client.lastName.characters.first}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.accent),
                  ),
                ),
              ),
            ),
          ),
        ),
        const Gap(8),
        Text(
          '${client.firstName} ${client.lastName.characters.first}.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget? _buildPatients(BuildContext context, int index) {
    final patient = ref.read(paginatedPatientsProvider)[index];

    return Dismissible(
      key: ValueKey(patient),
      onDismissed: (direction) {
        ref.read(patientsStateNotifierProvider.notifier).removePatient(patient);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${patient.firstName} ${patient.lastName} removed'),
          ),
        );
      },
      background: Container(
        padding: const EdgeInsets.only(right: 24),
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerRight,
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
      child: ListTile(
        onTap: () => _dismissKeyboard(),
        title: Text('${patient.firstName} ${patient.lastName}'),
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      ),
    );
  }

  void _dismissKeyboard() => _searchfocusNode.unfocus();

  @override
  Widget build(BuildContext context) {
    final patientsProvider = ref.watch(patientsStateNotifierProvider);
    final paginatedPatients = ref.watch(paginatedPatientsProvider);

    final recentPatients = patientsProvider.where((client) => client.type == PatientType.manual).toList();

    return Scaffold(
      appBar: const PageAppBar(title: 'Patients'),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: SearchAnchor(
                      isFullScreen: true,
                      viewSurfaceTintColor: Colors.transparent,
                      dividerColor: AppColors.gray[200]!,
                      builder: (BuildContext context, SearchController controller) {
                        return SearchBar(
                          controller: controller,
                          focusNode: _searchfocusNode,
                          hintText: 'Search patients',
                          leading: const Icon(Icons.search),
                          onTap: () {
                            controller.openView();
                            _dismissKeyboard();
                          },
                          onChanged: (_) {
                            controller.openView();
                            _dismissKeyboard();
                          },
                          onSubmitted: (value) => _dismissKeyboard(),
                          elevation: const MaterialStatePropertyAll(0),
                          overlayColor: const MaterialStatePropertyAll<Color>(Colors.transparent),
                          surfaceTintColor: const MaterialStatePropertyAll<Color>(Colors.transparent),
                          backgroundColor: MaterialStateColor.resolveWith((states) => AppColors.gray[100]!),
                          padding: const MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(horizontal: 16.0)),
                          hintStyle: MaterialStatePropertyAll<TextStyle>(Theme.of(context).textTheme.labelLarge!.copyWith(color: AppColors.gray[500])),
                        );
                      },
                      suggestionsBuilder: (BuildContext context, SearchController controller) {
                        return patientsProvider
                            .where((client) => client.firstName.toLowerCase().contains(controller.text.toLowerCase()))
                            .map((client) => ListTile(
                                  title: Text('${client.firstName} ${client.lastName}'),
                                  onTap: () {
                                    controller.closeView('');
                                    controller.clear();
                                    _dismissKeyboard();
                                  },
                                ))
                            .toList();
                      },
                    ),
                  ),
                ),
                if (recentPatients.isNotEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                      child: Text('Recent', style: Theme.of(context).textTheme.titleLarge),
                    ),
                  ),
                if (recentPatients.isNotEmpty)
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 100,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: _buildRecents,
                        itemCount: recentPatients.length,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        separatorBuilder: (context, index) => const Gap(20),
                      ),
                    ),
                  ),
                if (recentPatients.isNotEmpty)
                  SliverToBoxAdapter(
                    child: Divider(height: 70, thickness: 8, color: AppColors.gray[100]!),
                  ),
                SliverList.separated(
                  itemBuilder: _buildPatients,
                  itemCount: paginatedPatients.length,
                  separatorBuilder: (context, index) => Divider(height: 0, indent: 24, endIndent: 24, color: AppColors.gray[200]!),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        children: [
                          if (paginatedPatients.length > 25)
                            Expanded(
                              child: TextButton(
                                onPressed: () => ref.read(patientsListPageNotiferProvider.notifier).previousPage(),
                                style: TextButton.styleFrom(foregroundColor: AppColors.gray[900]),
                                child: const Text('See less'),
                              ),
                            ),
                          if (patientsProvider.length > 25 && paginatedPatients.length != patientsProvider.length)
                            Expanded(
                              child: TextButton(
                                onPressed: () => ref.read(patientsListPageNotiferProvider.notifier).nextPage(),
                                style: TextButton.styleFrom(foregroundColor: AppColors.gray[900]),
                                child: const Text('See more'),
                              ),
                            ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
