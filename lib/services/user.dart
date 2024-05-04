import 'package:fluentify/interfaces/user.pb.dart';
import 'package:fluentify/repositories/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static Future<UserDTO> getUser({required String id}) async {
    final request = GetUserRequest(id: id);
    final response = await UserRepository.getUser(request);

    return response.user;
  }

  static Future<UserDTO> updateUser({
    required String id,
    String? name,
    int? age,
  }) async {
    final request = UpdateUserRequest(id: id, name: name, age: age);
    final response = await UserRepository.updateUser(request);

    return response.user;
  }

  static Future<String> deleteUser({required String id}) async {
    final request = DeleteUserRequest(id: id);
    final response = await UserRepository.deleteUser(request);

    return response.id;
  }

  static Future<bool> checkAssistiveDeviceConfirmable() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool('assistive-device-confirmable') ?? true;
  }

  static Future<void> updateAssistiveDeviceConfirmable(
    bool updatedValue,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('assistive-device-confirmable', updatedValue);
  }
}
