import 'package:fluentify/interfaces/scene.dart';
import 'package:fluentify/interfaces/sentence.dart';
import 'package:fluentify/interfaces/topic.dart';

final sampleTopics = [
  Topic(id: 1, title: 'Bus Stop', sentenceIds: [1, 2, 3], sceneIds: [1, 2, 3]),
  Topic(id: 2, title: 'Hospital', sentenceIds: [1, 2, 3], sceneIds: [1, 2, 3]),
  Topic(id: 3, title: 'School', sentenceIds: [1, 2, 3], sceneIds: [1, 2, 3]),
];

final sampleScenes = [
  Scene(
    id: 1,
    imageUrl:
        'https://i.natgeofe.com/n/2a832501-483e-422f-985c-0e93757b7d84/6_3x2.jpg',
    question: 'Sample question 1',
  ),
  Scene(
    id: 2,
    imageUrl:
        'https://i.natgeofe.com/n/2a832501-483e-422f-985c-0e93757b7d84/6_3x2.jpg',
    question: 'Sample question 2',
  ),
  Scene(
    id: 3,
    imageUrl:
        'https://i.natgeofe.com/n/2a832501-483e-422f-985c-0e93757b7d84/6_3x2.jpg',
    question: 'Sample question 3',
  ),
];

final sampleSentences = [
  Sentence(
    id: 1,
    text: 'Sample sentence 1',
  ),
  Sentence(
    id: 2,
    text: 'Sample sentence 2',
  ),
  Sentence(
    id: 3,
    text: 'Sample sentence 2',
  ),
];
