import 'package:get_links/enum/video_website.dart';

class AQHTMLParser {
  List<String> parseHTML(AQVideoWebsite type, String html) {
    switch (type) {
      case AQVideoWebsite.MEDIAFIRE:
        final _links = _defaultLinkParser(html);
        return _mediaFireFilter(_links);
      case AQVideoWebsite.OK_RU:
      case AQVideoWebsite.MYSTREAM_TO:
      case AQVideoWebsite.UP_TO_STREAM:
      case AQVideoWebsite.UP_TO_BOX:
      case AQVideoWebsite.MEGA_NZ:
      case AQVideoWebsite.SOLIDFILES:
      case AQVideoWebsite.FEMBED:
      case AQVideoWebsite.FEURL:
      case AQVideoWebsite.GOOGLE_DRIVE:
      case AQVideoWebsite.VIDLOX:
      case AQVideoWebsite.TUNE:
      case AQVideoWebsite.MIXDROP:
      case AQVideoWebsite.JAWCLOUD:
      default:
        return _defaultLinkParser(html);
    }
  }

  List<String> _defaultLinkParser(String html) {
    final text = RegExp(r'(?:(?:https?):\/\/)[\w/\-?=%.,]+\.(m3u8|mp4)+')
        .allMatches(html);
    return text.map((e) => html.substring(e.start, e.end)).toSet().toList();
  }

  List<String> _mediaFireFilter(List<String> links) {
    links.removeWhere((value) =>
        value.startsWith('https://www.') || value.startsWith('http://www.'));
    return links;
  }
}
