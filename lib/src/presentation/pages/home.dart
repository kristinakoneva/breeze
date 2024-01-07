import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("data"),
        leading: const Icon(Icons.search),
      ),
      body: const Column(
        children: [
          Text("data"),

          ElevatedButton(onPressed: null, child: Text("data")),
          OutlinedButton(onPressed: null, child: Text("data")),
          TextButton(onPressed: null, child: Text("data",)),
        ],
      ),
    );
  }
}
