import 'package:get_links/enum/video_website.dart';

class AQLink {
  String nickname;
  String realName;
  String link;
  String linkId;
  String embedLink;
  String embedCode;
  String xGetterLink;
  AQVideoWebsite type;
  bool aqFetch;

  AQLink({
    this.nickname,
    this.realName,
    this.link,
    this.linkId,
    this.embedLink,
    this.embedCode,
    this.xGetterLink,
    this.type,
    this.aqFetch,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nick_name': this.nickname,
      'real_name': this.realName,
      'link': this.link,
      'embed_link': this.embedLink,
      'embed_code': this.embedCode,
      'x_getter_link': this.xGetterLink,
      'type': this.type,
      'link_id': this.linkId,
      'aq_fetch': this.aqFetch,
    };
  }

  @override
  String toString() => "(AQLink: ${toMap()})";
}
