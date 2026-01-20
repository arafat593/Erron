class PastStreamModel {
  final String id;
  final String title;
  final String category;
  final String thumbnail;
  final DateTime createdAt;
  final int totalViews;
  final int totalLikes;
  final String status;

  PastStreamModel({
    required this.id,
    required this.title,
    required this.category,
    required this.thumbnail,
    required this.createdAt,
    required this.totalViews,
    required this.totalLikes,
    required this.status,
  });

  factory PastStreamModel.fromJson(Map<String, dynamic> json) {
    return PastStreamModel(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      thumbnail: json['thumbnail'],
      createdAt: DateTime.parse(json['created_at']),
      totalViews: json['total_views'],
      totalLikes: json['total_likes'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'thumbnail': thumbnail,
      'created_at': createdAt.toIso8601String(),
      'total_views': totalViews,
      'total_likes': totalLikes,
      'status': status,
    };
  }
}