import 'package:flutter/foundation.dart' show required;
import 'package:get_links/enum/video_website.dart';
import 'package:get_links/src/dio_fetch.dart';
import 'package:get_links/src/link_parser.dart';
import 'package:get_links/src/website_detector.dart';
import 'package:get_links/src/webview_fetch.dart';

class AQFetcher {
  Future<List<String>> getLinksById({
    @required AQVideoWebsite type,
    @required String id,
  }) async {
    final url = AQWebsiteDetector().getWebsiteString(type, id);
    return await getByLink(link: url, type: type);
  }

  Future<List<String>> getByLink(
      {@required String link, AQVideoWebsite type}) async {
    type ??= AQWebsiteDetector().getWebsiteType(link);
    return await _getFromWebViewOrDio(link, type);
  }

  Future<List<String>> _getFromWebViewOrDio(
      String link, AQVideoWebsite type) async {
    switch (type) {
      case AQVideoWebsite.MEDIAFIRE:
      case AQVideoWebsite.TUNE:
      case AQVideoWebsite.JAWCLOUD:
      case AQVideoWebsite.SOLIDFILES:
      case AQVideoWebsite.OK_RU:
        final _html = await AQDioFetcher().getHtmlFromDio(link);
        return AQHTMLParser().parseHTML(type, _html);
        break;
      case AQVideoWebsite.FEMBED:
      case AQVideoWebsite.FEURL:
      case AQVideoWebsite.VIDLOX:
      case AQVideoWebsite.MIXDROP:
      case AQVideoWebsite.MYSTREAM_TO:
      case AQVideoWebsite.MEGA_NZ:
        final _html = await AQWebViewFetcher().getHtmlFromWebView(link);
        return AQHTMLParser().parseHTML(type, _html);
        break;
      case AQVideoWebsite.GOOGLE_DRIVE:
        throw UnimplementedError();
      default:
        throw "Website Not Found";
    }
  }
}
