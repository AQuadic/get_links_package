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
    final url = AQWebsiteDetector().getWebsiteUrl(type, id);
    return await _getFromWebViewOrDio(url, type);
  }

  Future<List<String>> getByLink({
    @required String link,
    AQVideoWebsite type,
  }) async {
    type ??= AQWebsiteDetector().getWebsiteType(link);
    final id = AQWebsiteDetector().extractIdFromLink(type, link);
    return await getLinksById(id: id, type: type);
  }

  Future<List<String>> _getFromWebViewOrDio(
      String link, AQVideoWebsite type) async {
    switch (type) {
      case AQVideoWebsite.MEDIAFIRE:
      case AQVideoWebsite.TUNE:
      case AQVideoWebsite.JAWCLOUD:
      case AQVideoWebsite.SOLIDFILES:
        final _html = await AQDioFetcher().getHtmlFromDio(link);
        return AQHTMLParser().parseHTML(type, _html);
        break;
      case AQVideoWebsite.MYSTREAM_TO:
      case AQVideoWebsite.UP_TO_BOX:
        final _fetcher = AQWebViewFetcher(type, link);
        final _links = await _fetcher.streamController.stream.first;
        await _fetcher.dispose();
        return _links;
        break;
      case AQVideoWebsite.UP_TO_STREAM: // must click on video first.
      case AQVideoWebsite.FEMBED: // webview.
      case AQVideoWebsite.FEURL: // webview.
      case AQVideoWebsite.VIDLOX: // generated link doesn't work.
      case AQVideoWebsite.MIXDROP: // have captcha and other stuff.
      case AQVideoWebsite.OK_RU: // unknown.
      case AQVideoWebsite.MEGA_NZ: // hard to fetch.
      case AQVideoWebsite.GOOGLE_DRIVE: // need account access.
        throw UnimplementedError();
      default:
        throw "Website Not Supported";
    }
  }
}
