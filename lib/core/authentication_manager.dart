import 'package:auth_manager/core/cache_manager.dart';
import 'package:auth_manager/models/user_model.dart';
import 'package:auth_manager/services/login_service.dart';
import 'package:get/get.dart';

class AuthenticationManager extends GetxController with CacheManager {
  final isLogged = false.obs;

  Rxn<UserModel> user = Rxn<UserModel>();

  late final LoginService _loginService;

  @override
  void onInit() {
    super.onInit();
    _loginService = Get.put(LoginService());
  }

  void logOut() {
    isLogged.value = false;
    removeToken();
    user.value = null;
  }

  void login(String? token, UserModel user) async {
    isLogged.value = true;
    //Token is cached
    await saveToken(token);
    setUserData(user);
  }

  Future<void> checkLoginStatus() async {
    final token = getToken();
    if (token != null) {
      isLogged.value = true;
      await getUser(token);
    }
  }

  void setUserData(UserModel userModel) {
    user.value = userModel;
  }

  Future<void> getUser(String token) async {
    print(token);
    try {
      UserModel? user = await _loginService.getUser(token);
      if (user != null) {
        setUserData(user);
      } else {
        logOut();
      }
    } catch (e) {
      print(e);
    } finally {}
  }
}
