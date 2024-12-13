import 'package:flutter/material.dart';
import 'package:university/widgets/AppBar.dart';
import 'package:university/widgets/faqs_section.dart';

class GuidelinesPage extends StatefulWidget {
  const GuidelinesPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GuidelinesPageState createState() => _GuidelinesPageState();
}

class _GuidelinesPageState extends State<GuidelinesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
      Align(
        alignment: Alignment.topLeft,
        child: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed('homepage');
          },
        ),
      ),
      AppBarWidget(
          title: "Guidelines & FAQs",
          subtitle: "Application guide and support",
          icon:  Icons.help_outline,),
      const SizedBox(height: 20),
      const FaqsSection(),
    ]));
  }
}
