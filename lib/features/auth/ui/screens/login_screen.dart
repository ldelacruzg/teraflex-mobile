import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:teraflex_mobile/features/auth/domain/entities/login_token.dart';
import 'package:teraflex_mobile/features/auth/infrastructure/datasources/isardb_login_local_storage_datasource.dart';
import 'package:teraflex_mobile/features/auth/infrastructure/datasources/tfx_login_datasource.dart';
import 'package:teraflex_mobile/features/auth/infrastructure/repositories/login_local_storage_repository_impl.dart';
import 'package:teraflex_mobile/features/auth/infrastructure/repositories/login_repository_impl.dart';
import 'package:teraflex_mobile/features/home/ui/blocs/global_summary/global_summary_cubit.dart';

class LoginScreen extends StatelessWidget {
  static const String name = 'login_screen';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greating
          Text(
            '¡Hola! 👋',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 30),

          // Form
          Expanded(child: LoginForm()),
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _dniController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _loginRepository =
      LoginRepositotyImpl(datasource: TfxLoginDatasource());
  final _localStorageRepository = LoginLocalStorageRepositoryImpl(
    datasource: IsarDBLoginLocalStorageDatasource(),
  );
  bool _showPassword = true;
  bool _isLoading = false;

  void _onSubmitLoginForm() async {
    if (!_formKey.currentState!.validate()) return;

    _setLoading(true);
    final repository = LoginRepositotyImpl(datasource: TfxLoginDatasource());

    await repository
        .login(
          dni: _dniController.text,
          password: _passwordController.text,
        )
        .then((token) => _handleLoginSuccess(token))
        // ignore: invalid_return_type_for_catch_error
        .catchError((e) => _showMessageError(e.toString()))
        .whenComplete(() => _setLoading(false));
  }

  void _handleLoginSuccess(LoginToken token) async {
    if (token.role != 'PATIENT') {
      _showMessageError('Solo los pacientes pueden ingresar');
      return;
    }

    // guardar el token en el storage
    await _localStorageRepository.setToken(token);

    // realizar petición para obtener los datos del usuario
    // guardar los datos del usuario en el storage
    final user = await _loginRepository.getProfile();
    await _localStorageRepository.setUser(user).then((value) {
      // realizar petición para obtener los datos principales (dashboard)
      context.read<GlobalSummaryCubit>().getGlobalSummary();

      context.go('/home');
    });
  }

  void _onChangePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _setLoading(bool value) {
    setState(() {
      _isLoading = value;
    });
  }

  void _showMessageError(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  String? _validateDni(String? value) {
    // verificar si el dni es válido
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su DNI';
    }

    // verificar si el dni tiene solo números
    if (int.tryParse(value) == null) {
      return 'El DNI debe tener solo números';
    }

    // verificar si el dni tiene 10 dígitos
    if (value.length != 10) {
      return 'El DNI debe tener 10 dígitos';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su contraseña';
    }

    return null;
  }

  @override
  void dispose() {
    _dniController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // DNI
          TextFormField(
            controller: _dniController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'DNI',
              prefixIcon: Icon(Icons.person_2_rounded),
            ),
            validator: _validateDni,
          ),
          const SizedBox(height: 20),

          // Password
          TextFormField(
            controller: _passwordController,
            obscureText: _showPassword,
            validator: _validatePassword,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Contraseña',
              prefixIcon: const Icon(Icons.password_rounded),
              suffixIcon: IconButton(
                onPressed: _onChangePasswordVisibility,
                icon: Icon(
                  _showPassword ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
          ),

          const Spacer(),

          // Submit
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: _isLoading ? null : _onSubmitLoginForm,
                  child: Text(_isLoading ? 'CARGANDO...' : 'INGRESAR'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
