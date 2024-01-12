import 'package:flutter/material.dart';

class CustomTaskFilters extends StatelessWidget {
  const CustomTaskFilters({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filtrar tareas'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Completadas'),
                Switch(
                  value: false,
                  onChanged: (value) => !value,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Vencidas'),
                Switch(
                  value: false,
                  onChanged: (value) => !value,
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Cerrar'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Aceptar'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
