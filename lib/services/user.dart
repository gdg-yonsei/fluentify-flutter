import 'package:fluentify/interfaces/user.pb.dart';
import 'package:fluentify/repositories/user.dart';

class UserService {
  Future<UserDTO> getUser({required String id}) async {
    final request = GetUserRequest(id: id);
    final response = await UserRepository.getUser(request);

    return response.user;
  }

  Future<UserDTO> updateUser({
    required String id,
    String? name,
    int? age,
  }) async {
    final request = UpdateUserRequest(id: id, name: name, age: age);
    final response = await UserRepository.updateUser(request);

    return response.user;
  }

  Future<String> deleteUser({required String id}) async {
    final request = DeleteUserRequest(id: id);
    final response = await UserRepository.deleteUser(request);

    return response.id;
  }
}
