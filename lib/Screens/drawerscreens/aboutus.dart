import 'package:about/about.dart';

import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AboutPage(
        values: {
          'version': "1.0.0",
          'buildNumber': "#1.0.0",
          'year': "2002",
          'author': "Jan Seva Point",
        },
        title: const Text('About'),
        applicationVersion: 'Version {{ version }}, build #{{ buildNumber }}',
        applicationIcon: SizedBox(
          height: 150,
          width: 150,
          child: Image.asset(
            "assets/images/jansevaabout.png",
            fit: BoxFit.contain,
          ),
        ),
        applicationLegalese: 'Copyright © {{ author }}, {{ year }}',
        children: const <Widget>[
          MarkdownPageListTile(
            filename: 'assets/file/README.md',
            title: Text('View Readme'),
            icon: Icon(Icons.all_inclusive),
          ),
          MarkdownPageListTile(
            filename: 'assets/file/CHANGELOG.md',
            title: Text('View Changelog'),
            icon: Icon(Icons.view_list),
          ),
          MarkdownPageListTile(
            filename: 'assets/file/LICENSE.md',
            title: Text('View License'),
            icon: Icon(Icons.description),
          ),
          MarkdownPageListTile(
            filename: 'assets/file/CONTRIBUTING.md',
            title: Text('Contributing'),
            icon: Icon(Icons.share),
          ),
          MarkdownPageListTile(
            filename: 'assets/file/CODE_OF_CONDUCT.md',
            title: Text('Code of conduct'),
            icon: Icon(Icons.sentiment_satisfied),
          ),
          LicensesPageListTile(
            title: Text('Open source Licenses'),
            icon: Icon(Icons.favorite),
          ),
        ],
      ),
    );
  }
}
