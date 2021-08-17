import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_player_market/utils/appRouter.dart';
import 'package:pro_player_market/utils/locales.dart';
import 'controllers/bindings/bindingController.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Locales(),
      locale: Locale('en'),
      initialBinding: BindingController(),
      onGenerateRoute: AppRouter.generateGlobalRoutes,
      initialRoute: AppRouter.splashRoute,
    );
  }
}
