import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pylera_app/services/storage_service.dart';
import 'package:pylera_app/screens/info_pages.dart';

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
              "welcome".tr + ", " + StorageService().read('firstName'),
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "learn_about".tr,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Get.to(() => HPyloriInfo());
              },
              child: Container(
                width: 300,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://d2jx2rerrg6sh3.cloudfront.net/image-handler/picture/2018/7/shutterstock_586012724.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      colors: [
                        Colors.black.withOpacity(.4),
                        Colors.black.withOpacity(.2),
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "H.Pylori",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Get.to(() => PyleraInfo());
              },
              child: Container(
                width: 300,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://www.grxstatic.com/d4fuqqd5l3dbz/products/cwf_tms/Package_22082.PNG"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      colors: [
                        Colors.black.withOpacity(.4),
                        Colors.black.withOpacity(.2),
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "PYLERA",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
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
