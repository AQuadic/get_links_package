import 'package:flutter/foundation.dart' show required;
import 'package:get_links/enum/video_website.dart';
import 'package:get_links/src/dio_fetch.dart';
import 'package:get_links/src/link_parser.dart';
import 'package:get_links/src/website_detector.dart';
import 'package:get_links/src/webview_fetch.dart';

class AQFetcher {
  Future<List<String>> getLinksById({
    @required VideoWebsite type,
    @required String id,
  }) async {
    final url = WebsiteDetector().getWebsiteString(type, id);
    return await getByLink(link: url, type: type);
  }

  Future<List<String>> getByLink(
      {@required String link, VideoWebsite type}) async {
    type ??= WebsiteDetector().getWebsiteType(link);
    return await _getFromWebViewOrDio(link, type);
  }

  Future<List<String>> _getFromWebViewOrDio(
      String link, VideoWebsite type) async {
    switch (type) {
      case VideoWebsite.MEDIAFIRE:
      case VideoWebsite.TUNE:
      case VideoWebsite.JAWCLOUD:
      case VideoWebsite.SOLIDFILES:
      case VideoWebsite.OK_RU:
        final _html = await DioFetcher().getHtmlFromDio(link);
        return AQHTMLParser().parseHTML(type, _html);
        break;
      case VideoWebsite.FEMBED:
      case VideoWebsite.FEURL:
      case VideoWebsite.VIDLOX:
      case VideoWebsite.MIXDROP:
      case VideoWebsite.MYSTREAM_TO:
      case VideoWebsite.MEGA_NZ:
        final _html = await WebViewFetcher().getHtmlFromWebView(link);
        return AQHTMLParser().parseHTML(type, _html);
        break;
      case VideoWebsite.GOOGLE_DRIVE:
      // TODO: Implement Google Drive Stuff.
      default:
        throw "Website Not Found";
    }
  }
}
