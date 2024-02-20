import 'package:fluentify/interfaces/scene.pb.dart';
import 'package:fluentify/repositories/scene.dart';

class SceneService {
  Future<SceneDTO> getScene({required String id}) async {
    final request = GetSceneRequest(id: id);
    final response = await SceneRepository.getScene(request);

    return response.scene;
  }
}
