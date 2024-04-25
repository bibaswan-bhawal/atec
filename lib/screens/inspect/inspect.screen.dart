import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import 'package:atec/theme/theme.dart';

class InspectScreen extends StatelessWidget {
  const InspectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          PhotoView(
            imageProvider: const AssetImage("assets/images/spine_image.png"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Chip(
              backgroundColor: AppColors.gray[25],
              label: const Text("Pinch and Drag to move around "),
            ),
          ),
        ],
      ),
    );
  }
}
