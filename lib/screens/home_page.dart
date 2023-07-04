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
    if (StorageService().read('locale') == null) {
      // Show language dialog if locale is not set
      WidgetsBinding.instance.addPostFrameCallback((_) {
        buildLanguageDialog(context);
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('title'.tr),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${'welcome'.tr}, John",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                buildLanguageDialog(context);
              },
              child: Text('change_language'.tr),
            ),
            const SizedBox(
              height: 10,
            ),
            // Unset locale from storage button
            // ElevatedButton(
            //   onPressed: () {
            //     StorageService().remove('locale');
            //   },
            //   child: Text('unset_locale'.tr),
            // ),
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
          content: Container(
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
}
