import 'package:fidea_app/text/apptext.dart';
import 'package:fidea_app/views/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: PagesFidea.fidea),
      body: introductionWidget(),
    );
  }

  Padding introductionWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Image.network(UrlText.ideaUrl,
                  height: 250, fit: BoxFit.cover)),
          const SizedBox(height: 20),
          const Text(
            IntroductionText.introductionText,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            IntroductionText.introductionText2,
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            IntroductionText.introductionText3,
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            IntroductionText.introductionText4,
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            IntroductionText.introductionText5,
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            IntroductionText.introductionText6,
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
