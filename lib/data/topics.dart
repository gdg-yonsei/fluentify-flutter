import 'package:fluentify/interfaces/topic.pb.dart';

final List<TopicDTO> sampleTopics = [
  TopicDTO(
    id: 'topic-house',
    title: 'House',
    sentenceIds: [
      'sentence-house-1',
      'sentence-house-2',
      'sentence-house-3',
    ],
    sceneIds: [
      'scene-house-1',
      'scene-house-2',
      'scene-house-3',
    ],
  ),
  TopicDTO(
    id: 'topic-hospital',
    title: 'Hospital',
    sentenceIds: [
      'sentence-hospital-1',
      'sentence-hospital-2',
      'sentence-hospital-3'
    ],
    sceneIds: [
      'scene-hospital-1',
      'scene-hospital-2',
      'scene-hospital-3',
    ],
  ),
  TopicDTO(
    id: 'topic-school',
    title: 'School',
    sentenceIds: [
      'sentence-school-1',
      'sentence-school-2',
      'sentence-school-3'
    ],
    sceneIds: [
      'scene-school-1',
      'scene-school-2',
      'scene-school-3',
    ],
  ),
];

final List<CompactTopicDTO> sampleCompactTopics = [
  CompactTopicDTO(
    id: 'topic-house',
    title: 'House',
  ),
  CompactTopicDTO(
    id: 'topic-hospital',
    title: 'Hospital',
  ),
  CompactTopicDTO(
    id: 'topic-school',
    title: 'School',
  ),
];
