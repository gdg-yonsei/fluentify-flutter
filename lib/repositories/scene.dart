import 'package:fluentify/interfaces/scene.pb.dart';
import 'package:fluentify/utils/api.dart';

class SceneRepository {
  static Future<GetSceneResponse> getScene(GetSceneRequest request) async {
    final client = await API.getAuthenticatedClient();

    final response = await client.post(
      '/GetScene',
      data: request.toProto3Json(),
    );

    return GetSceneResponse.create()..mergeFromProto3Json(response.data);
  }
}
