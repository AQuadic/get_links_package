import 'package:get_links/models/aq_link_model.dart';
import 'package:get_links/src/embed_generator.dart';
import 'package:get_links/src/website_detector.dart';

abstract class AQFetcher {
  AQFetcher._(); // disable making object of this class.

  static AQLink parseStreamLink({String link}) {
    // always support https not http.
    link = link.replaceFirst('http://', 'https://');

    // continue our converting...
    final _util = AQWebsiteDetector();
    final _linkType = _util.getWebsiteType(link);
    final _linkId = _util.extractIdFromLink(_linkType, link);

    return AQLink(
      link: link,
      type: _linkType,
      linkId: _linkId,
      nickname: _util.getServerNickName(_linkType),
      realName: _util.getServerFullName(_linkType) ?? Uri.tryParse(link)?.host,
      embedLink: _util.getEmbedWebsiteUrl(_linkType, _linkId),
      xGetterLink: _util.getXGetterUrl(_linkType, _linkId),
      embedCode: AQEmbedGenerator().generate(link, _linkType),
    );
  }
}
