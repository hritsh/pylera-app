import 'package:get/get.dart';

class LocaleString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        // English
        'en_US': {
          'welcome': 'Welcome',
          'title': 'Pylera App',
          'home': 'Home',
          'name': 'Name',
          'age': 'Age',
          'schedule': 'Schedule Reminders',
          'settings': 'User Settings',
          'change_language': 'Change Language',
          'logout': 'Logout',
          'choose_your_language': 'Choose your language',
        },

        // Arabic
        'ar_AR': {
          'welcome': 'مرحبا',
          'title': 'Pylera App',
          'home': 'الصفحة الرئيسية',
          'name': 'الاسم',
          'age': 'العمر',
          'schedule': 'تذكير الجدول',
          'settings': 'إعدادات المستخدم',
          'change_language': 'تغيير اللغة',
          'logout': 'تسجيل خروج',
          'choose_your_language': 'اختر لغتك',
        },

        // Urdu
        'ur_PK': {
          'welcome': 'خوش آمدید',
          'title': 'Pylera App',
          'home': 'ہوم',
          'name': 'نام',
          'age': 'عمر',
          'schedule': 'یاد دہانی کا شیڈول',
          'settings': 'صارف کی ترتیبات',
          'change_language': 'زبان تبدیل کریں',
          'logout': 'لاگ آوٹ',
          'choose_your_language': 'اپنی زبان منتخب کریں',
        },
      };
}
