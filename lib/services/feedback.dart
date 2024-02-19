import 'package:fluentify/interfaces/feedback.pb.dart';
import 'package:fluentify/repositories/feedback.dart';

class FeedbackService {
  final FeedbackRepository feedbackRepository = FeedbackRepository();

  Future<PronunciationFeedbackDTO> getPronunciationFeedback({
    required String sentenceId,
    required String audioFileUrl,
  }) async {
    final request = GetPronunciationFeedbackRequest(
      sentenceId: sentenceId,
      audioFileUrl: audioFileUrl,
    );
    final response = await feedbackRepository.getPronunciationFeedback(request);

    return response.pronunciationFeeback;
  }

  Future<CommunicationFeedbackDTO> getCommunicationFeedback({
    required String sceneId,
    required String audioFileUrl,
  }) async {
    final request = GetCommunicationFeedbackRequest(
      sceneId: sceneId,
      audioFileUrl: audioFileUrl,
    );
    final response = await feedbackRepository.getCommunicationFeedback(request);

    return response.communicationFeedback;
  }
}
