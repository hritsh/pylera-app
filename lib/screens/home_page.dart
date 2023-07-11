import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pylera_app/screens/main_screen.dart';
import 'package:pylera_app/screens/schedule_page.dart';
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

  bool reminderSet = StorageService().read('reminderSet') ?? false;
  bool timeSet = StorageService().read('timeSet') ?? false;
  List date = StorageService().read('date') ?? [];
  List endDate = StorageService().read('endDate') ?? [];
  List times = StorageService().read('times') ?? [];
  List pyleraTaken = StorageService().read('pyleraTaken') ?? [];
  List omeprazoleTaken = StorageService().read('omeprazoleTaken') ?? [];

  int daysPassed = 0;
  double progressPercent = 40;
  int pylreaCompleted = 0;
  int omepremazoleCompleted = 0;
  String nextDose = '12:00 PM';

  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
    // Save [lang, country code] to storage
    Get.find<StorageService>()
        .write('locale', [locale.languageCode, locale.countryCode]);
  }

  setUp() {
    if (StorageService().read('locale') == null) {
      // updateLanguage(Get.deviceLocale!);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        buildLanguageDialog(context).then((value) {
          buildNameDialog(context);
        });
      });
    }
  }

  getDaysPassed() {
    DateTime storedDate = DateTime(
      int.parse(date[0]),
      int.parse(date[1]),
      int.parse(date[2]),
    );
    DateTime today = DateTime.now();
    setState(() {
      daysPassed = today.difference(storedDate).inDays;
      progressPercent = (daysPassed / 10) * 100;
    });

    if (daysPassed >= 10) {
      setState(() {
        progressPercent = 100;
      });
    }
  }

  getDosesCompletedToday() {
    getDaysPassed();
    List pyleraToday = pyleraTaken[daysPassed];
    List omeprazoleToday = omeprazoleTaken[daysPassed];
    int index = pyleraToday.indexOf(false);
    setState(() {
      pylreaCompleted = pyleraToday.where((e) => e).length;
      omepremazoleCompleted = omeprazoleToday.where((e) => e).length;
      progressPercent +=
          pylreaCompleted * 1 / 6 + omepremazoleCompleted * 1 / 6;
      // index of first instance of false on pyleraToday
      nextDose = (index != -1)
          ? _formatTime(int.parse(times[index][0]), int.parse(times[index][1]))
          : "Tomorrow";
    });
  }

  String _formatTime(int hour, int minute) {
    // Convert to 12 hour format
    final hour12 = (hour > 12) ? hour - 12 : hour;
    final amPm = (hour >= 12) ? 'PM' : 'AM';
    // Add leading zero to minutes
    final minuteStr = (minute < 10) ? '0$minute' : '$minute';
    return '$hour12:$minuteStr $amPm';
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
            icon: const Icon(Icons.language),
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
            const SizedBox(height: 20),
            Text(
              "${"welcome".tr}, $firstName",
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "learn_about".tr,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 30),

            Row(
              children: [
                const SizedBox(width: 25),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const HPyloriInfo());
                  },
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image:
                            Image.asset('assets/images/hpylori_3.webp').image,
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
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "H.Pylori",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
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
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const PyleraInfo());
                  },
                  child: Container(
                    width: 180,
                    height: 180,
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
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "PYLERA",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
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
            const SizedBox(height: 20),
            (reminderSet && timeSet)
                ? dashboard()
                : Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        Container(
                          height: 250,
                          width: double.maxFinite,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Start Treatment',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo,
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Begin your treatment by setting reminders for a 10 day PYLERA®️ and Ompremazole course and get timely notifications for your doses',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  NavigationService.navigateTo('schedule');
                                },
                                child: Text('start_treatment'.tr),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                    (states) => Colors.indigo,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
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
          title: Center(
              child: Text(StorageService().read('locale') != null
                  ? 'select_language'.tr
                  : "Select language")),
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
                        locale[index]['name'],
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

  // the user can see dashboard with a main stats card with
  //(a) progress bar showing how far have they progressed in their treatment with percentage completed
  //(b) x/y PYLERA completed x/y omepremazole completed
  //(c) next dose for the 10 days period
  Widget dashboard() {
    getDosesCompletedToday();
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  'Your Progress',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                // Progress bar
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: LinearProgressIndicator(
                        value: progressPercent / 100,
                        backgroundColor: Colors.grey[300],
                        color: Colors.indigo,
                        minHeight: 10,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(progressPercent.toStringAsFixed(0) + '%'),
                  ],
                ),
                const SizedBox(height: 16),
                // Days complete
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Days Complete:',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('$daysPassed/10'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Days Remaining:',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('${10 - daysPassed}/10'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('PYLREA:',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('$pylreaCompleted doses taken today'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('OMEPRAZOLE:',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('$omepremazoleCompleted doses taken today'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                        text: TextSpan(
                      text: 'Next Dose: ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: '$nextDose',
                          style: TextStyle(
                            color: Colors.indigo,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )),
                    ElevatedButton(
                      onPressed: () {
                        NavigationService.navigateTo('schedule');
                      },
                      child: const Text('View More'),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
