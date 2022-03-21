import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(String filePath, String fileName) async {
    File file = File(filePath);

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('uploads/$fileName')
          .putFile(file);
    } on firebase_core.FirebaseException catch (e) {}
  }

  Future<int> fetchNumberOfPosts() async {
    final listRef = firebase_storage.FirebaseStorage.instance.ref('text/');
    final allResults = await listRef.listAll();
    return allResults.items.length;
  }
}

Future<QuerySnapshot<Map<String, dynamic>>> getData() {
  FirebaseFirestore fb = FirebaseFirestore.instance;
  return fb.collection("uploads").get();
}

class PostPage extends StatefulWidget {
  const PostPage({Key key}) : super(key: key);

  @override
  State<PostPage> createState() => PostPageState();
}

class PostPageState extends State<PostPage> {
  Storage storage = Storage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View the Posts', textAlign: TextAlign.center),
      ),
      body: Container(
        child: FutureBuilder(
          future: getData(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: (snapshot.data.docs.length / 4).floor(),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      contentPadding: EdgeInsets.all(8.0),
                      title: Text(snapshot.data.docs[index].data()[""]),
                      leading: Image.network(
                          snapshot.data.docs[index].data()["url"],
                          fit: BoxFit.fill),
                    );
                  });
            } else if (snapshot.connectionState == ConnectionState.none) {
              return Text("No data");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
