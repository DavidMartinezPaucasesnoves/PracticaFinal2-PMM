import 'package:flutter/material.dart';

import '../models/persona.dart';

// JUSTIFICACIÓN WIDGET: Se utiliza StatefulWidget porque manejamos el estado de los
// controladores de texto (TextEditingController) de cada campo y el estado local de la
// fecha seleccionada mediante el selector showDatePicker antes de devolver los datos.

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _bdController;

  DateTime? _selectedDate;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      final persona = ModalRoute.of(context)!.settings.arguments as Persona;

      _firstNameController = TextEditingController(text: persona.firstName);
      _lastNameController = TextEditingController(text: persona.lastName);
      _emailController = TextEditingController(text: persona.email);
      _passwordController = TextEditingController(text: persona.password);
      _selectedDate = persona.birthDate;
      _bdController = TextEditingController(
        text:
            "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
      );

      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bdController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _bdController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  void _guardarVolver() {
    if (_firstNameController.text.trim().isEmpty ||
        _lastNameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty ||
        _selectedDate == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Rellena todos los campos")));
      return;
    }

    final updatedPersona = Persona(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      birthDate: _selectedDate!,
    );

    Navigator.pop(context, updatedPersona);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Martinez - Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _firstNameController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: "Nombre"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: "Apellido"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Contraseña"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _bdController,
              readOnly: true,
              onTap: () {
                _selectDate(context);
              },
              decoration: const InputDecoration(
                labelText: "Fecha de Nacimiento",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _guardarVolver,
              child: const Text("Guardar y Volver"),
            ),
          ],
        ),
      ),
    );
  }
}
