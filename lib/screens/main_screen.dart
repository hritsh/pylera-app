// 3 pages with bottom bar navigation: Home, Schedule, Settings
import 'package:flutter/material.dart';
import 'package:pylera_app/screens/schedule_page.dart';
import 'package:pylera_app/screens/settings_page.dart';
import 'package:pylera_app/screens/home_page.dart';
import 'package:get/get.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final currentIndex = 0.obs;

  @override
  void initState() {
    super.initState();
    Get.put<_MainScreenState>(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (currentIndex.value) {
          case 0:
            return HomePage();
          case 1:
            return SchedulePage();
          case 2:
            return SettingsPage();
          default:
            return Container();
        }
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex.value,
        onTap: (index) {
          setState(() {
            currentIndex.value = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home), label: 'home'.tr),
          BottomNavigationBarItem(
              icon: const Icon(Icons.calendar_today),
              label: 'start_treatment'.tr),
          BottomNavigationBarItem(
              icon: const Icon(Icons.settings), label: 'settings'.tr),
        ],
        enableFeedback: true,
        backgroundColor: Colors.white,
        // golden #6F6C3A
        selectedItemColor: Colors.indigo,
        // top shadow
        elevation: 10,
        selectedFontSize: 14,
        unselectedFontSize: 12,
      ),
    );
  }

  navigateTo(String page) {
    switch (page) {
      case 'home':
        setState(() {
          currentIndex.value = 0;
        });
        break;
      case 'schedule':
        setState(() {
          currentIndex.value = 1;
        });
        break;
      case 'settings':
        setState(() {
          currentIndex.value = 2;
        });
        break;
      default:
        setState(() {
          currentIndex.value = 0;
        });
    }
  }
}

class NavigationService {
  static void navigateTo(String page) {
    final controller = Get.find<_MainScreenState>();
    controller.navigateTo(page);
  }
}
