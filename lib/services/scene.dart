import 'package:fluentify/interfaces/scene.pb.dart';
import 'package:fluentify/repositories/scene.dart';

class SceneService {
  final SceneRepository sceneRepository = SceneRepository();

  Future<SceneDTO> getScene({required String id}) async {
    final request = GetSceneRequest(id: id);
    final response = await sceneRepository.getScene(request);

    return response.scene;
  }
}
