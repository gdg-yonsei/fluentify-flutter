import 'package:fluentify/data/scenes.dart';
import 'package:fluentify/interfaces/scene.pb.dart';

class SceneRepository {
  // TODO: API 연동
  Future<GetSceneResponse> getSentence(GetSceneRequest request) async {
    await Future.delayed(const Duration(seconds: 1));

    return GetSceneResponse(
      scene: sampleScenes.firstWhere(
        (scene) => scene.id == request.id,
      ),
    );
  }
}
