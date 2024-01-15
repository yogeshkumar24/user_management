import 'package:get/get.dart';
import 'package:user_management/auth/model/login_request.dart';
import 'package:user_management/auth/model/login_response.dart';
import 'package:user_management/auth/service/auth_service.dart';
import 'package:user_management/shared/log.dart';
import 'package:user_management/shared/util/app_utils.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  Future<bool> login(LoginRequest request) async {
    try {
      isLoading.value = true;
      LoginResponse response = await Get.find<AuthService>().login(request);
      isLoading.value = false;
      if (response.username != null) {
        return true;
      }
      return false;
    } catch (e) {
      isLoading.value = false;
      AppUtils.showToast(e.toString());
      Log.e(e);
      return false;
    }
  }
}
