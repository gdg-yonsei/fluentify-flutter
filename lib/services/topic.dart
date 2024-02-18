import 'package:fluentify/interfaces/topic.pb.dart';
import 'package:fluentify/repositories/topic.dart';

class TopicService {
  final TopicRepository topicRepository = TopicRepository();

  Future<List<CompactTopicDTO>> listTopics() async {
    final request = ListTopicsRequest();
    final response = await topicRepository.listTopics(request);

    return response.topics;
  }

  Future<TopicDTO> getTopic({required String id}) async {
    final request = GetTopicRequest(id: id);
    final response = await topicRepository.getTopic(request);

    return response.topic;
  }
}
