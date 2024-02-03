import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:teraflex_mobile/features/auth/infrastructure/datasources/isardb_login_local_storage_datasource.dart';
import 'package:teraflex_mobile/features/auth/infrastructure/repositories/login_local_storage_repository_impl.dart';
import 'package:teraflex_mobile/features/auth/ui/blocs/auth/auth_cubit.dart';
import 'package:teraflex_mobile/shared/widgets/custom_confirm_dialog.dart';
import 'package:teraflex_mobile/utils/status_util.dart';

class ChangePasswordScreen extends StatelessWidget {
  static const String name = 'change_password_screen';

  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cambiar contraseña'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Al asignar una nueva contraseña, asegúrese de seguir estos criterios para garantizar la seguridad de su cuenta'),
              SizedBox(height: 20),
              Text('1. Su contraseña debe tener al menos 6 caracteres'),
              Text(
                  '2. La contraseña debe contener al menos una letra minúscula y una letra mayúscula.'),
              Text(
                  '3. Asegúrese de incluir al menos un número en su contraseña.'),
              SizedBox(height: 20),
              ChangePasswordForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({
    super.key,
  });

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  @override
  void dispose() {
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa la nueva contraseña';
    }
    // Validar longitud mínima
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    // Validar al menos 1 minúscula
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'La contraseña debe contener al menos una letra minúscula';
    }
    // Validar al menos 1 mayúscula
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'La contraseña debe contener al menos una letra mayúscula';
    }
    // Validar al menos 1 número
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'La contraseña debe contener al menos un número';
    }
    // Validar que no contenga símbolos
    if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%$]').hasMatch(value)) {
      return 'La contraseña no debe contener símbolos';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor confirma la nueva contraseña';
    }
    if (value != _password.text) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }

  void _showConfirmDialog() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => CustomConfirmDialog(
          title: '¿Estás seguro de cambiar la contraseña?',
          content: const Text(
              'Al cambiar la contraseña, se cerrará la sesión actual'),
          onCancel: () => context.pop(),
          onConfirm: () {
            context.pop();
            _onChangePassword();
          },
        ),
      );
    }
  }

  void _onChangePassword() {
    context
        .read<AuthCubit>()
        .changePassword(_password.text)
        .then((value) => _showInfoDialog('Contraseña cambiada con éxito'));
  }

  void _showInfoDialog(String message) {
    final loginLocalRepository = LoginLocalStorageRepositoryImpl(
      datasource: IsarDBLoginLocalStorageDatasource(),
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Información'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                loginLocalRepository.logout().then((value) => context.go('/'));
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _password,
            validator: _validatePassword,
            obscureText: !_showPassword,
            decoration: InputDecoration(
              labelText: 'Nueva contraseña *',
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.lock_rounded),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                },
                icon: Icon(_showPassword
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_rounded),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _confirmPassword,
            validator: _validateConfirmPassword,
            obscureText: !_showConfirmPassword,
            decoration: InputDecoration(
              labelText: 'Confirmar nueva contraseña *',
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.lock_rounded),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _showConfirmPassword = !_showConfirmPassword;
                  });
                },
                icon: Icon(_showConfirmPassword
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_rounded),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: authState.status == StatusUtil.loading
                      ? null
                      : _showConfirmDialog,
                  child: Text(
                    authState.status == StatusUtil.loading
                        ? 'GUARDANDO...'
                        : 'GUARDAR',
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
