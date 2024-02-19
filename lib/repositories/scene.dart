import 'package:dio/dio.dart';
import 'package:fluentify/interfaces/scene.pb.dart';

class SceneRepository {
  final Dio dio = Dio(BaseOptions(baseUrl: 'http://api.fluentify.dev'));

  Future<GetSceneResponse> getScene(GetSceneRequest request) async {
    final response = await dio.post('/GetScene', data: request.toProto3Json());

    return GetSceneResponse.create()..mergeFromProto3Json(response.data);
  }
}
