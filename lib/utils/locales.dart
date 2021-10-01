import 'package:get/get.dart';

class Locales extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'home': 'Home',
          'profile': 'Profile',
          'requests': 'Requests',
          'login': 'Login',
          "LOGIN": "LOGIN",
          'signup': 'Sign Up',
          'error': 'Error',
          'email': 'Email',
          'enter an email': 'Enter an email',
          'phone': 'Phone',
          'password': 'Password',
          'confirm password': 'Confirm Password',
          'update password': 'Update Password',
          'enter an password': 'Enter an password',
          'changeLocale': 'Change Locale',
          'success': 'Success',
          'done': 'Done',
          'successfulRegister': 'You Registered Successfuly',
          'logout': 'Log Out',
          'add': 'Add',
          'update': 'Update',
          'edit': 'Edit',
          'delete': 'Delete',
          'username': 'Username',
          'loading': 'Loading...',
          'title': 'Title',
          'welcome': 'Welcome',
          'noData': 'No Data',
          'cancel': 'Cancel',
          'settings': 'Settings',
          'about': 'About',
          'club': 'Club',
          'player': 'Player',
          'Player Name':"Player Name",
          'requester': 'Requester',
          "Request Deal" : "Request Deal",
          "Can't Request": "Can't Request",
          'language': 'العربية',
          'sell player': 'Sell Player',
          'type': 'Type',
          'like' : 'Like',
          'view more' : 'View more',
          'name': 'Name',
          'city': 'City',
          'age': 'Age',
          'bio': 'Bio',
          "Contact info": "Contact info",
          "approve": "Approve",
          "decline": "Decline",
          "Player Buy Request by": "Player Buy Request by",
          "Player is Requested to be added by": "Player is Requested to be added by",
          'Are you sure you want to delete player?': 'Are you sure you want to delete player?',
          'Delete Player': 'Delete Player',
          'cities': 'Cities',
          'create': 'Create',
          'select video': 'Select Video',
          "Forgot Password?": "Forgot Password?",
          "you don't have an account? Sign Up.": "you don't have an account? Sign Up.",
          'birthdate': 'Birthdate',
          'select':'select',
          'filter':'Filter',
          "You already submitted a request": "You already submitted a request",
          'write biography of player': 'write biography of player',
          'Enter Player Name': 'Enter Player Name',
          'photo': 'Photo',
          'video': 'Video',
        },
        'ar': {
          'home': 'الرئيسية',
          'profile': 'الملف الشخصي',
          'requests': 'الطلبات',
          'login': 'تسجيل الدخول',
          "LOGIN": 'تسجيل الدخول',
          'signup': 'تسجيل',
          'error': "حدث خطأ ما",
          'email': 'البريد الإلكتروني',
          'enter an email': 'ادخل البريد الإلكتروني',
          'phone': 'الهاتف',
          'password': 'كلمة المرور',
          'confirm password': 'تأكيد كلمة المرور',
          'update password': 'تغير كلمة المرور',
          'enter an password': 'ادخل كلمة المرور',
          'changeLocale': 'تغيير اللغة',
          'success': 'تم بنجاح',
          'done': 'تم',
          'successfulRegister': 'تم التسجيل بنجاح',
          'logout': 'تسجيل الخروج',
          'add': 'اضافة',
          'update': 'تحديث',
          'edit': 'تعديل',
          'delete': 'حذف',
          'username': 'اسم المستخدم',
          'loading': 'جار التحميل...',
          'title': 'العنوان',
          'welcome': 'مرحبا',
          'noData': 'لا يوجد بيانات',
          'cancel': 'الغاء',
          'settings': 'الأعدادات',
          'about': 'نبذة عنا',
          'club': 'نادي',
          'player': 'اللاعب',
          'Player Name':'اسم اللاعب',
          'requester': 'الطالب',
          "Request Deal" : 'طلب اتفاق',
          "Can't Request": 'لا يمكنك الطلب',
          'language': 'English',
          'sell player': 'بيع لاعب',
          'type': 'نوع',
          'like': 'إعجاب',
          'view more' : 'المزيد',
          'name': 'الأسم',
          'city': 'المدينة',
          'age': 'السن',
          'bio': 'السيرة الذاتية',
          "Contact info": 'معلومات التواصل',
          "approve": 'موافقة',
          "decline": 'رفض',
          "Player Buy Request by": "اللاعب طلب شرائه من",
          "Player is Requested to be added by": "الاعب طلب ليتم اضافته من",
          'Are you sure you want to delete player?': 'هل انت متأكد من انك تريد حذف اللاعب؟',
          'Delete Player': 'حذف اللاعب',
          'cities': 'المدن',
          'create': 'انشاء',
          'select video': 'اختر فيديو',
          "Forgot Password?": 'نسيت كلمة المرور؟',
          "you don't have an account? Sign Up.": "ليس لديك حساب؟ تسجيل الدخول.",
          'birthdate': 'تاريخ الميلاد',
          'select':'اختر',
          'filter':'تصفية',
          "You already submitted a request": "لقد قدمت طلب بالفعل",
          'write biography of player': 'اكتب سيرة اللاعب الذاتية',
          'Enter Player Name': 'ادخل اسم اللاعب',
          "Full Name": 'الاسم الكامل',
          'Enter Full Name': 'ادخل الاسم الكامل',
          "Enter an email": 'ادخل بريد الكتروني',
          "Please enter valid email": 'ادخل بريد الكتروني صحيح',
          'Enter mobile number': 'ادخل رقم هاتف',
          "Mobile Number": 'رقم هاتف',
          "Please enter password": 'ادخل كلمة سر',
          "Your password should is too short": 'كلمة السر قصيرة للغاية',
          "Your password should match criteria": 'كلمة السر يجب ان تتوافق مع المعاير',
          "Password didn't match": 'كلمة السر لا تتوافق',
          "*Your password should be 8 character or more\n*Your password should contains Capital & small letters\n*Your password should contains numbers & special characters": '*كلمة مرورك يجب ان تكون 8 احرف او اكثر\n*كلمة مرورك يجب ان تحتوي علي حروف كبيرة و صغيرة\n*كلمة مرورك يجب ان تحتوي علي ارقام و علامات مميزة',
          "You haven't add player Yet": 'لم تضيف لاعب بعد',
          'photo': 'صورة',
          'video': 'فيديو',
        }
      };
}
