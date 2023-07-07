import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pylera_app/services/storage_service.dart';
import 'package:pylera_app/screens/info_pages.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  setUp() {
    if (StorageService().read('locale') == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        buildLanguageDialog(context).then((value) {
          buildNameDialog(context);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Uncomment to remove name, age and locale from storage
    // print(StorageService().remove('name'));
    // print(StorageService().remove('age'));
    // print(StorageService().remove('locale'));

    // Show language dialog if locale or name is not set
    setUp();

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/newbridge_logo.png',
          width: 200,
        ),
        toolbarHeight: 100,
        actions: [
          IconButton(
            icon: Icon(Icons.language),
            onPressed: () {
              buildLanguageDialog(context);
            },
          ),
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // newbridge_logo.png is in assets/images folder
            // Image.asset(
            //   'assets/images/newbridge_logo.png',
            //   width: 200,
            // ),
            SizedBox(height: 20),
            Text(
              "welcome".tr + ", " + firstName,
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
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Get.to(() => HPyloriInfo());
              },
              child: Container(
                width: 350,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: Image.asset('assets/images/hpylori_3.webp').image,
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
                          shadows: [
                            Shadow(
                              blurRadius: 5,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Get.to(() => PyleraInfo());
              },
              child: Container(
                width: 350,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: Image.asset('assets/images/pylera_1.webp').image,
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
                          shadows: [
                            Shadow(
                              blurRadius: 5,
                              color: Colors.black,
                            ),
                          ],
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

  Future buildLanguageDialog(BuildContext context) {
    return showDialog(
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

  Future buildNameDialog(BuildContext context) {
    final firstNameController = TextEditingController(text: firstName);
    final lastNameController = TextEditingController(text: lastName);

    return showDialog(
      barrierDismissible: false,
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
