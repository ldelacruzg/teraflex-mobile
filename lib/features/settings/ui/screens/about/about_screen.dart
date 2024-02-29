import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AboutScreen extends StatelessWidget {
  static const String name = 'about_screen';

  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre TeraFlex'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Versión: Bear (2.0.0)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Esta aplicación móvil ha sido desarrollada como parte del proyecto titulación, cuyo nombre es "Aplicación móvil basada en gamificación para telerehabilitación fisica asicrona" de la carrera de Ingeniería en Software, perteneciente a la facultad de Ciencias de la Ingeniería, de la Universidad Técnica Estatal de Quevedo, en cooperación con la Dirección de Gestión de Desarrollo Social GAD de Quevedo. Con este proyecto, se pretende mejorar la atención de terapías físicas de los pacientes de la ciudad de Quevedo.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              const Text(
                'Desarrollado por',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              CardPerson(
                name: 'Luis De La Cruz',
                role: 'Desarrollador de Software',
                photo: const AssetImage('assets/images/delacruz.png'),
                contacts: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.email),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'El correo ldelacruzg@uteq.edu.ec ha sido copiado en portapapeles'),
                          ),
                        );
                        Clipboard.setData(
                          const ClipboardData(text: 'ldelacruzg@uteq.edu.ec'),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.public_rounded),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'El LinkedIn ha sido copiado en portapapeles'),
                          ),
                        );
                        Clipboard.setData(
                          const ClipboardData(
                              text:
                                  'https://www.linkedin.com/in/luis-de-la-cruz-b07930298/'),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Dirigido por',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              CardPerson(
                name: 'Orlando Erazo',
                role: 'Ingeniero de Sistemas',
                photo: const AssetImage('assets/images/erazo.png'),
                contacts: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.email),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'El correo oerazo@uteq.edu.ec ha sido copiado en portapapeles'),
                          ),
                        );
                        Clipboard.setData(
                            const ClipboardData(text: 'oerazo@uteq.edu.ec'));
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.public_rounded),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'La página web ha sido copiada en portapapeles'),
                          ),
                        );
                        Clipboard.setData(const ClipboardData(
                            text:
                                'https://sites.google.com/a/uteq.edu.ec/oerazo/'));
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'En la administración de',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text('Eduardo Díaz (Rector)'),
              const Text('Jenny Torres (Vicerrectora Académica)'),
              const Text('Roberto Pico (Vicerrector Administrativo)'),
              const Text('Patricio Alcócer (Decano)'),
              const Text('Stalin Carreño (Unidad de TIC)'),
              const SizedBox(height: 24),
              const Text(
                'Con la colaboración de',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text('Rosa Andrade y Sergio Yépez'),
              const Text(
                'Dirección de Gestión de Desarrollo Social del Gobierno Autónomo Descentralizado del cantón Quevedo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Para más información visite',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text('https://fyc.uteq.edu.ec/'),
              const Text('https://www.facebook.com/fycuteq'),
              const SizedBox(height: 24),
              const Text('© 2023 Universidad Técnica Estatal de Quevedo'),
              const Text('Campus "Ingeniero Manuel Agustín Haz Álvarez"'),
              const Text(
                'Av. Quito km. 1 1/2 vía a Santo Domingo de los Tsáchilas',
                textAlign: TextAlign.center,
              ),
              const Text('(+593) 5 3702-220 Ext. 8039'),
              const Text('Email: info@uteq.edu.ec'),
              const Text('Quevedo - Los Ríos - Ecuador'),
              const Text('www.uteq.edu.ec'),
            ],
          ),
        ),
      ),
    );
  }
}

class CardPerson extends StatelessWidget {
  final String name;
  final String role;
  final Widget? contacts;
  final ImageProvider<Object> photo;

  const CardPerson({
    super.key,
    required this.name,
    required this.role,
    required this.photo,
    this.contacts,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: photo,
              backgroundColor: const Color(0xFFe9e2da),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              role,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            contacts ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
