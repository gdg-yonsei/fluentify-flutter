import 'package:fluentify/interfaces/topic.pb.dart';
import 'package:fluentify/repositories/topic.dart';

class TopicService {
  Future<List<CompactTopicDTO>> listTopics() async {
    final request = ListTopicsRequest();
    final response = await TopicRepository.listTopics(request);

    return response.topics;
  }

  Future<TopicDTO> getTopic({required String id}) async {
    final request = GetTopicRequest(id: id);
    final response = await TopicRepository.getTopic(request);

    return response.topic;
  }
}
