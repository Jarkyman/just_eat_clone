import 'package:get/get.dart';
import 'package:just_eat_clone/controllers/auth_controller.dart';
import 'package:just_eat_clone/controllers/cart_controller.dart';
import 'package:just_eat_clone/controllers/location_controller.dart';
import 'package:just_eat_clone/controllers/popular_product_controller.dart';
import 'package:just_eat_clone/data/api/api_client.dart';
import 'package:just_eat_clone/data/repository/auth_repo.dart';
import 'package:just_eat_clone/data/repository/cart_repo.dart';
import 'package:just_eat_clone/data/repository/location_repo.dart';
import 'package:just_eat_clone/data/repository/popular_product_repo.dart';
import 'package:just_eat_clone/data/repository/user_repo.dart';
import 'package:just_eat_clone/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/recommended_product_controller.dart';
import '../controllers/user_controller.dart';
import '../data/repository/recommended_product_repo.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  //API client
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));
  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));

  //Repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(
      () => LocationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  //Controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));
}
