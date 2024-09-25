import 'package:flutter/material.dart';
import 'package:list_tugas/sidemenu.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Aplikasi'),
      ),
      body: const Center(
        child: Text('Aplikasi untuk mencatat jadwal perkuliahan'),
      ),
      drawer: const Sidemenu(),
    );
  }
}
