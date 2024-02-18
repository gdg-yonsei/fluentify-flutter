import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluentify/data/topics.dart';
import 'package:fluentify/interfaces/topic.pb.dart';

class TopicRepository {
  final Dio dio = Dio(BaseOptions(baseUrl: 'http://api.fluentify.dev'));

  Future<ListTopicsResponse> listTopics(ListTopicsRequest request) async {
    final response = await dio.post('/ListTopics');

    return ListTopicsResponse.fromJson(json.encode(response.data));
  }

  // TODO: API 연동
  Future<GetTopicResponse> getTopic(GetTopicRequest request) async {
    await Future.delayed(const Duration(seconds: 1));

    return GetTopicResponse(
      topic: sampleTopics.firstWhere((topic) => topic.id == request.id),
    );
  }
}
