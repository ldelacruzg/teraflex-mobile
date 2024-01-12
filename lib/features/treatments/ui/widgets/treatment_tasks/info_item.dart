import 'package:flutter/material.dart';

class InfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const InfoItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          child: Icon(icon),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        Text(value),
      ],
    );
  }
}
