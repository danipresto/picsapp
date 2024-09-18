import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pecs_app/models/schedule_model.dart';
import 'package:pecs_app/services/schedule_list_provider.dart';
import 'package:pecs_app/services/admin_mode_provider.dart';
import 'package:pecs_app/services/notifications_services.dart';

class ScheduleItem extends StatelessWidget {
  final ScheduleModel schedule;

  const ScheduleItem({required this.schedule});

  @override
  Widget build(BuildContext context) {
    final isAdminMode = Provider.of<AdminModeProvider>(context).isAdminMode;
    final scheduleListProvider = Provider.of<ScheduleListProvider>(context, listen: false);

    return ListTile(
      leading: Image.asset(
        schedule.picModel.path,
        width: 50,
        height: 50,
      ),
      title: Text(
        schedule.picModel.title, // Corrected from 'name' to 'title'
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        'Horário: ${schedule.selectedTime.format(context)}',
        style: const TextStyle(fontSize: 16),
      ),
      trailing: isAdminMode
          ? IconButton(
        icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            // Show a confirmation dialog before deleting
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Confirmar Exclusão'),
                content: Text('Deseja excluir esta atividade agendada?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Cancel the notification
                      Provider.of<NotificationService>(context, listen: false)
                          .cancelNotification(schedule.notificationId);

                      // Remove the schedule
                      scheduleListProvider.removeSchedule(schedule);
                      Navigator.of(context).pop();
                    },child: Text("Excluir"),
                  ),

                ],
              ),
            );
          }

      )
          : null,
    );
  }
}
