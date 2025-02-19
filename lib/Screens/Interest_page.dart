import 'package:flutter/material.dart';


class InterestPage extends StatelessWidget {
  const InterestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your Interest '),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Welcome to the Page! :) ',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
