import 'package:fluentify/interfaces/sentence.pb.dart';
import 'package:fluentify/repositories/sentence.dart';

class SentenceService {
  static Future<SentenceDTO> getSentence({required String id}) async {
    final request = GetSentenceRequest(id: id);
    final response = await SentenceRepository.getSentence(request);

    return response.sentence;
  }
}
