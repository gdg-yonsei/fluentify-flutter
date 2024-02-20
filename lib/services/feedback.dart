import 'package:fluentify/interfaces/feedback.pb.dart';
import 'package:fluentify/repositories/feedback.dart';

class FeedbackService {
  static Future<PronunciationFeedbackDTO> getPronunciationFeedback({
    required String sentenceId,
    required String audioFileUrl,
  }) async {
    final request = GetPronunciationFeedbackRequest(
      sentenceId: sentenceId,
      audioFileUrl: audioFileUrl,
    );
    final response = await FeedbackRepository.getPronunciationFeedback(request);

    return response.pronunciationFeedback;
  }

  static Future<CommunicationFeedbackDTO> getCommunicationFeedback({
    required String sceneId,
    required String audioFileUrl,
  }) async {
    final request = GetCommunicationFeedbackRequest(
      sceneId: sceneId,
      audioFileUrl: audioFileUrl,
    );
    final response = await FeedbackRepository.getCommunicationFeedback(request);

    return response.communicationFeedback;
  }
}
