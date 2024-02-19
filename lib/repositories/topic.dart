import 'package:fluentify/interfaces/topic.pb.dart';
import 'package:fluentify/utils/client.dart';

class TopicRepository {
  Future<ListTopicsResponse> listTopics(ListTopicsRequest request) async {
    final response = await dio.post('/ListTopics');

    return ListTopicsResponse.create()..mergeFromProto3Json(response.data);
  }

  Future<GetTopicResponse> getTopic(GetTopicRequest request) async {
    final response = await dio.post('/GetTopic', data: request.toProto3Json());

    return GetTopicResponse.create()..mergeFromProto3Json(response.data);
  }
}
