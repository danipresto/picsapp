import 'package:flutter/material.dart';
import 'package:PecsSpeak/models/draggable_pic_model.dart';
import 'package:PecsSpeak/models/schedule_model.dart';
import 'package:PecsSpeak/services/notifications_services.dart';
import 'package:PecsSpeak/services/schedule_list_provider.dart';
import 'package:PecsSpeak/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';
import 'choose_scheduled_activity.dart';
import 'choose_scheduled_time.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ScheduleActivityScreen extends StatefulWidget{

  DraggablePicModel? picModel;

  ScheduleActivityScreen({this.picModel});

  @override
  State<ScheduleActivityScreen> createState() => _ScheduleActivityScreenState();

}


class _ScheduleActivityScreenState extends State<ScheduleActivityScreen> {

  static List<ScheduleModel> scheduleList = [];
  TimeOfDay selectedTime = TimeOfDay.now();

  void handleEscolherAtividadeTap(BuildContext context) async {
    final result = await Navigator.of(context).push(
        MaterialPageRoute(
            builder: (_){
              return ChooseScheduleActivityScreen();
            }
        )
    );
    if (result != null) {
      setState(() {
        widget.picModel = result; //set the result to picModel
      });
    }
  }

  Future<void> handleSelecionarHorarioTap(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChooseScheduledTimeScreen()),
    );
    if (result != null) {
      setState(() {
        selectedTime = result;
      });
    }
  }

  void setAlarmAndNavigate() async {
    final prefs = await SharedPreferences.getInstance();
    int lastId = prefs.getInt('last_alarm_id') ?? 0;
    int notificationId = lastId + 1;
    prefs.setInt('last_alarm_id', notificationId);

    DateTime now = DateTime.now();
    DateTime scheduledDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    if (scheduledDateTime.isBefore(now)) {
      // If the time has already passed today, schedule for tomorrow
      scheduledDateTime = scheduledDateTime.add(Duration(days: 1));
    }

    // Schedule the notification
    Provider.of<NotificationService>(context, listen: false).showNotification(
      CustomNotification(
        id: notificationId,
        title: 'Lembrete',
        path: 'Está na hora de ${widget.picModel?.title}',
      ),
      scheduledDateTime,
    );

    // Add the schedule to the list with notificationId
    Provider.of<ScheduleListProvider>(context, listen: false).addSchedule(
      ScheduleModel(
        picModel: widget.picModel!,
        selectedTime: selectedTime,
        notificationId: notificationId, // Store notificationId
      ),
    );

    Navigator.pop(context);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title:'Agenda',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                GestureDetector(
                  onTap: () => handleEscolherAtividadeTap(context),
                  child: ListTile(
                    title: Text(
                      'Escolher Atividade',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => handleSelecionarHorarioTap(context),
                  child: ListTile(
                    title: Text(
                      'Selecionar Horário',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            if (widget.picModel != null)
              Center(
                child: Column(
                  children: [
                    Image.asset('${widget.picModel?.path}'),
                    SizedBox(height: 20), // optional, for extra space
                    Text('Horário: ${selectedTime!.format(context)}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,),), // display selected time below picModel
                  ],
                ),
              ),
            ElevatedButton(
              onPressed: () {
                // this function will be defined next
                setAlarmAndNavigate();
              },
              child: Text(
                'Adicionar!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
