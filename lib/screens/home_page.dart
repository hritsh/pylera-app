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
    if (StorageService().read('name') == null ||
        StorageService().read('age') == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        buildNameAgeDialog(context);
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
              "${'welcome'.tr}, ${StorageService().read('name') ?? ''}",
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
      barrierDismissible: false,
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
