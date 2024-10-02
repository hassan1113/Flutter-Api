import 'dart:convert';
import 'package:api/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home_API extends StatefulWidget {
  const Home_API({super.key});

  @override
  State<Home_API> createState() => _Home_APIState();
}

class _Home_APIState extends State<Home_API> {
  Future<List<PostModel>> getUserPostsapi() async {
    var url = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      List<PostModel> posts = [];

      for (var eachPost in responseBody) {
        posts.add(PostModel.fromJson(eachPost));
      }

      print(posts); // Debugging ke liye
      return posts;
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API'),
        elevation: 0,
        backgroundColor: Colors.blueGrey,
      ),
      body: FutureBuilder(
        future: getUserPostsapi(),
        builder: (context, AsyncSnapshot<List<PostModel>> snapshot) {
          print(snapshot.connectionState); // Debugging ke liye

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var post = snapshot.data![index];
                return Card(
                  child: ListTile(
                    title: Text(post.title ?? 'No Title'),
                    subtitle: Text(post.body ?? 'No Content'),
                    leading: Text(post.id.toString()),
                  ),
                );
              },
            );
          }
          return const Center(
            child: Text('No posts available'),
          );
        },
      ),
    );
  }
}
