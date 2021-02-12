import 'package:get_links/enum/video_website.dart';

class AQHTMLParser {
  List<String> parseHTML(AQVideoWebsite type, String html) {
    switch (type) {
      case AQVideoWebsite.OK_RU:
      case AQVideoWebsite.MYSTREAM_TO:
      case AQVideoWebsite.MEGA_NZ:
      case AQVideoWebsite.MEDIAFIRE:
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
}
