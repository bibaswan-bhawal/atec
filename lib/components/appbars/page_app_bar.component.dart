import 'package:flutter/material.dart';

class PageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PageAppBar({super.key, required this.title});

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      titleSpacing: 24,
      title: Text(title),
      centerTitle: false,
      scrolledUnderElevation: 0,
      titleTextStyle: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
