import 'package:fluentify/interfaces/user.pb.dart';
import 'package:fluentify/utils/client.dart';

class UserRepository {
  Future<GetUserResponse> getUser(GetUserRequest request) async {
    final response = await dio.post('/GetUser');

    return GetUserResponse.create()..mergeFromProto3Json(response.data);
  }

  Future<UpdateUserResponse> updateUser(UpdateUserRequest request) async {
    final response = await dio.post(
      '/UpdateUser',
      data: request.toProto3Json(),
    );

    return UpdateUserResponse.create()..mergeFromProto3Json(response.data);
  }

  Future<DeleteUserResponse> deleteUser(DeleteUserRequest request) async {
    final response = await dio.post(
      '/DeleteUser',
      data: request.toProto3Json(),
    );

    return DeleteUserResponse.create()..mergeFromProto3Json(response.data);
  }
}
