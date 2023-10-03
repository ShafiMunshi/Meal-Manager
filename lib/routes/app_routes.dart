import 'package:get/get.dart';
import 'package:meal_manager/controller/bajar_controller.dart';
import 'package:meal_manager/controller/manager_money_conntroller.dart';
import 'package:meal_manager/controller/meal_controller.dart';
import 'package:meal_manager/screens/home/home_screen.dart';
import 'package:meal_manager/screens/bajar/add_bajar_dialog.dart';
import 'package:meal_manager/screens/bajar/bazar_screen.dart';
import 'package:meal_manager/screens/manager-money/manager_money_screen.dart';
import 'package:meal_manager/screens/meals/add_meal_screen.dart';
import 'package:meal_manager/screens/meals/meal_screen.dart';
import 'package:meal_manager/screens/member/member_screen.dart';

class AppRoutes {
  static List<GetPage> getPages = [
    GetPage(name: HomeScreen.routeName, page: () => HomeScreen()),
    GetPage(
        name: BazarScreen.routeName,
        page: () => BazarScreen(),
        binding: BindingsBuilder(() {
          Get.put(BazarController(), permanent: true);
        })),
    GetPage(
      name: AddBazarScreen.routeName,
      page: () => AddBazarScreen(),
    ),
    GetPage(name: MemberScreen.routeName, page: () => MemberScreen()),
    GetPage(
        name: ManagerMoneyScreen.routeName, page: () => ManagerMoneyScreen(),
          binding: BindingsBuilder((){
            Get.put(ManagerMoneyController());
          })
        ),
    GetPage(
        name: MealScreen.routeName,
        page: () => MealScreen(),
        binding: BindingsBuilder(() {
          // MealController();/
          Get.put(MealController());
        })),
    GetPage(name: AddMealScreen.routeName, page: () => AddMealScreen()),
  ];
}
