class Topic {
  final int id;
  final String title;
  final List<int> sentenceIds;
  final List<int> sceneIds;

  Topic({
    required this.id,
    required this.title,
    required this.sentenceIds,
    required this.sceneIds,
  });
}
