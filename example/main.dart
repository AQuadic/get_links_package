import 'package:get_links/get_links.dart';

void main() async {
  final _parsed = AQFetcher.parseStreamLink(link: "https://drive.google.com/get_video_info?id=1Xei5Mw4uPArruFuhg7ouVxq6w4KMylAC");
  print(_parsed.toMap());
  final _links = await AQFetcher.getStreamLink(link: _parsed);

  _links.forEach((element) {
    print(element.toMap());
  });
}
