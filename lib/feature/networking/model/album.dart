class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
    };
  }
}

class ListAlbum {
  final List<Album> dataList;

  const ListAlbum({required this.dataList});

  factory ListAlbum.fromJson(List<dynamic> json) {
    return ListAlbum(
        dataList: json.map((data) => Album.fromJson(data)).toList());
  }

  List<Album> toJson() => dataList;
}
