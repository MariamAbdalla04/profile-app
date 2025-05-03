import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:myapp/first_screen.dart';
import 'package:myapp/home/home_widget/home_widget.dart';
import 'package:myapp/profile%20/profile_page/profile_page.dart';

class MyHomePage extends StatelessWidget {
  final String? title;
  final String? body;
  final List<Uint8List>? image;

  const MyHomePage({this.image, this.title, this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
            icon: const Icon(Icons.account_box),
          ),
        ],
        centerTitle: true,
        title: Text("The ${title ?? "tree"}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/tree2.jpeg",
              height: 200,
              width: 400,
              fit: BoxFit.cover,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const FavoriteWidget(),
                IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                body ??
                     "A tree is a perennial plant with an elongated stem, or trunk, usually supporting branches and leaves. In some usages, the definition of a tree may be narrower, including only woody plants with secondary growth, plants that are usable as lumber or plants above a specified height.",
                textAlign: TextAlign.justify,
              ),
            ),
            Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: const [
    MyFruit(url: "assets/red-apple-tree-isolated-d-illustration-130217784.webp", text: "Apple"),
    MyFruit(url: "assets/R (5).jpg", text: "Fall"),
  ],
),
            if (image != null && image!.isNotEmpty)
              SizedBox(
                height: 500,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: image!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 150,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.memory(image![index]),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Firstscreen()),
          );
        },
        child: const Icon(Icons.next_plan),
      ),
    );
  }
}
