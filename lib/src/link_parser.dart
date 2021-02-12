import 'package:get_links/enum/video_website.dart';

class AQHTMLParser {
  List<String> parseHTML(VideoWebsite type, String html) {
    switch (type) {
      case VideoWebsite.OK_RU:
      case VideoWebsite.MYSTREAM_TO:
      case VideoWebsite.MEGA_NZ:
      case VideoWebsite.MEDIAFIRE:
      case VideoWebsite.SOLIDFILES:
      case VideoWebsite.FEMBED:
      case VideoWebsite.FEURL:
      case VideoWebsite.GOOGLE_DRIVE:
      case VideoWebsite.VIDLOX:
      case VideoWebsite.TUNE:
      case VideoWebsite.MIXDROP:
      case VideoWebsite.JAWCLOUD:
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
