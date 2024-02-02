import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:teraflex_mobile/features/auth/ui/blocs/auth/auth_cubit.dart';
import 'package:teraflex_mobile/features/settings/ui/blocs/profile_form/profile_form_cubit.dart';

class ProfileScreen extends StatelessWidget {
  static String name = 'profile_screen';

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información Personal'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                child: Icon(Icons.person_rounded, size: 50),
              ),
              SizedBox(height: 20),
              FormProfile()
            ],
          ),
        ),
      ),
    );
  }
}

class FormProfile extends StatefulWidget {
  const FormProfile({
    super.key,
  });

  @override
  State<FormProfile> createState() => _FormProfileState();
}

class _FormProfileState extends State<FormProfile> {
  final _formKey = GlobalKey<FormState>();
  final _birthDate = TextEditingController();

  @override
  void initState() {
    initialize();
    super.initState();
  }

  void initialize() {
    final state = context.read<AuthCubit>().state;
    context.read<ProfileFormCubit>().initialize(state.user!);

    _birthDate.text = state.user!.birthDate.isNotEmpty
        ? DateFormat('yyyy-MM-dd').format(DateTime.parse(state.user!.birthDate))
        : '';
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese su nombre';
    }

    if (value.length < 3) {
      return 'El nombre debe contener al menos 3 caracteres';
    }
    return null;
  }

  String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese su apellido';
    }

    if (value.length < 3) {
      return 'El apellido debe contener al menos 3 caracteres';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value != null && value.isNotEmpty && value.length != 10) {
      return 'El número de teléfono debe contener al menos 10 caracteres';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final profileFormState = context.watch<ProfileFormCubit>().state;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Nombres
          TextFormField(
            //controller: _name,
            initialValue: profileFormState.name,
            onChanged: (value) {
              context.read<ProfileFormCubit>().nameChanged(value);
              _formKey.currentState?.validate();
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nombre(s) *',
              prefixIcon: Icon(Icons.person_3_rounded),
            ),
            validator: validateName,
          ),
          const SizedBox(height: 20),

          // Apellidos
          TextFormField(
            initialValue: profileFormState.lastName,
            onChanged: (value) {
              context.read<ProfileFormCubit>().lastNameChanged(value);
              _formKey.currentState?.validate();
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Apellido(s) *',
              prefixIcon: Icon(Icons.person_3_rounded),
            ),
            validator: validateLastName,
          ),
          const SizedBox(height: 20),

          // DNI
          TextFormField(
            readOnly: true,
            initialValue: profileFormState.dni,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'DNI *',
              prefixIcon: Icon(Icons.badge_rounded),
            ),
          ),
          const SizedBox(height: 20),

          // Teléfono
          TextFormField(
            initialValue: profileFormState.phone,
            onChanged: (value) {
              context.read<ProfileFormCubit>().phoneChanged(value);
              _formKey.currentState?.validate();
            },
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Teléfono',
              prefixIcon: Icon(Icons.phone_android_rounded),
            ),
            validator: validatePhone,
          ),
          const SizedBox(height: 20),

          // Fecha de nacimiento
          TextFormField(
            controller: _birthDate,
            readOnly: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Fecha de nacimiento',
              prefixIcon: Icon(Icons.calendar_today_rounded),
            ),
            onTap: () async {
              FocusScope.of(context).requestFocus(FocusNode());

              showDatePicker(
                context: context,
                //initialDate: DateTime.now(),
                initialDate: profileFormState.birthDate.isNotEmpty
                    ? DateTime.parse(profileFormState.birthDate)
                    : DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              ).then((value) {
                if (value != null) {
                  final formattedDate = DateFormat('yyyy-MM-dd').format(value);
                  _birthDate.text = formattedDate;
                  context
                      .read<ProfileFormCubit>()
                      .birthDateChanged(formattedDate);
                }
              });
            },
          ),
          const SizedBox(height: 20),

          // Descripción
          TextFormField(
            readOnly: true,
            initialValue: profileFormState.description,
            maxLines: 3,
            decoration: const InputDecoration(
              alignLabelWithHint: true,
              border: OutlineInputBorder(),
              labelText: 'Descripción',
            ),
          ),
          const SizedBox(height: 20),

          // Botón de Guardar
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    print(
                        'submit valid::: ${_formKey.currentState?.validate()}');
                    //print('submit::: ${_name.text}');
                    print('submit::: ${profileFormState.name}');
                    print('submit::: ${profileFormState.lastName}');
                  },
                  child: const Text('GUARDAR'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
