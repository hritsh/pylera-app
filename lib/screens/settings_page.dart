import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pylera_app/services/storage_service.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final List locale = [
    {'name': 'English', 'locale': const Locale('en', 'US'), 'flag': '🇺🇸'},
    {'name': 'عربى', 'locale': const Locale('ar', 'AR'), 'flag': '🇸🇦'},
    {'name': 'اردو', 'locale': const Locale('ur', 'PK'), 'flag': '🇵🇰'},
  ];
  String firstName = StorageService().read('firstName') ?? '';
  String lastName = StorageService().read('lastName') ?? '';
  bool reminderSet = StorageService().read('reminderSet') ?? false;
  bool timeSet = StorageService().read('timeSet') ?? false;
  List time = StorageService().read('time') ?? ['09', '00'];

  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
    // Save [lang, country code] to storage
    Get.find<StorageService>()
        .write('locale', [locale.languageCode, locale.countryCode]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Name
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${'name'.tr}:",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '$firstName $lastName',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    buildNameDialog(context);
                  },
                  child: Text('edit'.tr),
                ),
              ],
            ),

            const SizedBox(
              height: 10,
            ),

            // Reminder
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${'reminder_set'.tr}:",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  width: 10,
                ),
                Switch(
                  value: reminderSet,
                  onChanged: (value) {
                    setState(() {
                      reminderSet = value;
                    });
                    StorageService().write('reminderSet', value);
                  },
                ),
              ],
            ),

            (timeSet)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${'time_set'.tr}:",
                        style: TextStyle(
                            fontSize: 20,
                            color: (reminderSet) ? Colors.black : Colors.grey),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        _formatTime(int.parse(time[0] ?? '00'),
                            int.parse(time[1] ?? '00')),
                        style: TextStyle(
                            fontSize: 20,
                            color: (reminderSet) ? Colors.black : Colors.grey),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: (!reminderSet)
                            ? null
                            : () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay(
                                      hour: int.parse(time[0] ?? '00'),
                                      minute: int.parse(time[1] ?? '00')),
                                ).then((value) {
                                  if (value != null) {
                                    setState(() {
                                      time = [
                                        value.hour.toString(),
                                        value.minute.toString()
                                      ];
                                      timeSet = true;
                                      StorageService().write('timeSet', true);
                                      StorageService().write('time', time);
                                    });
                                  }
                                });
                              },
                        child: Text('edit'.tr),
                      ),
                    ],
                  )
                : Container(),

            const SizedBox(
              height: 10,
            ),

            // Locale
            ElevatedButton(
              onPressed: () {
                buildLanguageDialog(context);
              },
              child: Text('change_language'.tr),
            ),
          ],
        ),
      ),
    );
  }

  buildLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          title: Center(child: Text('choose_your_language'.tr)),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Center(
                      child: Text(
                        locale[index]['flag'] + " " + locale[index]['name'],
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    onTap: () {
                      print(locale[index]['name']);
                      updateLanguage(locale[index]['locale']);
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  // get color from main.dart theme
                  color: Colors.indigo,
                );
              },
              itemCount: locale.length,
            ),
          ),
        );
      },
    );
  }

  buildNameDialog(BuildContext context) {
    final firstNameController = TextEditingController(text: firstName);
    final lastNameController = TextEditingController(text: lastName);

    showDialog(
      context: context,
      builder: (builder) {
        return StatefulBuilder(
          builder: (context, newSetState) {
            return AlertDialog(
              title: Text('your_details'.tr),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'first_name'.tr,
                      ),
                      controller: firstNameController,
                      onChanged: (value) {
                        newSetState(() {
                          firstName = value;
                        });
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'last_name'.tr,
                      ),
                      controller: lastNameController,
                      onChanged: (value) {
                        newSetState(() {
                          lastName = value;
                        });
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (firstName.isNotEmpty && lastName.isNotEmpty) {
                          StorageService()
                              .write('firstName', firstNameController.text);
                          StorageService()
                              .write('lastName', lastNameController.text);
                          setState(() {
                            firstName = firstNameController.text;
                            lastName = lastNameController.text;
                          });
                          newSetState(() {
                            firstName = firstNameController.text;
                            lastName = lastNameController.text;
                          });
                          Get.back();
                        }
                      },
                      child: Text('save'.tr),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                          (states) =>
                              (firstName.isNotEmpty && lastName.isNotEmpty)
                                  ? Colors.indigo
                                  : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
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
