import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pylera_app/services/notification_service.dart';
import 'package:pylera_app/services/storage_service.dart';
import 'package:timezone/timezone.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  bool reminderSet = StorageService().read('reminderSet') ?? false;
  bool timeSet = StorageService().read('timeSet') ?? false;
  List date = [
    DateTime.now().year.toString(),
    DateTime.now().month.toString(),
    (DateTime.now().day + 1).toString()
  ];
  List endDate = [
    DateTime.now().year.toString(),
    DateTime.now().month.toString(),
    (DateTime.now().day + 10).toString()
  ];
  // List time = StorageService().read('time') ?? ['09', '00'];
  List times = StorageService().read('times') ??
      [
        ['10', '00'],
        ['13', '00'],
        ['16', '00'],
        ['19', '00']
      ];
  bool hasReadWarnings = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Schedule Dose Reminders')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            (reminderSet)
                ? (timeSet)
                    ? _buildReminderSetWidget()
                    : _buildTimeSelectionWidget()
                : _buildStartTreatmentWidget()
          ],
        ),
      ),
    );
  }

  Widget _buildReminderSetWidget() {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(
              'Dosage Reminders on',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
                'Reminders set for ${times.map((e) => _formatTime(int.parse(e[0]), int.parse(e[1]))).toList().join(', ')} daily, starting from ${date[2]}/${date[1]}/${date[0]} till ${endDate[2]}/${endDate[1]}/${endDate[0]}'),
          ),
          Divider(),
          ListTile(
            title: Text('PYLERA Dos and Don\'ts'),
            subtitle: Text(
                'Make sure you follow the instructions carefully to ensure the best treatment outcome.'),
            trailing: IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('PYLERA Dos and Don\'ts'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: [
                            Text('• Each dose of PYLERA includes 3 capsules.'),
                            Text(
                                '• All 3 capsules should be taken 4 times a day (after meals and at bedtime) for 10 days.'),
                            Text(
                                '• One omeprazole 20 mg capsule should be taken twice a day with PYLERA after the morning and evening meal for 10 days.'),
                            Text(
                                '• If a dose is missed, advise patient not to make up the dose, but to continue the normal dosing schedule until medication is gone. Patients should not take double doses. If more than 4 doses are missed, advise the patient to contact their health-care provider.'),
                            Text(
                                '• Skipping doses or not completing the full course of therapy may decrease the effectiveness of the immediate treatment and increase the likelihood that bacteria will develop resistance and will not be treatable by PYLERA or other antibacterial drugs in the future.'),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Pylera-related Advices'),
            subtitle: Text(
                'Make sure to follow these advices to ensure the best treatment outcome.'),
            trailing: IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Pylera-related Advices'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: [
                            Text(
                                '• Avoid exposure to the sun or sun lamps. (Photosensitivity)'),
                            Text(
                                '• Bismuth absorbs x-rays and may interfere with x-ray diagnostic procedures of the gastrointestinal tract.'),
                            Text('• Darkening of the Tongue and/or Stool.'),
                            Text('• Drug interactions and Warnings'),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Cancel Reminders'),
            trailing: IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {
                setState(() {
                  reminderSet = false;
                  timeSet = false;
                  times = [
                    ['10', '00'],
                    ['13', '00'],
                    ['16', '00'],
                    ['19', '00']
                  ];
                  StorageService().write('reminderSet', false);
                  StorageService().write('timeSet', false);
                  StorageService().write('times', times);

                  NotificationService().cancelAllNotifications();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSelectionWidget() {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(
              'Set Reminder Time',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
          // important info listtyle
          ListTile(
            leading: Icon(Icons.info, color: Colors.red),
            title: Text(
              'Please read the following information before setting a reminder.',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          // important info card on tap
          ListTile(
            title: Text('Important Dosage Information'),
            subtitle: Text('Click the (i) icon to view.'),
            trailing: IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Important Dosage Information'),
                      content: SingleChildScrollView(
                        child: _dosageInfo(),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.info, color: Colors.blue),
            title: Text(
              'Please select the starting date and time for your first dose. (Breakfast time is recommended.)',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          // cupertino datetime picker
          Container(
            height: 200,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.dateAndTime,
              minimumDate: DateTime.now(),
              initialDateTime: DateTime(DateTime.now().year,
                  DateTime.now().month, DateTime.now().day + 1, 10, 0),
              onDateTimeChanged: (value) {
                setState(() {
                  times[0][0] = value.hour.toString();
                  times[0][1] = value.minute.toString();
                  date[0] = value.year.toString();
                  date[1] = value.month.toString();
                  date[2] = value.day.toString();
                  endDate[0] = value.year.toString();
                  endDate[1] = value.month.toString();
                  endDate[2] = (value.day + 9).toString();
                  StorageService().write('times', times);
                  StorageService().write('date', date);
                  StorageService().write('endDate', endDate);
                });
              },
            ),
          ),

          ElevatedButton(
            onPressed: () {
              // FIRST TIME SET
              NotificationService().scheduleNotification(
                  scheduledNotificationDateTime: DateTime(
                      int.parse(date[0]),
                      int.parse(date[1]),
                      int.parse(date[2]),
                      int.parse(times[0][0]),
                      int.parse(times[0][1])),
                  title: "It's time for your first dose of PYLERA!",
                  body: 'Take 3 capsules of PYLERA with a full glass of water.',
                  payLoad: 'PYLERA');
              setState(() {
                // show next time
                timeSet = true;
                StorageService().write('timeSet', true);
              });
            },
            child: Text('Set Date and Time'),
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }

  Widget _buildStartTreatmentWidget() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 8.0),
            Text(
              'Start Treatment',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            ListTile(
              leading: Icon(Icons.warning, color: Colors.red),
              title: Text(
                'Please read the warnings before starting treatment.',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            SizedBox(height: 8.0),
            _buildWarningsWidget(),
            SizedBox(height: 8.0),
            _buildCheckboxWidget(),
            SizedBox(height: 8.0),
            _buildStartTreatmentButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildWarningsWidget() {
    return Card(
      color: Colors.yellow[100],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Warnings',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Please read the following warnings carefully before starting treatment:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              '- Do not exceed the recommended dose.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              '- Consult your doctor before starting treatment if you have any underlying medical conditions or are taking any medications.',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckboxWidget() {
    return Row(
      children: [
        Expanded(child: Container()),
        Text(
          'I have read and understood the warnings',
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(width: 8.0),
        Checkbox(
          value: hasReadWarnings,
          onChanged: (value) {
            setState(() {
              hasReadWarnings = value!;
            });
          },
        ),
      ],
    );
  }

  Widget _buildStartTreatmentButton() {
    return Row(
      children: [
        Expanded(child: Container()),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                (hasReadWarnings) ? Colors.indigo : Colors.grey),
          ),
          onPressed: () {
            if (hasReadWarnings) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Important Dosage Information'),
                    content: SingleChildScrollView(
                      child: _dosageInfo(),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              ).then((value) => {
                    setState(() {
                      reminderSet = true;
                      StorageService().write('reminderSet', true);
                      hasReadWarnings = false;
                    })
                  });
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Error'),
                    content: Text(
                        'Please read and acknowledge the warnings before starting treatment.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: Text('Start Treatment'),
        ),
      ],
    );
  }

  Widget _dosageInfo() {
    return Card(
      color: Colors.yellow[100],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please read the following information carefully before setting a reminder:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              '- PYLERA should be taken 4 times a day (after meals and at bedtime) for 10 days.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              '- One omeprazole 20 mg capsule should be taken twice a day with PYLERA after the morning and evening meal for 10 days.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              '- You will get reminders for both PYLERA and Omeprozole as per the times you have set.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              '- If a dose is missed, do make up the dose, but continue the normal dosing schedule until medication is gone.',
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.red,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              '- Do not take double doses. If more than 4 doses are missed, contact your health-care provider.',
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.red,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              '- Skipping doses or not completing the full course of therapy may decrease the effectiveness of the immediate treatment and increase the likelihood that bacteria will develop resistance and will not be treatable by PYLERA or other antibacterial drugs in the future.',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(int hour, int minute) {
    // Convert to 12 hour format
    final hour12 = (hour > 12) ? hour - 12 : hour;
    final amPm = (hour >= 12) ? 'PM' : 'AM';
    // Add leading zero to minutes
    final minuteStr = (minute < 10) ? '0$minute' : '$minute';
    return '$hour12:$minuteStr $amPm';
  }
}
