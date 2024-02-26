import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:teraflex_mobile/config/constants/environment.dart';
import 'package:teraflex_mobile/features/home/ui/blocs/global_summary/global_summary_cubit.dart';
import 'package:teraflex_mobile/features/store/ui/blocs/redeem_product/redeem_product_cubit.dart';
import 'package:teraflex_mobile/shared/widgets/custom_confirm_dialog.dart';
import 'package:teraflex_mobile/utils/status_util.dart';

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
    ).then((value) => _responseConfirmPurchase(context, value));
  }

  void _responseConfirmPurchase(BuildContext context, bool value) {
    if (!value) return;
    context.read<RedeemProductCubit>().redeemProduct().then((value) {
      if (value == null) {
        _showDialogError(context);
        return;
      }

      context
          .read<GlobalSummaryCubit>()
          .decreaseFlexicoins(Environment.STORE_FREE_APPOINTMENT_FXC);
      _showDialogSuccess(context, value.code);
    });
  }

  void _showDialogSuccess(BuildContext context, String code) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Código promocional generado',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      const Text(
                          'Tu código promocional ha sido generado con éxito. Comparte el código con tu terapeuta para obtener una cita gratis.'),
                      const SizedBox(height: 10),
                      Text(
                        code,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => context.pop(),
                      child: const Text('Aceptar'),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDialogError(BuildContext context) {
    final message = context.read<RedeemProductCubit>().state.statusMessage;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Error al generar el código promocional',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(message ?? 'Ocurrió un error inesperado'),
                    ],
                  ),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => context.pop(),
                      child: const Text('Aceptar'),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorSchema = Theme.of(context).colorScheme;
    final globalSummaryState = context.watch<GlobalSummaryCubit>().state;
    final redeemProductState = context.watch<RedeemProductCubit>().state;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: redeemProductState.status == StatusUtil.loading,
            child: const Column(
              children: [
                LinearProgressIndicator(),
                SizedBox(height: 10),
              ],
            ),
          ),
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
                    if (globalSummaryState.globalSummary.flexicoins <
                        Environment.STORE_FREE_APPOINTMENT_FXC) {
                      _showSnackBar(
                        context,
                        'No tienes suficientes flexicoins para obtener el código.',
                      );
                      return;
                    }
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
                                      Environment.STORE_FREE_APPOINTMENT_FXC
                                          .toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: colorSchema.primary,
                                      ),
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
