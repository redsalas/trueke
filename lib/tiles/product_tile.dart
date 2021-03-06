import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:trueke/screens/item_description_screen.dart';
import 'package:trueke/models/post.dart';
import 'package:trueke/services/database_service.dart';
import 'package:trueke/utilities/constants.dart';

class ProductTile extends StatelessWidget {
  final Post post;

  const ProductTile({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Card(
      child: ListTile(
        title: Text("${post.title}"),
        subtitle: Text("${post.description}"),
        leading: Image.network(
            "https://sagarsoftware.com/public/posts/${post.id}/1.jpeg",
          width: 50,
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue),
        onTap: () async {
          Navigator.pushNamed(context, '/item_description', arguments: await getProduct());
        },
      ),
    );
  }

  Future getProduct() async {
    EasyLoading.show(status: 'Cargando producto. . .');
    var json = await getPost(post.id);
    EasyLoading.dismiss();
    return json;
  }
}
