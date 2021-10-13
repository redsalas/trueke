import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:trueke/utilities/constants.dart';
import 'package:http/http.dart' as http;

Future getPosts() async {
  final response = await http.get(Uri.parse('$serverPosts'));
  return json.decode(response.body);
}

void signOut(context) {
  settings.truekoin = '0';
  settings.userId = '';
  settings.token = '';
  settings.userName = '';
  EasyLoading.showSuccess('Cierre de sesión éxitoso');
  Navigator.of(context).pushReplacementNamed('/login');
}

Future getPost(int id) async {
  final response = await http.get(Uri.parse('https://sagarsoftware.com/api/get/post/$id'));
  return json.decode(response.body);
}

Future getPostsByCategory(String category) async {
  final response = await http.get(Uri.parse('$serverPosts/$category'));
  return json.decode(response.body);
}

Future getPostsByUser(String id) async {
  final response = await http.get(Uri.parse('$serverPosts/user/$id'));
  return json.decode(response.body);
}

Future getPostByTrueke(String id) async {
  final response = await http.get(Uri.parse('$serverHost/get/truekes/$id'));
  print(response.body);
  return json.decode(response.body);
}

Future sendTrueke(int postId, String owner, int truekeId) async {
  final response = await http.post(Uri.parse('$serverHost/send/trueke'), body: {
    "user_id": settings.userId.toString(),
    "owner_id": owner,
    "post_id": postId.toString(),
    "product_id": truekeId.toString()
  }).then((response) {
    print(response.body);
    var resp = json.decode(response.body);
    if(resp.containsKey("success")) {
      EasyLoading.dismiss();
      EasyLoading.showSuccess(resp['success']);
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError(resp['error']);
    }
  });
}

Future acceptTrueke(int postId) async {
  final response = await http.post(Uri.parse('$serverHost/accept/trueke'), body: {
    "user_id": settings.userId.toString(),
    "post_id": postId.toString()
  }).then((response) {
    print(response.body);
    var resp = json.decode(response.body);
    if(resp.containsKey("success")) {
      EasyLoading.dismiss();
      EasyLoading.showSuccess(resp['success']);
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError(resp['error']);
    }
  });
}