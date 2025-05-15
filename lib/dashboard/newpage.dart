import 'package:flutter/material.dart';

class Newpage extends StatelessWidget {
  const Newpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Us',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'hgfdsasrtyjhgfdertyuknbvdrtyuikmnbvfrtyuiolkmnbvdrtyjnbvcfdcvbjhtredcvbjgdcv.',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

     
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/about.jpg', 
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Icon(Icons.favorite, size: 30, color: Colors.red),
                  Icon(Icons.star, size: 30, color: Colors.amber),
                  Icon(Icons.share, size: 30, color: Colors.blue),
                  Icon(Icons.phone, size: 30, color: Colors.green),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
