import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pecs_app/services/admin_mode_provider.dart'; // Atualize com o caminho correto

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;

  CustomAppBar({
    required this.title,
    this.leading,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final isAdminMode = Provider.of<AdminModeProvider>(context).isAdminMode;

    return AppBar(
      title: Row(
        children: [
          Text(title),
          if (isAdminMode) ...[
            SizedBox(width: 10),
            Icon(Icons.admin_panel_settings),
          ],
        ],
      ),
      backgroundColor: isAdminMode ? Colors.red : Colors.blue,
      leading: leading,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}