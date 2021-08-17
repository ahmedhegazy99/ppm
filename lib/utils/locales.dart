import 'package:get/get.dart';

class Locales extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'home': 'Home',
          'login': 'Log in',
          'signup': 'Sign Up',
          'error': 'Error',
          'email': 'Email',
          'password': 'Password',
          'changeLocale': 'Change Locale',
          'success': 'Success',
          'successfulRegister': 'You Registered Successfuly',
          'signout': 'Sign Out',
          'add': 'Add',
          'delete': 'Delete',
          'username': 'Username',
          'loading': 'Loading...',
          'title': 'Title',
          'welcome': 'Welcome',
          'noData': 'No Data',
          'cancel': 'Cancel',
        },
        'ar': {
          'home': 'الرئيسية',
          'login': 'تسجيل الدخول',
          'signup': 'تسجيل',
          'error': "حدث خطأ ما",
          'email': 'البريد الإلكتروني',
          'password': 'كلمة المرور',
          'changeLocale': 'تغيير اللغة',
          'success': 'تم',
          'successfulRegister': 'تم التسجيل بنجاح',
          'signout': 'تسجيل الخروج',
          'add': 'اضافة',
          'delete': 'حذف',
          'username': 'اسم المستخدم',
          'loading': 'جار التحميل...',
          'title': 'العنوان',
          'welcome': 'مرحبا',
          'noData': 'لا يوجد بيانات',
          'cancel': 'الغاء',
        }
      };
}
