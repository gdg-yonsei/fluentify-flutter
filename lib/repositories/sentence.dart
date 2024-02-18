import 'package:fluentify/data/sentences.dart';
import 'package:fluentify/interfaces/sentence.pb.dart';

class SentenceRepository {
  // TODO: API 연동
  Future<GetSentenceResponse> getSentence(GetSentenceRequest request) async {
    await Future.delayed(const Duration(seconds: 1));

    return GetSentenceResponse(
      sentence: sampleSentences.firstWhere(
        (sentence) => sentence.id == request.id,
      ),
    );
  }
}
