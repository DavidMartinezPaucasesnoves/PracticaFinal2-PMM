import 'package:flutter/material.dart';

import '../routes/app_routes.dart';
import '../models/persona.dart';

// JUSTIFICACIÓN WIDGET: Se utiliza StatefulWidget porque la pantalla necesita almacenar
// el estado del objeto 'Persona' y redibujar la vista (mediante setState) cuando
// el usuario edita el perfil en PersonalScreen y regresa a HomePage.

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Persona _persona = Persona(
    firstName: "David",
    lastName: "Martinez",
    email: "davidmartinez@paucasesnovescifp.cat",
    password: "1234567890",
    birthDate: DateTime(2007, 5, 31),
  );

  Future<void> _navigateToEditProfile() async {
    final updatedPersona = await Navigator.pushNamed(
      context,
      AppRoutes.personal,
      arguments: _persona,
    );

    if (updatedPersona != null && updatedPersona is Persona) {
      setState(() {
        _persona = updatedPersona;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("DevProfile M3")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${_persona.firstName} ${_persona.lastName}",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text("Email: ${_persona.email}"),
                    const SizedBox(height: 4),
                    Text(
                      "Fecha de Nacimiento: ${_persona.birthDate.day}/${_persona.birthDate.month}/${_persona.birthDate.year}",
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            ElevatedButton.icon(
              onPressed: _navigateToEditProfile,
              icon: const Icon(Icons.edit),
              label: const Text("Editar Datos del Perfil"),
            ),
            const SizedBox(height: 12),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.widgetShowcase);
              },
              icon: const Icon(Icons.widgets),
              label: const Text("Explorar Widget Showcase"),
            ),
          ],
        ),
      ),
    );
  }
}
