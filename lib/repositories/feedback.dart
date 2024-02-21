import 'package:fluentify/interfaces/feedback.pb.dart';
import 'package:fluentify/utils/api.dart';

class FeedbackRepository {
  static Future<GetPronunciationFeedbackResponse> getPronunciationFeedback(
    GetPronunciationFeedbackRequest request,
  ) async {
    final client = await API.getAuthenticatedClient();

    final response = await client.post(
      '/GetPronunciationFeedback',
      // data: request.toProto3Json(),
      data: {
        'sentence_id': request.sentenceId,
        'audio_file_url': request.audioFileUrl,
      },
    );

    return GetPronunciationFeedbackResponse.create()
      ..mergeFromProto3Json(response.data);
  }

  static Future<GetCommunicationFeedbackResponse> getCommunicationFeedback(
    GetCommunicationFeedbackRequest request,
  ) async {
    final client = await API.getAuthenticatedClient();

    final response = await client.post(
      '/GetCommunicationFeedback',
      // data: request.toProto3Json(),
      data: {
        'scene_id': request.sceneId,
        'audio_file_url': request.audioFileUrl,
      },
    );

    return GetCommunicationFeedbackResponse.create()
      ..mergeFromProto3Json(response.data);
  }
}
