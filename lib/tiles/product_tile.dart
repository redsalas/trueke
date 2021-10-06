import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:trueke/screens/item_description_screen.dart';
import 'package:trueke/models/post.dart';

class ProductTile extends StatelessWidget {
  final String photo;
  final String title;
  final String description;
  final Post post;

  const ProductTile({Key key, this.photo, this.title, this.description, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Card(
      child: ListTile(
        title: Text("${post.title}"),
        subtitle: Text("${post.description}"),
        leading: Image.network(post.url),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ItemDescriptionScreen(photo: photo, title: post.title, description:  post.description))),
        ),
      );
  }
}
