import 'package:fluentify/interfaces/user.pb.dart';
import 'package:fluentify/utils/api.dart';

class UserRepository {
  static Future<GetUserResponse> getUser(GetUserRequest request) async {
    final client = await API.getAuthenticatedClient();

    final response = await client.post(
      '/GetUser',
      data: request.toProto3Json(),
    );

    return GetUserResponse.create()..mergeFromProto3Json(response.data);
  }

  static Future<UpdateUserResponse> updateUser(
    UpdateUserRequest request,
  ) async {
    final client = await API.getAuthenticatedClient();

    final response = await client.post(
      '/UpdateUser',
      data: request.toProto3Json(),
    );

    return UpdateUserResponse.create()..mergeFromProto3Json(response.data);
  }

  static Future<DeleteUserResponse> deleteUser(
    DeleteUserRequest request,
  ) async {
    final client = await API.getAuthenticatedClient();

    final response = await client.post(
      '/DeleteUser',
      data: request.toProto3Json(),
    );

    return DeleteUserResponse.create()..mergeFromProto3Json(response.data);
  }
}
