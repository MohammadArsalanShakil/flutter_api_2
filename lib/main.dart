import 'package:flutter/material.dart';
import '/models/blogpost.dart';

import 'controllers/blogpost_api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        primaryColor: Colors.blueGrey,
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("API"),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: [
                FutureBuilder<BlogPost>(
                  future: fetchBlogPost(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data!.title!,
                        style: TextStyle(
                          fontSize: 24.0,
                        ),
                      );
                    } else
                      return const CircularProgressIndicator();
                  },
                ),
                SizedBox(
                  height: 35.0,
                ),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: "Title"),
                ),
                TextField(
                  controller: _bodyController,
                  decoration: InputDecoration(labelText: "Body"),
                ),
                SizedBox(
                  height: 25.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_titleController.text.isNotEmpty &&
                        _bodyController.text.isNotEmpty) {
                      addBlogPost(_titleController.text, _bodyController.text);
                    }
                  },
                  child: Text("Send Data"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
