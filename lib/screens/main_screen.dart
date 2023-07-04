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
  final _currentIndex = 0.obs;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (_currentIndex.value) {
          case 0:
            return HomePage();
          case 1:
            return const SchedulePage();
          case 2:
            return const SettingsPage();
          default:
            return Container();
        }
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex.value,
        onTap: (index) {
          setState(() {
            _currentIndex.value = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home), label: 'home'.tr),
          BottomNavigationBarItem(
              icon: const Icon(Icons.calendar_today), label: 'schedule'.tr),
          BottomNavigationBarItem(
              icon: const Icon(Icons.settings), label: 'settings'.tr),
        ],
        enableFeedback: true,
      ),
    );
  }
}
