import 'package:dio/dio.dart';
import 'package:fluentify/interfaces/topic.pb.dart';

class TopicRepository {
  final Dio dio = Dio(BaseOptions(baseUrl: 'http://api.fluentify.dev'));

  Future<ListTopicsResponse> listTopics(ListTopicsRequest request) async {
    final response = await dio.post('/ListTopics');

    return ListTopicsResponse.create()..mergeFromProto3Json(response.data);
  }

  Future<GetTopicResponse> getTopic(GetTopicRequest request) async {
    final response = await dio.post('/GetTopic', data: request.toProto3Json());

    return GetTopicResponse.create()..mergeFromProto3Json(response.data);
  }
}
