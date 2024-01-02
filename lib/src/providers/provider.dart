import 'package:html/dom.dart';
import 'package:magpie/src/providers/models/manga.dart';

import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

abstract class Provider {
  String get name;
  String get baseUrl;
  String get logoUrl;
  Map<String, String> get requiredHeaders;

  Future<List<SearchResult>> popular();
  Future<List<SearchResult>> search(String query);
  Future<Manga> getMangaDetails(SearchResult searchResult);
  Future<List<Page>> getPages(Chapter chapter);

  Future<http.Response> getResponse(String url) async {
    return await http.Client().get(Uri.parse(url), headers: requiredHeaders);
  }

  Document parseResponse(String body) => parser.parse(body);
  Future<Document?> getDocumentOrNull(String url) async {
    var response = await getResponse(url);
    if (response.statusCode != 200) return null;
    return parseResponse(response.body);
  }
}
