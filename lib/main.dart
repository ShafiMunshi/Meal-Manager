import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_manager/controller/bajar_controller.dart';
import 'package:meal_manager/controller/data_controller.dart';
import 'package:meal_manager/controller/meal_controller.dart';
import 'package:meal_manager/firebase_options.dart';
import 'package:meal_manager/routes/app_routes.dart';
import 'package:meal_manager/screens/home/home_screen.dart';
import 'package:meal_manager/screens/introduction/introduction.dart';
import 'package:meal_manager/utils/theme_data.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var cc = Get.put(BazarController());
    return GetMaterialApp(
        title: 'Meal Manager',
        initialBinding: BindingsBuilder(() {
          Get.put(DataController());
          Get.put(MealController());

          Get.put(BazarController());
        }),
        theme: myThemeData(),
        // defaultTransition: Transition.fadeIn,
        // initialRoute: '/',
        getPages: AppRoutes.getPages,
        home: Introduction());
  }
}
