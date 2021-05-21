import 'dart:io';

import 'package:get_links/get_links.dart';

void main() async {
  print("Hello, Welcome to AQParser.\nEnter your Link:");
  final link = stdin.readLineSync();
  final _parsed = AQFetcher.parseStreamLink(link: link);
  print("Link Parsed to: $_parsed");
  print("Please wait, while we fetch stream links.");
  final _links = await AQFetcher.getStreamLink(link: _parsed);

  print("Stream links found!.");
  _links.forEach((element) async {
    element.size = await AQFetcher.fetchVideoSize(aqResult: element);
    print(element.toMap());
  });
}
