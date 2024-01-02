import 'package:flutter/material.dart';

import 'package:magpie/src/providers/models/manga.dart';
import 'package:magpie/src/providers/provider.dart';
import 'package:magpie/src/widgets/manga_cover_widget.dart';

class ProviderActivity extends StatefulWidget {
  final Provider provider;

  const ProviderActivity(this.provider, {super.key});

  @override
  State<ProviderActivity> createState() => _ProviderActivityState();
}

class _ProviderActivityState extends State<ProviderActivity> {
  Icon customIcon = const Icon(Icons.search);
  Widget? customSearchBar;
  Widget? mangaResults;

  @override
  void initState() {
    super.initState();
    customSearchBar = Text(widget.provider.name);
    loadResults(widget.provider.popular());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: toggleSearch,
            icon: customIcon
          )
        ],
        title: customSearchBar,
      ),
      body: mangaResults,
    );
  }

  void toggleSearch() {
    setState(() {
      if (customIcon.icon == Icons.search) {
        customIcon = const Icon(Icons.clear);
        customSearchBar = buildSearchBar();
      } else {
        customIcon = const Icon(Icons.search);
        customSearchBar = Text(widget.provider.name);
      }
    });
  }

  Widget buildSearchBar() {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: TextField(
          autofocus: true,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: 'Search ${widget.provider.name}...',
            border: InputBorder.none,
            fillColor: Colors.red,
          ),
          onSubmitted: search,
        ),
      ),
    );
  }

  void search(String query) {
    loadResults(widget.provider.search(query));
  }

  void loadResults(Future<List<SearchResult>> future) {
    setState(() {
      mangaResults = FutureBuilder<List<SearchResult>>(
        future: future,
        builder:(context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 0.65,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemBuilder: (_, index) => MangaCoverWidget(snapshot.data![index], widget.provider),
              itemCount: snapshot.data!.length,
            );
          } else {
            return const Center(child: CircularProgressIndicator(color: Colors.blueGrey,));
          }
        },
      );
    });
  }
}
