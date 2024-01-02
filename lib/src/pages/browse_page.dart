import 'package:flutter/material.dart';

import 'package:magpie/src/providers/mangapill.dart';
import 'package:magpie/src/providers/provider.dart';
import 'package:magpie/src/widgets/provider_widget.dart';

class BrowsePage extends StatefulWidget {
  const BrowsePage({super.key});

  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  List<Provider> providers = [Mangapill()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.search),
        title: const Text(
          "Browse",
        ),
        backgroundColor: Colors.blueGrey,
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: providers.map((e) {
            return ProviderWidget(e);
          }).toList(),
        ),
      ),
    );
  }
}
