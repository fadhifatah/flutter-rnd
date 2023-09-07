import '../../../../model/pexels/photo.dart';

class PhotoResponse {
  int totalResults;
  int page;
  int perPage;
  List<Photo> photos;
  String? nextPage;

  PhotoResponse({
    required this.totalResults,
    required this.page,
    required this.perPage,
    required this.photos,
    required this.nextPage,
  });

  factory PhotoResponse.fromJson(Map<String, dynamic> json) => PhotoResponse(
        totalResults: json['total_results'],
        page: json['page'],
        perPage: json['per_page'],
        photos: List<Photo>.from(json['photos'].map((x) => Photo.fromJson(x))),
        nextPage: json['next_page'],
      );

  Map<String, dynamic> toJson() => {
        'total_results': totalResults,
        'page': page,
        'per_page': perPage,
        'photos': List<dynamic>.from(photos.map((x) => x.toJson())),
        'next_page': nextPage,
      };
}
