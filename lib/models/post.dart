class Post {
  final int id;
  final String title;
  final String description;
  final String condition;
  final String category;
  final String status;
  final String owner;
  final DateTime createdAt;

  Post({
    this.id,
    this.title,
    this.description,
    this.condition,
    this.category,
    this.owner,
    this.status,
    this.createdAt
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      condition: json['product_condition'],
      category: json['category'],
      status: json['status'],
      owner: json['user_id'].toString() ?? '',
      createdAt: DateTime.parse(json['created_at'].toString())
    );
  }
}