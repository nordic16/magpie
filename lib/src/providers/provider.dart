import 'package:html/dom.dart';
import 'package:magpie/src/providers/models/manga.dart';

import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

abstract class Provider {
  String get name;
  String get baseUrl;
  String get logoUrl;
  Map<String, String> get requiredHeaders;

  Future<List<Manga>> popular();
  Future<List<Manga>> search(String query);
  Future<List<Chapter>> getChapters(Manga manga);
  Future<List<Page>> getPages(Chapter chapter);

  Future<http.Response> getResponse(String url) async {
    return await http.Client().get(Uri.parse(url), headers: requiredHeaders);
  }
  Document parseResponse(String body) => parser.parse(body);
}
