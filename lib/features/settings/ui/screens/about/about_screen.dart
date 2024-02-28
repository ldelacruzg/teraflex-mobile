import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  static const String name = 'about_screen';

  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre TeraFlex'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Versión: Bear (2.0.0)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Esta aplicación móvil ha sido desarrollada como parte del proyecto titulación, cuyo nombre es "Aplicación móvil basada en gamificación para telerehabilitación fisica asicrona" de la carrera de Ingeniería en Software, perteneciente a la facultad de Ciencias de la Ingeniería, de la Universidad Técnica Estatal de Quevedo, en cooperación con la Dirección de Gestión de Desarrollo Social GAD de Quevedo. Con este proyecto, se pretende mejorar la atención de terapías físicas de los pacientes de la ciudad de Quevedo.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              Text(
                'Desarrollado por',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              CardPerson(
                name: 'Luis De La Cruz',
                role: 'Desarrollador de Software',
              ),
              SizedBox(height: 24),
              Text(
                'Dirigido por',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              CardPerson(
                name: 'Orlando Erazo',
                role: 'Ingeniero en Software',
              ),
              SizedBox(height: 24),
              Text(
                'Con la colaboración de',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text('Rosa Andrade y Sergio Yépez'),
              Text(
                'Dirección de Gestión de Desarrollo Social del Gobierno Autónomo Descentralizado del cantón Quevedo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Para más información visite',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text('https://fyc.uteq.edu.ec/'),
              Text('https://www.facebook.com/fycuteq'),
              SizedBox(height: 24),
              Text('© 2023 Universidad Técnica Estatal de Quevedo'),
              Text('Campus "Ingeniero Manuel Agustín Haz Álvarez"'),
              Text(
                'Av. Quito km. 1 1/2 vía a Santo Domingo de los Tsáchilas',
                textAlign: TextAlign.center,
              ),
              Text('(+593) 5 3702-220 Ext. 8039'),
              Text('Email: info@uteq.edu.ec'),
              Text('Quevedo - Los Ríos - Ecuador'),
              Text('www.uteq.edu.ec'),
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

  const CardPerson({
    super.key,
    required this.name,
    required this.role,
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
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.email),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.phone),
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
