import 'package:fluentify/interfaces/scene.pb.dart';
import 'package:fluentify/utils/client.dart';

class SceneRepository {
  Future<GetSceneResponse> getScene(GetSceneRequest request) async {
    final response = await dio.post('/GetScene', data: request.toProto3Json());

    return GetSceneResponse.create()..mergeFromProto3Json(response.data);
  }
}
