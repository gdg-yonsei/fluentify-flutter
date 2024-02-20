import 'package:fluentify/interfaces/sentence.pb.dart';
import 'package:fluentify/utils/api.dart';

class SentenceRepository {
  static Future<GetSentenceResponse> getSentence(
    GetSentenceRequest request,
  ) async {
    final client = await API.getAuthenticatedClient();

    final response = await client.post(
      '/GetSentence',
      data: request.toProto3Json(),
    );

    return GetSentenceResponse.create()..mergeFromProto3Json(response.data);
  }
}
