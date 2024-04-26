import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your place"),
        centerTitle: false,
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.add))
        ],
      ),
      body: const Center(
        child: Text(
          "No places added yet.",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
