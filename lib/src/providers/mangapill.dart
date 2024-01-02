import 'package:magpie/src/providers/provider.dart';
import 'package:magpie/src/providers/models/manga.dart';

class Mangapill extends Provider {
  @override
  String get name => "Mangapill";

  @override
  String get baseUrl => "https://mangapill.com";

  @override
  String get logoUrl =>
      "https://res.cloudinary.com/crxssed/image/upload/v1704127833/magpie/mangapill.png";

  @override
  Map<String, String> get requiredHeaders => {"Referer": baseUrl};

  @override
  Future<List<SearchResult>> popular() async {
    List<SearchResult> manga = [];

    var document = await getDocumentOrNull(baseUrl);
    if (document == null) return manga;

    var resultsContainer =
        document.getElementsByClassName("grid grid-cols-2").firstOrNull;
    if (resultsContainer == null) return manga;

    var results = resultsContainer
        .getElementsByTagName("div")
        .where((element) => element.className == "");
    for (var result in results) {
      var name = result
          .getElementsByClassName("line-clamp-2 text-sm font-bold")
          .first
          .innerHtml;
      var image =
          result.getElementsByTagName("img").first.attributes["data-src"];
      var path = result.getElementsByTagName("a").first.attributes["href"];
      var url = "$baseUrl$path";

      manga.add(SearchResult(name, this.name, image!, url));
    }

    return manga;
  }

  @override
  Future<List<SearchResult>> search(String query) async {
    List<SearchResult> manga = [];

    var document = await getDocumentOrNull(_searchUrl(query));
    if (document == null) return manga;

    var resultsContainer = document
        .getElementsByClassName("my-3 grid justify-end gap-3 grid-cols-2")
        .firstOrNull;
    if (resultsContainer == null) return [];

    var results = resultsContainer
        .getElementsByTagName("div")
        .where((element) => element.className == "");
    for (var result in results) {
      var name = result
          .getElementsByClassName("mt-3 font-black leading-tight line-clamp-2")
          .first
          .innerHtml;
      var image =
          result.getElementsByTagName("img").first.attributes["data-src"];
      var path = result.getElementsByTagName("a").first.attributes["href"];
      var url = "$baseUrl$path";

      manga.add(SearchResult(name, this.name, image!, url));
    }

    return manga;
  }

  @override
  Future<Manga> getMangaDetails(SearchResult searchResult) async {
    var manga = Manga(searchResult.name, searchResult.sourceName,
        searchResult.image, searchResult.url);

    var document = await getDocumentOrNull(searchResult.url);
    if (document == null) return manga;

    var detailsDiv =
        document.getElementsByClassName("grid grid-cols-1 gap-3 mb-3").last;
    var releaseYear = detailsDiv.children.last.children.lastOrNull?.innerHtml;

    var description = document
        .getElementsByClassName("text-sm text--secondary")
        .firstOrNull
        ?.innerHtml;

    manga.description = description;
    manga.releaseYear = releaseYear == null ? null : int.parse(releaseYear);

    var chaptersDiv =
        document.getElementsByClassName("my-3 grid grid-cols-1").firstOrNull;
    if (chaptersDiv == null) return manga;

    var results = chaptersDiv.getElementsByTagName("a").reversed;
    for (var result in results) {
      var name = result.innerHtml;
      var path = result.attributes["href"];
      var url = "$baseUrl$path";

      manga.chapters.add(Chapter(name, url));
    }

    return manga;
  }

  @override
  Future<List<Page>> getPages(Chapter chapter) async {
    List<Page> pages = [];

    var document = await getDocumentOrNull(chapter.url);
    if (document == null) return pages;

    var results = document.getElementsByClassName("js-page");
    for (var result in results) {
      var url = result.attributes["data-src"];

      pages.add(Page(url!, headers: requiredHeaders));
    }

    return pages;
  }

  String _searchUrl(String query) {
    return "$baseUrl/search?q=$query";
  }
}
