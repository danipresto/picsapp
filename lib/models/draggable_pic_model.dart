class DraggablePicModel {
  final String id;
  final String title;
  final String path;

  const DraggablePicModel({
    required this.id,
    required this.title,
    required this.path,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'path': path,
    };
  }

  factory DraggablePicModel.fromJson(Map<String, dynamic> json) {
    return DraggablePicModel(
      id: json['id'],
      title: json['title'],
      path: json['path'],
    );
  }
}
