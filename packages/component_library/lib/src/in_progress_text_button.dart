import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';

class InProgressTextButton extends StatelessWidget {
  const InProgressTextButton({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: null,
      icon: Transform.scale(
        scale: 0.5,
        child: const CenteredCircularProgressIndicator(),
      ),
      label: Text(label),
    );
  }
}
