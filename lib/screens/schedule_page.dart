import 'package:flutter/material.dart';
import 'package:pylera_app/services/storage_service.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

// if reminder is not set, show a button to set up reminder
// if reminder is set, show the main page
class _SchedulePageState extends State<SchedulePage> {
  bool reminderSet = StorageService().read('reminderSet') ?? false;
  bool timeSet = StorageService().read('timeSet') ?? false;
  List time = StorageService().read('time') ?? ['09', '00'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Schedule Page')),
      body: Center(
        child: (reminderSet)
            ? (timeSet) // if time is set, show the main page
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Reminder is set'),
                      Text(
                          'Time is set to ${_formatTime(int.parse(time[0] ?? '00'), int.parse(time[1] ?? '00'))}'),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            reminderSet = false;
                            timeSet = false;
                            time = ['09', '00'];
                            StorageService().write('reminderSet', false);
                            StorageService().write('timeSet', false);
                            StorageService().write('time', time);
                          });
                        },
                        child: Text('Cancel Reminder'),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Time is not set'),
                      // time selection widget
                      ElevatedButton(
                        onPressed: () {
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay(
                                hour: int.parse(time[0]?.toString() ?? '00'),
                                minute: int.parse(time[1]?.toString() ?? '00')),
                          ).then((value) {
                            if (value != null) {
                              setState(() {
                                time[0] = value.hour.toString();
                                time[1] = value.minute.toString();
                                StorageService().write('time', time);
                                StorageService().write('timeSet', true);
                                timeSet = true;
                              });
                            }
                          });
                        },
                        child: Text('Set Time'),
                      ),
                    ],
                  )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Reminder is not set'),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        reminderSet = true;
                        StorageService().write('reminderSet', true);
                      });
                    },
                    child: Text('Set Reminder'),
                  ),
                ],
              ),
      ),
    );
  }

  String _formatTime(int hour, int minute) {
    String hourStr = hour.toString();
    String minuteStr = minute.toString();
    if (hour < 10) hourStr = '0$hourStr';
    if (minute < 10) minuteStr = '0$minuteStr';

    if (hour == 0) hourStr = '12';

    if (hour < 12) {
      return '$hourStr:$minuteStr AM';
    } else {
      hourStr = (hour - 12).toString();
      return '$hourStr:$minuteStr PM';
    }
  }
}
