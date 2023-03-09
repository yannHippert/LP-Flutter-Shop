import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoadingOverlay extends StatelessWidget {
  String? message;

  LoadingOverlay({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white24,
      child: Center(
        child: Column(
          children: [
            message != null ? Text(message!) : const SizedBox.shrink(),
            const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 5,
            ),
          ],
        ),
      ),
    );
  }
}
