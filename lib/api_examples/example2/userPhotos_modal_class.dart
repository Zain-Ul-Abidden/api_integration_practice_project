class UserPhotosModal {
  final int id;
  final int albumId;
  final String title;
  final String url;
  UserPhotosModal(
      {required this.id,
      required this.albumId,
      required this.title,
      required this.url});
  factory UserPhotosModal.fromJson(Map<String, dynamic> json) {
    return UserPhotosModal(
        id: json['id'],
        albumId: json['albumId'],
        title: json['title'],
        url: json['url']);
  }
  Map<String, dynamic> toMap() {
    return {'id': id, 'albumId': albumId, 'title ': title, 'url': url};
  }
}
