import 'package:flutter/material.dart';
import 'package:pecs_app/models/draggable_pic_model.dart';
import 'package:pecs_app/models/schedule_list_model.dart';
import 'package:pecs_app/support/notifications_services.dart';
import 'package:pecs_app/support/schedule_provider.dart';
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

  void setAlarmAndNavigate() async{

    final prefs = await SharedPreferences.getInstance();
    int lastId = prefs.getInt('last_alarm_id') ?? 0;
    int notificationId = lastId + 1;
    prefs.setInt('last_alarm_id', notificationId);

    scheduleList.add(ScheduleModel(picModel: widget.picModel!, selectedTime: selectedTime!));

    DateTime date = DateTime.now();
    DateTime alarmTime = DateTime(date.year, date.month, date.day, selectedTime.hour, selectedTime.minute);

    Provider.of<NotificationService>(context, listen: false).showNotification(
        CustomNotification(
          id: notificationId,
          title: 'Teste',
          path: 'Acesse o app!',
        ),
        alarmTime
    );

    Provider.of<ScheduleListProvider>(context, listen: false).addSchedule(
      ScheduleModel(picModel: widget.picModel!, selectedTime: selectedTime!),
    );

    Navigator.pop(context);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListTile Screen'),
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
