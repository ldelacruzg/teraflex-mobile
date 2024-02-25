import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:teraflex_mobile/shared/widgets/custom_confirm_dialog.dart';

class StoreView extends StatelessWidget {
  const StoreView({super.key});

  void _confirmPurchase(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CustomConfirmDialog(
          title: 'Generar código promocional',
          content: const Text(
              'Para mayor seguridad te recomendamos que generes el código en presencia de tu terapeuta.'),
          onCancel: () => context.pop(false),
          onConfirm: () => context.pop(true),
        );
      },
    ).then((value) {
      if (!value) return;
      // TODO: petición para descontar 100 monedas y generar código promocional
      print('Petición para descontar 100 monedas y generar código promocional');
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorSchema = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Código promocional',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _confirmPurchase(context);
                  },
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          const CircleAvatar(child: Icon(Icons.local_offer)),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Genera un código promocional',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                const Text(
                                  'Comparte el código con tu terapeuta para obtener una cita gratis',
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.monetization_on_rounded,
                                      color: colorSchema.primary,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      '100',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: colorSchema.primary),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
