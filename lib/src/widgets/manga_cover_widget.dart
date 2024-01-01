import 'package:flutter/material.dart';

import 'package:magpie/src/providers/models/manga.dart';
import 'package:magpie/src/providers/provider.dart';

class MangaCoverWidget extends StatelessWidget {
  final Manga manga;
  final Provider provider;

  const MangaCoverWidget(this.manga, this.provider, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        print("TODO: OPEN THE MANGA DETAIL PAGE...");
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              manga.image,
              fit: BoxFit.cover,
              headers: provider.requiredHeaders,
            ),
          ),
          Container(
            height: 200,
            width: double.infinity,
            margin: const EdgeInsets.all(3.5),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(0, 0, 0, 0),
                  Color.fromARGB(175, 0, 0, 0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, 1],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: AlignmentDirectional.bottomStart,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                manga.name,
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}
