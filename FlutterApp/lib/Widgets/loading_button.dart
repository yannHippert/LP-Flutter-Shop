import 'package:flutter/material.dart';
import 'package:flutter_sweater_shop/Utilities/styles.dart';

// ignore: must_be_immutable
class LoadingButton extends StatelessWidget {
  bool isLoading;
  final String label;
  final Function() onClick;

  LoadingButton(
      {super.key,
      required this.isLoading,
      required this.label,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [cBoxshadow],
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onClick,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: cBorderRadius,
            ),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              )
            : Text(
                label,
                style: Theme.of(context).textTheme.labelLarge,
              ),
      ),
    );
  }
}
