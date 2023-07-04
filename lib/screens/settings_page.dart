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
}
