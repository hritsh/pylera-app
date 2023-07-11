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

class _SchedulePageState extends State<SchedulePage>
    with SingleTickerProviderStateMixin {
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
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
            const SizedBox(height: 16.0),
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
            title: const Text(
              'Dosage Reminders on',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
                'Reminders set for ${times.map((e) => _formatTime(int.parse(e[0]), int.parse(e[1]))).toList().join(', ')} daily, starting from ${date[2]}/${date[1]}/${date[0]} till ${endDate[2]}/${endDate[1]}/${endDate[0]}.'),
          ),
          const Divider(),
          ListTile(
            title: const Text('PYLERA Dos and Don\'ts'),
            subtitle: const Text(
                'Make sure you follow the instructions carefully to ensure the best treatment outcome.'),
            trailing: IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('PYLERA Dos and Don\'ts'),
                      content: const SingleChildScrollView(
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
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Pylera-related Advices'),
            subtitle: const Text(
                'Make sure to follow these advices to ensure the best treatment outcome.'),
            trailing: IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Pylera-related Advices'),
                      content: const SingleChildScrollView(
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
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Cancel Reminders'),
            trailing: IconButton(
              icon: const Icon(Icons.cancel),
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
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }

  Widget _buildTimeSelectionWidget() {
    return Card(
      child: Column(
        children: [
          const ListTile(
            title: Text(
              'Set Reminder Time',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(),
          // important info listtyle
          const ListTile(
            leading: Icon(Icons.info, color: Colors.red),
            title: Text(
              'Please read the following information before setting a reminder.',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          // important info card on tap
          ListTile(
            title: const Text('Important Dosage Information'),
            subtitle: const Text('Click the (i) icon to view.'),
            trailing: IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Important Dosage Information'),
                      content: SingleChildScrollView(
                        child: _dosageInfo(),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          const Divider(),

          // cupertino datetime picker

          // tab bar with time picker for the other 3 times
          DefaultTabController(
            length: 4,
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  onTap: (value) => setState(() {
                    _tabController.index = value;
                  }),
                  tabs: const [
                    Tab(text: 'Breakfast'),
                    Tab(text: 'Lunch'),
                    Tab(text: 'Dinner'),
                    Tab(text: 'Bedtime'),
                  ],
                  labelColor: Colors.indigo,
                ),
                Container(
                  height: 275,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Column(
                        children: [
                          const ListTile(
                            leading: Icon(Icons.info, color: Colors.blue),
                            title: Text(
                              'Please select the starting date and time for your first dose. (Breakfast time)',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          Container(
                            height: 200,
                            child: CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.dateAndTime,
                              minimumDate: DateTime.now(),
                              initialDateTime: DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  DateTime.now().day + 1,
                                  10,
                                  0),
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
                        ],
                      ),
                      Column(
                        children: [
                          const ListTile(
                            leading: Icon(Icons.info, color: Colors.blue),
                            title: Text(
                              'Please select the time for your second dose. (Lunch time)',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          Container(
                            height: 200,
                            child: CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.time,
                              initialDateTime: DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  DateTime.now().day,
                                  13,
                                  0),
                              onDateTimeChanged: (value) {
                                setState(() {
                                  times[1][0] = value.hour.toString();
                                  times[1][1] = value.minute.toString();
                                  StorageService().write('times', times);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const ListTile(
                            leading: Icon(Icons.info, color: Colors.blue),
                            title: Text(
                              'Please select the time for your third dose. (Dinner time)',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          Container(
                            height: 200,
                            child: CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.time,
                              initialDateTime: DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  DateTime.now().day,
                                  16,
                                  0),
                              onDateTimeChanged: (value) {
                                setState(() {
                                  times[2][0] = value.hour.toString();
                                  times[2][1] = value.minute.toString();
                                  StorageService().write('times', times);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const ListTile(
                            leading: Icon(Icons.info, color: Colors.blue),
                            title: Text(
                              'Please select the time for your fourth dose. (Bedtime)',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          Container(
                            height: 200,
                            child: CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.time,
                              initialDateTime: DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  DateTime.now().day,
                                  19,
                                  0),
                              onDateTimeChanged: (value) {
                                setState(() {
                                  times[3][0] = value.hour.toString();
                                  times[3][1] = value.minute.toString();
                                  StorageService().write('times', times);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          (_tabController.index < 3)
              ? ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _tabController.index++;
                    });
                  },
                  child: const Text('Next'),
                )
              : ElevatedButton(
                  onPressed: () {
                    // schedule notifications
                    scheduleNotifications(date, times);
                    NotificationService().showNotification(
                        title: 'Reminder Set',
                        body:
                            'You will get reminders for PYLERA and Omeprazole as per the times you have set.',
                        payLoad: 'Reminder Set');

                    setState(() {
                      // show next time
                      _tabController.index = 0;
                      timeSet = true;
                      StorageService().write('timeSet', true);
                    });
                  },
                  child: const Text('Schedule Dosage Reminders'),
                ),

          const SizedBox(height: 16.0),
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
            const SizedBox(height: 8.0),
            const Text(
              'Start Treatment',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            const ListTile(
              leading: Icon(Icons.warning, color: Colors.red),
              title: Text(
                'Please read the warnings before starting treatment.',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            const SizedBox(height: 8.0),
            _buildWarningsWidget(),
            const SizedBox(height: 8.0),
            _buildCheckboxWidget(),
            const SizedBox(height: 8.0),
            _buildStartTreatmentButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildWarningsWidget() {
    return Card(
      color: Colors.yellow[100],
      child: const Padding(
        padding: EdgeInsets.all(16.0),
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
        const Text(
          'I have read & understood the warnings',
          style: TextStyle(fontSize: 16.0),
        ),
        const SizedBox(width: 8.0),
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
                    title: const Text('Important Dosage Information'),
                    content: SingleChildScrollView(
                      child: _dosageInfo(),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
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
                    title: const Text('Error'),
                    content: const Text(
                        'Please read and acknowledge the warnings before starting treatment.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: const Text('Start Treatment'),
        ),
      ],
    );
  }

  Widget _dosageInfo() {
    return Card(
      color: Colors.yellow[100],
      child: const Padding(
        padding: EdgeInsets.all(16.0),
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

scheduleNotifications(List day, List times) {
  // 1- Inform patients that each dose of PYLERA includes 3 capsules. All 3 capsules should be taken 4 times a day (after meals and at bedtime) for 10 days.
  // 2- One omeprazole 20 mg capsule should be taken twice a day with PYLERA at the 1st and 3rd time for 10 days. send omeprazole reminder at 1st and 3rd time in the same notification
  // loop through 10 days starting from day[0], day[1], day[2]
  print(day);
  print(times);
  for (int i = 0; i < 10; i++) {
    // loop through times
    for (int j = 0; j < times.length; j++) {
      // schedule notification
      String doseNo = (j == 0)
          ? 'first'
          : (j == 1)
              ? 'second'
              : (j == 2)
                  ? 'third'
                  : 'fourth';
      // check for omeprazole reminder
      if (j == 0 || j == 2) {
        NotificationService().scheduleNotification(
          scheduledNotificationDateTime: DateTime(
                  int.parse(day[0]),
                  int.parse(day[1]),
                  int.parse(day[2]),
                  int.parse(times[j][0]),
                  int.parse(times[j][1]))
              .add(Duration(days: i)),
          id: int.parse(i.toString() + j.toString()),
          title: "It's time for your dose of PYLERA & Omeprazole!",
          body:
              'Take 3 capsules of PYLERA & 1 capsule of Omeprazole with a full glass of water.',
        );
      } else {
        NotificationService().scheduleNotification(
          scheduledNotificationDateTime: DateTime(
                  int.parse(day[0]),
                  int.parse(day[1]),
                  int.parse(day[2]),
                  int.parse(times[j][0]),
                  int.parse(times[j][1]))
              .add(Duration(days: i)),
          id: int.parse(i.toString() + j.toString()),
          title: "It's time for your dose of PYLERA!",
          body: 'Take 3 capsules of PYLERA with a full glass of water.',
        );
      }
    }
  }
  return;
}
