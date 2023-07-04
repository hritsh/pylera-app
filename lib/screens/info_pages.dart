import 'package:flutter/material.dart';

class HPyloriInfo extends StatelessWidget {
  const HPyloriInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('H. Pylori Info'), backgroundColor: Colors.blue),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('H. Pylori Info', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}

class PyleraInfo extends StatelessWidget {
  const PyleraInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Pylera Info'), backgroundColor: Colors.teal),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Pylera Info', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
