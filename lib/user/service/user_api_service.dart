import 'package:dio/dio.dart';
import 'package:user_management/shared/shared.dart';
import 'package:user_management/user/model/user_model.dart';

class UserApiService {
  final Dio _dio = Dio();

  Future<List<UserModel>> fetchUsers() async {
    try {
      final response = await _dio.get(ApiEndpoints.getUserEndpoint);
      if (response.statusCode == 200) {
        List<UserModel> userList = (response.data as List)
            .map((userJson) => UserModel.fromJson(userJson))
            .toList();
        return userList;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print('DioError->> ${e.response!.statusMessage}');
          rethrow;
        } else {
          print('DioError->> $e');
          rethrow;
        }
      } else {
        print('Unexpected error: $e');
        rethrow;
      }
    }
  }
}
