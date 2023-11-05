import 'package:flutter/material.dart';
import 'package:sikucing/theme/color.dart';
import '../env/env.dart';
import '../models/m_openai.dart';
import '../services/openai_service.dart';

class AboutCatsPage extends StatefulWidget {
  const AboutCatsPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AboutCatsPageState createState() => _AboutCatsPageState();
}

class _AboutCatsPageState extends State<AboutCatsPage> {
  final catController = TextEditingController();
  final aboutCatService = AboutCatService(Env.apiKey);
  List<AboutCatModel> aboutCats = [];

  Future<void> getAboutCats() async {
    final cat = catController.text;

    try {
      final recs = await aboutCatService.getAboutCats(
        cat: cat,
      );

      setState(() {
        aboutCats = recs;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fun Fact About Cat with AI',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: AppColor.appBarColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            InputField(
                controller: catController,
                label: 'What are you looking for about cats?'),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.actionColor,
              ),
              onPressed: getAboutCats,
              child: const Text('Submit'),
            ),
            const SizedBox(height: 16),
            for (final aboutcat in aboutCats) AboutCatCard(aboutcat: aboutcat),
          ],
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const InputField({
    Key? key,
    required this.controller,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

class AboutCatCard extends StatelessWidget {
  final AboutCatModel aboutcat;

  const AboutCatCard({
    Key? key,
    required this.aboutcat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: Border.all(),
      color: AppColor.appBgColor,
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('=====> RESULT <====='),
            const SizedBox(height: 8),
            Text(aboutcat.description),
          ],
        ),
      ),
    );
  }
}
