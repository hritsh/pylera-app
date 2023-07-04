import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pylera_app/services/storage_service.dart';

class HomePage extends StatelessWidget {
  final List locale = [
    {'name': 'ENGLISH', 'locale': const Locale('en', 'US')},
    {'name': 'عربى', 'locale': const Locale('ar', 'AR')},
    {'name': 'اردو', 'locale': const Locale('ur', 'PK')},
  ];

  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
    // Save [lang, country code] to storage
    Get.find<StorageService>()
        .write('locale', [locale.languageCode, locale.countryCode]);
  }

  @override
  Widget build(BuildContext context) {
    // Show language dialog if locale is not set
    if (StorageService().read('locale') == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        buildLanguageDialog(context);
      });
    }

    // Show enter name and age dialog if name or age are not set
    if (StorageService().read('firstName') == null ||
        StorageService().read('lastName') == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        buildNameDialog(context);
      });
    }

    // Uncomment to remove name, age and locale from storage
    // print(StorageService().remove('name'));
    // print(StorageService().remove('age'));
    // print(StorageService().remove('locale'));

    return Scaffold(
      appBar: AppBar(
        title: Text('title'.tr),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${'welcome'.tr}, ${StorageService().read('firstName') ?? ''} ${StorageService().read('lastName') ?? ''}",
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  buildLanguageDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
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
    String firstName = '';
    String lastName = '';

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (builder) {
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
                  onChanged: (value) {
                    firstName = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'last_name'.tr,
                  ),
                  onChanged: (value) {
                    lastName = value;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (firstName.isNotEmpty && lastName.isNotEmpty) {
                      StorageService().write('firstName', firstName);
                      StorageService().write('lastName', lastName);
                      Get.back();
                    }
                  },
                  child: Text('save'.tr),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => (firstName.isNotEmpty && lastName.isNotEmpty)
                          ? Colors.blue
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
  }
}
