import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:user_management/auth/model/login_request.dart';
import 'package:user_management/auth/model/login_response.dart';
import 'package:user_management/auth/service/auth_service.dart';
import 'package:user_management/shared/util/app_utils.dart';
import 'package:user_management/shared/widget/custom_alert_dialog.dart';

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
      if (e is DioException) {
        CustomAlertDialog.show(title: "Error", message: e.message.toString());
      } else {
        AppUtils.showToast(e.toString());
      }
      return false;
    }
  }
}
