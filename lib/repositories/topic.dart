import 'package:fluentify/data/topics.dart';
import 'package:fluentify/interfaces/topic.pb.dart';

class TopicRepository {
  // TODO: API 연동
  Future<ListTopicsResponse> listTopics() async {
    await Future.delayed(const Duration(seconds: 1));

    return ListTopicsResponse(topics: sampleCompactTopics);
  }

  // TODO: API 연동
  Future<GetTopicResponse> getTopic(GetTopicRequest request) async {
    await Future.delayed(const Duration(seconds: 1));

    return GetTopicResponse(
      topic: sampleTopics.firstWhere((topic) => topic.id == request.id),
    );
  }
}
