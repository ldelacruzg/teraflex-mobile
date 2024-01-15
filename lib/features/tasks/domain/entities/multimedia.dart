enum MultimediaType { online, mp4 }

class Multimedia {
  final int id;
  final String title;
  final String description;
  final String url;
  final bool status;
  final MultimediaType type;
  final String uploadedBy;

  Multimedia({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.status,
    required this.type,
    required this.uploadedBy,
  });
}
