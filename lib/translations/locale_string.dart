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
          'language': 'Language',
          'schedule': 'Schedule Reminders',
          'settings': 'User Settings',
          'change_language': 'Change Language',
          'logout': 'Logout',
          'choose_your_language': 'Choose your language',
          'your_details': 'Your Details',
          'enter_name': 'Enter your name',
          'enter_age': 'Enter your age',
          'edit': 'Edit',
        },

        // Arabic
        'ar_AR': {
          'welcome': 'مرحبا',
          'title': 'Pylera App',
          'home': 'الصفحة الرئيسية',
          'name': 'الاسم',
          'age': 'العمر',
          'language': 'اللغة',
          'schedule': 'تذكير الجدول',
          'settings': 'إعدادات المستخدم',
          'change_language': 'تغيير اللغة',
          'logout': 'تسجيل خروج',
          'choose_your_language': 'اختر لغتك',
          'your_details': 'تفاصيلك',
          'enter_name': 'أدخل اسمك',
          'enter_age': 'أدخل عمرك',
          'edit': 'تصحيح',
        },

        // Urdu
        'ur_PK': {
          'welcome': 'خوش آمدید',
          'title': 'Pylera App',
          'home': 'ہوم',
          'name': 'نام',
          'age': 'عمر',
          'language': 'زبان',
          'schedule': 'یاد دہانی کا شیڈول',
          'settings': 'صارف کی ترتیبات',
          'change_language': 'زبان تبدیل کریں',
          'logout': 'لاگ آوٹ',
          'choose_your_language': 'اپنی زبان منتخب کریں',
          'your_details': 'آپ کی تفصیلات',
          'enter_name': 'اپنا نام درج کریں',
          'enter_age': 'اپنی عمر درج کریں',
          'edit': 'ترمیم کریں',
        },
      };
}
