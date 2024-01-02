import 'package:flutter/material.dart';
import 'package:magpie/src/pages/manga_details_page.dart';

import 'package:magpie/src/providers/models/manga.dart';
import 'package:magpie/src/providers/provider.dart';

class MangaCoverWidget extends StatelessWidget {
  final SearchResult searchResult;
  final Provider provider;

  const MangaCoverWidget(this.searchResult, this.provider, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MangaDetailsPage(searchResult, provider)));
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
                searchResult.image,
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
                  searchResult.name,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
