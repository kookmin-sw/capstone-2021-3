import 'package:flutter/material.dart';

class SupportTitle extends StatelessWidget {
  final String title;

  const SupportTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
