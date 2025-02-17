import 'dart:convert';
import 'dart:developer';
import 'package:flutter_bloc_with_api/features/posts/models/post_data_ui_model.dart';
import 'package:http/http.dart' as http;

class PostsRepo {
  static Future<List<PostDataUiModel>> fetchPosts() async {
    List<PostDataUiModel> posts = [];

    var client = http.Client();

    try {
      var response = await client.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      );

      List result = jsonDecode(response.body);
      for (int i = 0; i < result.length; i++) {
        PostDataUiModel post = PostDataUiModel.fromJson(result[i]);
        posts.add(post);
      }
      return posts;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  static Future<bool> addPost() async {
    var client = http.Client();

    try {
      var response = await client
          .post(Uri.parse('https://jsonplaceholder.typicode.com/posts'), body: {
        "title": "Richard",
        "body": "Backend Developer",
        "userId": "23"
      });
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
