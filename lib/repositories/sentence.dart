import 'package:dio/dio.dart';
import 'package:fluentify/interfaces/sentence.pb.dart';

class SentenceRepository {
  final Dio dio = Dio(BaseOptions(baseUrl: 'http://api.fluentify.dev'));

  Future<GetSentenceResponse> getSentence(GetSentenceRequest request) async {
    final response = await dio.post(
      '/GetSentence',
      data: request.toProto3Json(),
    );

    return GetSentenceResponse.create()..mergeFromProto3Json(response.data);
  }
}
