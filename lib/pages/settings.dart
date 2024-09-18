import 'package:flutter/material.dart';
import 'package:pecs_app/widgets/custom_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:pecs_app/services/admin_mode_provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _passwordVerificationController = TextEditingController();
  String? _savedPassword;

  @override
  void initState() {
    super.initState();
    _loadPassword();
  }

  // Load the saved password from SharedPreferences
  Future<void> _loadPassword() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedPassword = prefs.getString('admin_password');
    });
  }

  // Save the new password
  Future<void> _savePassword(String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('admin_password', password);
    setState(() {
      _savedPassword = password;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Senha salva com sucesso!")),
    );
  }

  // Verify the entered password
  Future<void> _verifyPassword(String password) async {
    if (password == _savedPassword) {
      // Enable admin mode via Provider
      Provider.of<AdminModeProvider>(context, listen: false).enableAdminMode();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Modo Administrador Ativado!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Senha incorreta!")),
      );
    }
  }

  // Toggle Admin Mode
  void _toggleAdminMode(bool value) {
    final adminProvider = Provider.of<AdminModeProvider>(context, listen: false);
    if (value) {
      if (_savedPassword == null) {
        // No password set, prompt to create one
        _showCreatePasswordDialog();
      } else {
        // Prompt to enter existing password
        _showEnterPasswordDialog();
      }
    } else {
      // Disable Admin Mode
      adminProvider.disableAdminMode();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Modo Administrador Desativado")),
      );
    }
  }

  // Dialog to create a new password
  void _showCreatePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Configurar Senha de Administrador"),
          content: TextField(
            controller: _newPasswordController,
            decoration: InputDecoration(labelText: "Nova Senha"),
            obscureText: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_newPasswordController.text.isNotEmpty) {
                  _savePassword(_newPasswordController.text);
                  Provider.of<AdminModeProvider>(context, listen: false).enableAdminMode();
                  _newPasswordController.clear();
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("A senha não pode ser vazia.")),
                  );
                }
              },
              child: Text("Salvar"),
            ),
          ],
        );
      },
    );
  }

  // Dialog to enter existing password
  void _showEnterPasswordDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Digite a Senha de Administrador"),
          content: TextField(
            controller: _passwordVerificationController,
            decoration: InputDecoration(labelText: "Senha"),
            obscureText: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                _verifyPassword(_passwordVerificationController.text);
                _passwordVerificationController.clear();
                Navigator.of(context).pop();
              },
              child: Text("Entrar"),
            ),
          ],
        );
      },
    );
  }

  // Optional: Clear the password (for testing purposes)
  Future<void> _clearPassword() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('admin_password');
    Provider.of<AdminModeProvider>(context, listen: false).disableAdminMode();
    setState(() {
      _savedPassword = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Senha apagada.")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isAdminMode = Provider.of<AdminModeProvider>(context).isAdminMode;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Configurações'
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text("Modo Administrador"),
              trailing: Switch(
                value: isAdminMode,
                onChanged: _toggleAdminMode,
              ),
            ),
            Divider(),
            if (isAdminMode) ...[
              TextField(
                controller: _newPasswordController,
                decoration: InputDecoration(labelText: "Alterar Senha de Administrador"),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_newPasswordController.text.isNotEmpty) {
                    _savePassword(_newPasswordController.text);
                    _newPasswordController.clear();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("A senha não pode ser vazia.")),
                    );
                  }
                },
                child: Text("Salvar Nova Senha"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _clearPassword,
                child: Text("Apagar Senha (Reset)"),
                style: ElevatedButton.styleFrom(primary: Colors.grey),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
