import 'package:flutter/material.dart';

class CustomConfirmDialog extends StatelessWidget {
  final void Function()? onConfirm;
  final void Function()? onCancel;
  final String textConfirm;
  final String textCancel;
  final String title;
  final Widget content;

  const CustomConfirmDialog({
    super.key,
    this.onConfirm,
    this.onCancel,
    required this.title,
    required this.content,
    this.textConfirm = 'Aceptar',
    this.textCancel = 'Cancelar',
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      //title: Text(title),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  child: Text(textCancel),
                ),
                TextButton(
                  onPressed: onConfirm,
                  child: Text(textConfirm),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
