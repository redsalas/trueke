import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String title;
  final String description;
  final String category;
  final String owner;
  final String url;
  final Timestamp created_at;

  Post({
    this.title,
    this.description,
    this.category,
    this.owner,
    this.url,
    this.created_at
  });
}