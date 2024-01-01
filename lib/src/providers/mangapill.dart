import 'package:magpie/src/providers/provider.dart';
import 'package:magpie/src/providers/models/manga.dart';

class Mangapill extends Provider {
  @override
  String get name => "Mangapill";

  @override
  String get baseUrl => "https://mangapill.com";

  @override
  String get logoUrl => "https://res.cloudinary.com/crxssed/image/upload/v1704127833/magpie/mangapill.png";

  @override
  Map<String, String> get requiredHeaders => {"Referer": baseUrl};

  @override
  Future<List<Manga>> popular() async {
    List<Manga> manga = [];

    var response = await getResponse(baseUrl);
    if (response.statusCode == 200) {
      var document = parseResponse(response.body);
      var resultsContainer = document.getElementsByClassName("grid grid-cols-2").firstOrNull;
      if (resultsContainer == null) return [];

      var results = resultsContainer.getElementsByTagName("div").where((element) => element.className == "");
      for (var result in results) {
        var name = result.getElementsByClassName("line-clamp-2 text-sm font-bold").first.innerHtml;
        var image = result.getElementsByTagName("img").first.attributes["data-src"];
        var path = result.getElementsByTagName("a").first.attributes["href"];
        var url = "$baseUrl$path";

        manga.add(Manga(name, this.name, image!, url));
      }
    }

    return manga;
  }

  @override
  Future<List<Manga>> search(String query) async {
    List<Manga> manga = [];

    var response = await getResponse(_searchUrl(query));
    if (response.statusCode == 200) {
      var document = parseResponse(response.body);
      var resultsContainer = document.getElementsByClassName("my-3 grid justify-end gap-3 grid-cols-2").firstOrNull;
      if (resultsContainer == null) return [];

      var results = resultsContainer.getElementsByTagName("div").where((element) => element.className == "");
      for (var result in results) {
        var name = result.getElementsByClassName("mt-3 font-black leading-tight line-clamp-2").first.innerHtml;
        var image = result.getElementsByTagName("img").first.attributes["data-src"];
        var path = result.getElementsByTagName("a").first.attributes["href"];
        var url = "$baseUrl$path";

        manga.add(Manga(name, this.name, image!, url));
      }
    }

    return manga;
  }

  @override
  Future<List<Chapter>> getChapters(Manga manga) async {
    List<Chapter> chapters = [];

    var response = await getResponse(manga.url);
    if (response.statusCode == 200) {
      var document = parseResponse(response.body);
      var chaptersDiv = document.getElementsByClassName("my-3 grid grid-cols-1").firstOrNull;
      if (chaptersDiv == null) return [];

      var results = chaptersDiv.getElementsByTagName("a").reversed;
      for (var result in results) {
        var name = result.innerHtml;
        var path = result.attributes["href"];
        var url = "$baseUrl$path";

        chapters.add(Chapter(name, url));
      }
    }

    return chapters;
  }

  @override
  Future<List<Page>> getPages(Chapter chapter) async {
    List<Page> pages = [];

    var response = await getResponse(chapter.url);
    if (response.statusCode == 200) {
      var document = parseResponse(response.body);

      var results = document.getElementsByClassName("js-page");
      for (var result in results) {
        var url = result.attributes["data-src"];

        pages.add(Page(url!, headers: requiredHeaders));
      }
    }

    return pages;
  }

  String _searchUrl(String query) {
    return "$baseUrl/search?q=$query";
  }
}
