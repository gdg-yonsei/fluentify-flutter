import 'package:fluentify/interfaces/sentence.pb.dart';
import 'package:fluentify/utils/client.dart';

class SentenceRepository {
  Future<GetSentenceResponse> getSentence(GetSentenceRequest request) async {
    final response = await dio.post(
      '/GetSentence',
      data: request.toProto3Json(),
    );

    return GetSentenceResponse.create()..mergeFromProto3Json(response.data);
  }
}
