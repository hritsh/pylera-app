import 'package:flutter/material.dart';
import 'package:pylera_app/screens/main_screen.dart';
import 'package:pylera_app/services/notification_service.dart';
import 'package:pylera_app/translations/locale_string.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pylera_app/services/storage_service.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // Initialize splash screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // Initialize notification service
  NotificationService().initNotification();
  tz.initializeTimeZones();
  // Initialize storage service
  Get.lazyPut(() => StorageService());
  GetStorage.init().then((value) => runApp(MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 1))
        .then((value) => FlutterNativeSplash.remove());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: LocaleString(),
      // Read locale saved in storage or default to English
      locale: StorageService().read('locale') != null
          ? Locale(StorageService().read('locale')[0],
              StorageService().read('locale')[1])
          : null,
      fallbackLocale: const Locale('en', 'US'),
      title: 'Pylera App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MainScreen(),
    );
  }
}
