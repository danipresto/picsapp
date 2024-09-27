import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:PecsSpeak/models/schedule_model.dart';
import 'package:PecsSpeak/services/schedule_list_provider.dart';
import 'package:PecsSpeak/services/admin_mode_provider.dart';
import 'package:PecsSpeak/services/notifications_services.dart';

class ScheduleItem extends StatelessWidget {
  final ScheduleModel schedule;

  const ScheduleItem({required this.schedule});

  String formatTimeOfDay(BuildContext context, TimeOfDay time) {
    final localizations = MaterialLocalizations.of(context);
    return localizations.formatTimeOfDay(
      time,
      alwaysUse24HourFormat: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isAdminMode = Provider.of<AdminModeProvider>(context).isAdminMode;
    final scheduleListProvider =
    Provider.of<ScheduleListProvider>(context, listen: false);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.black12, // Light black background for the tile
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black), // Black border
      ),
      child: ListTile(
        leading: Image.asset(
          schedule.picModel.path,
          width: 50,
          height: 50,
        ),
        title: Text(
          schedule.picModel.title,
          style: const TextStyle(fontSize: 18),
        ),
        subtitle: Text(
          'Horário: ${formatTimeOfDay(context, schedule.selectedTime)}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold, // Make time bold
          ),
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
                content:
                Text('Deseja excluir esta atividade agendada?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () async {
                      // Cancel the notification
                      await Provider.of<NotificationService>(context,
                          listen: false)
                          .cancelNotification(schedule.notificationId);

                      // Remove the schedule
                      scheduleListProvider.removeSchedule(schedule);
                      Navigator.of(context).pop();
                    },
                    child: Text('Excluir'),
                  ),
                ],
              ),
            );
          },
        )
            : null,
      ),
    );
  }
}
