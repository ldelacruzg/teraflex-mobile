import 'package:flutter/material.dart';

class CustomConfirmDialog extends StatelessWidget {
  final void Function()? onConfirm;
  final void Function()? onCancel;
  final String title;
  final Widget content;

  const CustomConfirmDialog({
    super.key,
    this.onConfirm,
    this.onCancel,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      //title: Text(title),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: content,
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onCancel,
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: onConfirm,
                  child: const Text('Aceptar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
