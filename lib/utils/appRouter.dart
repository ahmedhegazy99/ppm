import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pro_player_market/screens/about/about.dart';
import 'package:pro_player_market/screens/authenticate/login.dart';
import 'package:pro_player_market/screens/authenticate/signup.dart';
import 'package:pro_player_market/screens/contactUs.dart';
import 'package:pro_player_market/screens/home.dart';
import 'package:pro_player_market/screens/profile.dart';
import 'package:pro_player_market/screens/requests.dart';
import 'package:pro_player_market/screens/splash.dart';

import '../mainBar.dart';

class AppRouter {
  // General
  static const String homeRoute = '/';
  static const String aboutRoute = '/about';
  static const String contactRoute = '/contactUs';
  static const String splashRoute = '/splash';
  static const String mainBarRoute = '/mainBar';

  // Auth
  static const String loginRoute = '/login';
  static const String signupRoute = '/signUp';

  // User
  static const String userProfile = '/userProfile';

  //admin only
  static const String requestsRoute = '/requests';


  static Route<dynamic> generateGlobalRoutes(RouteSettings settings) {
    switch (settings.name) {
      case "\\":
      case homeRoute:
        return MaterialPageRoute(builder: (_) => Home(), settings: settings);
      case splashRoute:
        return MaterialPageRoute(builder: (_) => Splash(), settings: settings);
      case loginRoute:
        return MaterialPageRoute(builder: (_) => Login(), settings: settings);
      case signupRoute:
        return MaterialPageRoute(builder: (_) => Signup(), settings: settings);
      case mainBarRoute:
        return MaterialPageRoute(builder: (_) => MainBar(), settings: settings);
      case contactRoute:
        return MaterialPageRoute(
            builder: (_) => ContactUs(), settings: settings);
      case aboutRoute:
        return MaterialPageRoute(builder: (_) => About(), settings: settings);
      case userProfile:
        return MaterialPageRoute(builder: (_) => Profile(), settings: settings);
      case requestsRoute:
        return MaterialPageRoute(builder: (_) => Requests(), settings: settings);
      default:
        return MaterialPageRoute(builder: (_) => Home(), settings: settings);
    }
  }
}

//  routes: {
//         '/login': (context) => Login(),
//         '/signup': (context) => Signup(),
//         '/mainBar': (context) => MainBar(),
//       },
