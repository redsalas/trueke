import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:trueke/models/post.dart';

class DatabaseService {

  // uid string reference
  final String uid;

  DatabaseService({ this.uid });

  final firestore = FirebaseFirestore.instance;

  // get user info
  Future getUser() async {
    await firestore.collection("users").doc(this.uid).get().then((doc) => print(doc.data()));
  }

  Future<List<Post>> getAllPost() async {
    List<Post> posts = [];
    await firestore.collection("posts").get().then((snapshot) {
      snapshot.docs.forEach((element) async {
        await firestore.collection("posts").doc(element.id).collection("userPosts").get().then((value) {
          value.docs.forEach((element) async {
            final storage = FirebaseStorage.instance;
            String url = await storage.ref().child("posts/${element.id}/icon.webp").getDownloadURL();
            Post p = Post(
              title: element.data()["title"],
              description: element.data()["description"],
              category: element.data()["category"],
              owner: element.id,
              url: url
            );
            posts.add(p);
          });
        });
      });
    });
    return posts;
  }

}