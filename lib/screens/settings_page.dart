import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pylera_app/services/storage_service.dart';

class SettingsPage extends StatelessWidget {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('title'.tr),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // show name, age and locale with edit buttons
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
                  StorageService().read('name') ?? '',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    buildNameAgeDialog(context);
                  },
                  child: Text('edit'.tr),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            // Age
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${'age'.tr}:",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  StorageService().read('age') ?? '',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    buildNameAgeDialog(context);
                  },
                  child: Text('edit'.tr),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),

            // Locale
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${'language'.tr}:",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  StorageService().read('locale') != null
                      ? StorageService().read('locale')[0]
                      : '',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    buildLanguageDialog(context);
                  },
                  child: Text('edit'.tr),
                ),
              ],
            ),

            const SizedBox(
              height: 10,
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
          title: Text('choose_your_language'.tr),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Text(locale[index]['name']),
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

  buildNameAgeDialog(BuildContext context) {
    showDialog(
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
                    hintText: 'enter_name'.tr,
                  ),
                  onChanged: (value) {
                    StorageService().write('name', value);
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'enter_age'.tr,
                  ),
                  onChanged: (value) {
                    StorageService().write('age', value);
                  },
                  // Only allow numbers
                  keyboardType: TextInputType.number,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('save'.tr),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
