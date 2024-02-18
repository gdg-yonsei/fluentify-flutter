import 'package:fluentify/interfaces/scene.pb.dart';
import 'package:fluentify/interfaces/sentence.pb.dart';
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

final List<SentenceDTO> sampleSentences = [
  SentenceDTO(
    id: 'sentence-house-1',
    text: 'Sample sentence 1 in House',
  ),
  SentenceDTO(
    id: 'sentence-house-2',
    text: 'Sample sentence 2 in House',
  ),
  SentenceDTO(
    id: 'sentence-house-3',
    text: 'Sample sentence 3 in House',
  ),
  SentenceDTO(
    id: 'sentence-hospital-1',
    text: 'Sample sentence 1 in Hospital',
  ),
  SentenceDTO(
    id: 'sentence-hospital-2',
    text: 'Sample sentence 2 in Hospital',
  ),
  SentenceDTO(
    id: 'sentence-hospital-3',
    text: 'Sample sentence 3 in Hospital',
  ),
  SentenceDTO(
    id: 'sentence-school-1',
    text: 'Sample sentence 1 in School',
  ),
  SentenceDTO(
    id: 'sentence-school-2',
    text: 'Sample sentence 2 in School',
  ),
  SentenceDTO(
    id: 'sentence-school-3',
    text: 'Sample sentence 3 in School',
  ),
];

final List<SceneDTO> sampleScenes = [
  SceneDTO(
    id: 'scene-house-1',
    imageUrl:
        'https://i.natgeofe.com/n/2a832501-483e-422f-985c-0e93757b7d84/6_3x2.jpg',
    question: 'Sample question 1 in House',
  ),
  SceneDTO(
    id: 'scene-house-2',
    imageUrl:
        'https://i.natgeofe.com/n/2a832501-483e-422f-985c-0e93757b7d84/6_3x2.jpg',
    question: 'Sample question 2 in House',
  ),
  SceneDTO(
    id: 'scene-house-3',
    imageUrl:
        'https://i.natgeofe.com/n/2a832501-483e-422f-985c-0e93757b7d84/6_3x2.jpg',
    question: 'Sample question 3 in House',
  ),
  SceneDTO(
    id: 'scene-hospital-1',
    imageUrl:
        'https://i.natgeofe.com/n/2a832501-483e-422f-985c-0e93757b7d84/6_3x2.jpg',
    question: 'Sample question 1 in Hospital',
  ),
  SceneDTO(
    id: 'scene-hospital-2',
    imageUrl:
        'https://i.natgeofe.com/n/2a832501-483e-422f-985c-0e93757b7d84/6_3x2.jpg',
    question: 'Sample question 2 in Hospital',
  ),
  SceneDTO(
    id: 'scene-hospital-3',
    imageUrl:
        'https://i.natgeofe.com/n/2a832501-483e-422f-985c-0e93757b7d84/6_3x2.jpg',
    question: 'Sample question 3 in Hospital',
  ),
  SceneDTO(
    id: 'scene-school-1',
    imageUrl:
        'https://i.natgeofe.com/n/2a832501-483e-422f-985c-0e93757b7d84/6_3x2.jpg',
    question: 'Sample question 1 in School',
  ),
  SceneDTO(
    id: 'scene-school-2',
    imageUrl:
        'https://i.natgeofe.com/n/2a832501-483e-422f-985c-0e93757b7d84/6_3x2.jpg',
    question: 'Sample question 2 in School',
  ),
  SceneDTO(
    id: 'scene-school-3',
    imageUrl:
        'https://i.natgeofe.com/n/2a832501-483e-422f-985c-0e93757b7d84/6_3x2.jpg',
    question: 'Sample question 3 in School',
  ),
];
