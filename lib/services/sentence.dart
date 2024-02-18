import 'package:fluentify/interfaces/sentence.pb.dart';
import 'package:fluentify/repositories/sentence.dart';

class SentenceService {
  final SentenceRepository sentenceRepository = SentenceRepository();

  Future<SentenceDTO> getSentence({required String id}) async {
    final request = GetSentenceRequest(id: id);
    final response = await sentenceRepository.getSentence(request);

    return response.sentence;
  }
}
