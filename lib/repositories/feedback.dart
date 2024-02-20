import 'package:fluentify/interfaces/feedback.pb.dart';

class FeedbackRepository {
  // TODO: API 연동
  static Future<GetPronunciationFeedbackResponse> getPronunciationFeedback(
    GetPronunciationFeedbackRequest request,
  ) async {
    await Future.delayed(const Duration(seconds: 5));

    return GetPronunciationFeedbackResponse(
      pronunciationFeedback: PronunciationFeedbackDTO(
        sentenceId: request.sentenceId,
        incorrectIndexes: [1, 3, 4, 10],
        pronunciationScore: 4,
        volumeScore: 3,
        speedScore: 2,
        overallFeedback: 'Good!',
      ),
    );
  }

  // TODO: API 연동
  static Future<GetCommunicationFeedbackResponse> getCommunicationFeedback(
    GetCommunicationFeedbackRequest request,
  ) async {
    await Future.delayed(const Duration(seconds: 5));

    return GetCommunicationFeedbackResponse(
      communicationFeedback: CommunicationFeedbackDTO(
        sceneId: request.sceneId,
        overallFeedback: 'Great!',
      ),
    );
  }
}
