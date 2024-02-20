import 'package:fluentify/interfaces/topic.pb.dart';
import 'package:fluentify/utils/api.dart';

class TopicRepository {
  static Future<ListTopicsResponse> listTopics(
    ListTopicsRequest request,
  ) async {
    final client = await API.getAuthenticatedClient();

    final response = await client.post(
      '/ListTopics',
      data: request.toProto3Json(),
    );

    return ListTopicsResponse.create()..mergeFromProto3Json(response.data);
  }

  static Future<GetTopicResponse> getTopic(GetTopicRequest request) async {
    final client = await API.getAuthenticatedClient();

    final response = await client.post(
      '/GetTopic',
      data: request.toProto3Json(),
    );

    return GetTopicResponse.create()..mergeFromProto3Json(response.data);
  }
}
