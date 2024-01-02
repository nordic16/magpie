class SearchResult {
  String name;
  String sourceName;
  String image;
  String url;

  SearchResult(this.name, this.sourceName, this.image, this.url);

  @override
  String toString() {
    return name;
  }
}

class Manga {
  String name;
  String sourceName;
  String image;
  String url;
  List<Chapter> chapters = [];
  String? description;
  int? releaseYear;
  int? anilistId; // To be used in Anilist integration

  Manga(this.name, this.sourceName, this.image, this.url,
      {this.description, this.releaseYear});

  @override
  String toString() {
    return name;
  }
}

class Chapter {
  String name;
  String url;

  Chapter(this.name, this.url);

  @override
  String toString() {
    return name;
  }
}

class Page {
  String url;
  Map<String, String>? headers;

  Page(this.url, {this.headers});

  @override
  String toString() {
    return url;
  }
}
