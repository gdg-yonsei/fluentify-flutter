import 'package:fluentify/interfaces/user.pb.dart';
import 'package:fluentify/repositories/user.dart';

class UserService {
  final UserRepository userRepository = UserRepository();

  Future<UserDTO> getUser({required String id}) async {
    final request = GetUserRequest(id: id);
    final response = await userRepository.getUser(request);

    return response.user;
  }

  Future<UserDTO> updateUser({
    required String id,
    String? name,
    int? age,
  }) async {
    final request = UpdateUserRequest(id: id, name: name, age: age);
    final response = await userRepository.updateUser(request);

    return response.user;
  }

  Future<String> deleteUser({required String id}) async {
    final request = DeleteUserRequest(id: id);
    final response = await userRepository.deleteUser(request);

    return response.id;
  }
}
