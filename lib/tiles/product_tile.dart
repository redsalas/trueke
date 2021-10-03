import 'package:flutter/material.dart';
import 'package:trueke/screens/item_description_screen.dart';

class ProductTile extends StatelessWidget {
  final String photo;
  final String title;
  final String description;

  const ProductTile({Key key, this.photo, this.title, this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text("$title"),
        subtitle: Text("$description"),
        leading: Image.asset("assets/images/$photo-1.webp"),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ItemDescriptionScreen(photo: photo, title: title, description:  description))),
        ),
      );
  }
}
