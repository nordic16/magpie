import 'package:flutter/material.dart';
import 'package:magpie/src/providers/models/manga.dart';
import 'package:magpie/src/providers/provider.dart';

class MangaDetailsPage extends StatelessWidget {
  final SearchResult searchResult;
  final Provider provider;

  const MangaDetailsPage(this.searchResult, this.provider, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(searchResult.name)),
        body: FutureBuilder<Manga>(
            future: provider.getMangaDetails(searchResult),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      searchResult.image,
                      headers: provider.requiredHeaders,
                      height: 500,
                    ),

                    Text(
                      searchResult.name,
                      style: const TextStyle(
                          fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                    Flexible(child: Text(snapshot.data!.description!)),
// TODO
                    const ElevatedButton(onPressed: null, child: Text("Read"))
                  ],
                );
              } else {
                return const CircularProgressIndicator(color: Colors.amber);
              }
            }));
  }
}
