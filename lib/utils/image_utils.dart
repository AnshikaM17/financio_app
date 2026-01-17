// lib/utils/image_utils.dart

List<String> getLessonImages({
  required String topic,
  required String level,
}) {
  final folder = topic.toLowerCase().replaceAll(' ', '_');

  return [
    'assets/images/$folder/$level.png',
  ];
}
