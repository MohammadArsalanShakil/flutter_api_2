import 'dart:convert';

import '/models/blogpost.dart';

import '/constants/urls.dart';
import 'package:http/http.dart' as http;

Future<BlogPost> fetchBlogPost() async {
  final response = await http.get(Uri.parse(blogpost_get_url));

  if (response.statusCode == 200) {
    BlogPost blog = BlogPost.fromJson(jsonDecode(response.body));
    return blog;
  } else {
    return BlogPost();
  }
}

Future<BlogPost?> addBlogPost(String title, String body) async {
  final response = await http.post(
    Uri.parse(blogpost_post_url),
    body: jsonEncode(
      <String, String>{
        'title': title,
        'body': body,
      },
    ),
  );

  if (response.statusCode == 201) {
    final BlogPost blog = BlogPost.fromJson(jsonDecode(response.body));
    return blog;
  } else {
    return null;
  }
}
