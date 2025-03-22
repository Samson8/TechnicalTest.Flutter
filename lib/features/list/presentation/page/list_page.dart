import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<dynamic> posts = [];

  @override
  void initState() {
    super.initState();
    // http
    //     .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/'))
    //     .then((response) {

    //   setState(() {
    //     posts = json.decode(response.body);
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("List of posts"),
      ),
      body: ListView(
        children: posts.map((post) {
          return InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushNamed('details/', arguments: {'id': post['id']});
            },
            child: Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post['title'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(post['body']),
                  Container(height: 10),
                  const Divider(
                    thickness: 1,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
