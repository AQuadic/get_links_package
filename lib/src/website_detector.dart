import 'package:get_links/enum/video_website.dart';

class AQWebsiteDetector {
  String getWebsiteUrl(AQVideoWebsite website, String id) {
    switch (website) {
      case AQVideoWebsite.OK_RU:
        return "https://ok.ru/video/$id";
        break;
      case AQVideoWebsite.MYSTREAM_TO:
        return "https://embed.mystream.to/$id";
        break;
      case AQVideoWebsite.UP_TO_STREAM:
      case AQVideoWebsite.UP_TO_BOX:
        return "https://uptostream.com/$id";
        break;
      case AQVideoWebsite.MEGA_NZ:
        return _completeMegaLink(id);
        break;
      case AQVideoWebsite.MEDIAFIRE:
        return "http://www.mediafire.com/file/$id";
        break;
      case AQVideoWebsite.SOLIDFILES:
        return "http://www.solidfiles.com/v/$id";
        break;
      case AQVideoWebsite.FEMBED:
      case AQVideoWebsite.FEURL:
        return "https://feurl.com/v/$id";
        break;
      case AQVideoWebsite.GOOGLE_DRIVE:
        return "https://drive.google.com/file/d/$id/view?usp=sharing";
        break;
      case AQVideoWebsite.VIDLOX:
        return "http://vidlox.me/embed-$id";
        break;
      case AQVideoWebsite.TUNE:
        return "https://tune.pk/video/$id";
        break;
      case AQVideoWebsite.MIXDROP:
        return "https://mixdrop.co/e/$id";
        break;
      case AQVideoWebsite.JAWCLOUD:
        return "http://jawcloud.co/embed-$id.html";
        break;
      default:
        throw "Unknown Website.";
    }
  }

  AQVideoWebsite getWebsiteType(String link) {
    if (link.contains('ok.ru/'))
      return AQVideoWebsite.OK_RU;
    //
    else if (link.contains('mystream.to/'))
      return AQVideoWebsite.MYSTREAM_TO;
    //
    else if (link.contains('uptostream.com/'))
      return AQVideoWebsite.UP_TO_STREAM;
    //
    else if (link.contains('uptobox.com/'))
      return AQVideoWebsite.UP_TO_BOX;
    //
    else if (link.contains('mega.nz/'))
      return AQVideoWebsite.MEGA_NZ;
    //
    else if (link.contains('mediafire.com/'))
      return AQVideoWebsite.MEDIAFIRE;
    //
    else if (link.contains('solidfiles.com/'))
      return AQVideoWebsite.SOLIDFILES;
    //
    else if (link.contains('fembed.com/'))
      return AQVideoWebsite.FEMBED;
    //
    else if (link.contains('feurl.com/'))
      return AQVideoWebsite.FEURL;
    //
    else if (link.contains('vidlox.me/'))
      return AQVideoWebsite.VIDLOX;
    //
    else if (link.contains('tune.pk/'))
      return AQVideoWebsite.TUNE;
    //
    else if (link.contains('mixdrop.co/'))
      return AQVideoWebsite.MIXDROP;
    //
    else if (link.contains('jawcloud.co/'))
      return AQVideoWebsite.JAWCLOUD;
    //
    else if (link.contains('drive.google.com/'))
      return AQVideoWebsite.GOOGLE_DRIVE;

    throw "Unknown Website";
  }

  _completeMegaLink(String id) {
    return "https://mega.nz/file/${id.replaceFirst("!", "#")}";
  }

  String extractIdFromLink(AQVideoWebsite type, String link) {
    final _splits = link.split('/');

    switch (type) {
      case AQVideoWebsite.OK_RU:
      case AQVideoWebsite.MEGA_NZ:
      case AQVideoWebsite.MYSTREAM_TO:
      case AQVideoWebsite.SOLIDFILES:
      case AQVideoWebsite.FEURL:
      case AQVideoWebsite.TUNE:
      case AQVideoWebsite.MIXDROP:
        return _splits[4];
        break;
      case AQVideoWebsite.MEDIAFIRE:
      case AQVideoWebsite.UP_TO_STREAM:
      case AQVideoWebsite.UP_TO_BOX:
        return _splits[3].replaceFirst('?', '');
        break;
      case AQVideoWebsite.FEMBED:
      case AQVideoWebsite.GOOGLE_DRIVE:
        return _splits[5];
        break;
      case AQVideoWebsite.VIDLOX:
      case AQVideoWebsite.JAWCLOUD:
        final _firstSplit = _splits[3];
        return _firstSplit.split('embed-')[1].split('.html')[0];
        break;
      default:
        throw "Unknown Website.";
    }
  }

  String getServerNickName(String link) {
    final _type = getWebsiteType(link);
    switch (_type) {
      case AQVideoWebsite.OK_RU:
        return "RU";
        break;
      case AQVideoWebsite.MYSTREAM_TO:
        return "MS";
        break;
      case AQVideoWebsite.UP_TO_STREAM:
        return "US";
        break;
      case AQVideoWebsite.UP_TO_BOX:
        return "UB";
        break;
      case AQVideoWebsite.MEGA_NZ:
        return "MZ";
        break;
      case AQVideoWebsite.MEDIAFIRE:
        return "AE";
        break;
      case AQVideoWebsite.SOLIDFILES:
        return "SS";
        break;
      case AQVideoWebsite.FEMBED:
      case AQVideoWebsite.FEURL:
        return "FF";
        break;
      case AQVideoWebsite.GOOGLE_DRIVE:
        return "DG";
        break;
      case AQVideoWebsite.VIDLOX:
        return "VX";
        break;
      case AQVideoWebsite.TUNE:
        return "TE";
        break;
      case AQVideoWebsite.MIXDROP:
        return "MP";
        break;
      case AQVideoWebsite.JAWCLOUD:
        return "JD";
        break;
      default:
        return "AQ";
    }
  }

  String getServerFullName(String link) {
    final _type = getWebsiteType(link);
    switch (_type) {
      case AQVideoWebsite.OK_RU:
        return "Ok.ru";
        break;
      case AQVideoWebsite.MYSTREAM_TO:
        return "MyStream.to";
        break;
      case AQVideoWebsite.UP_TO_STREAM:
        return "UpToStream";
        break;
      case AQVideoWebsite.UP_TO_BOX:
        return "UpToBox";
        break;
      case AQVideoWebsite.MEGA_NZ:
        return "Mega.nz";
        break;
      case AQVideoWebsite.MEDIAFIRE:
        return "MediaFire";
        break;
      case AQVideoWebsite.SOLIDFILES:
        return "SolidFiles";
        break;
      case AQVideoWebsite.FEMBED:
        return "FEmbed";
        break;
      case AQVideoWebsite.FEURL:
        return "FeUrl";
        break;
      case AQVideoWebsite.GOOGLE_DRIVE:
        return "GoogleDrive";
        break;
      case AQVideoWebsite.VIDLOX:
        return "VidLox";
        break;
      case AQVideoWebsite.TUNE:
        return "Tune";
        break;
      case AQVideoWebsite.MIXDROP:
        return "MixDrop";
        break;
      case AQVideoWebsite.JAWCLOUD:
        return "JawCloud";
        break;
      default:
        return "AQ Server";
    }
  }

  bool isSupportedWebsite(String link) {
    AQVideoWebsite type;
    try {
      type = getWebsiteType(link);
    } catch (e) {
      type = null;
    }

    switch (type) {
      case AQVideoWebsite.MEDIAFIRE:
      case AQVideoWebsite.TUNE:
      case AQVideoWebsite.JAWCLOUD:
      case AQVideoWebsite.SOLIDFILES:
      case AQVideoWebsite.MYSTREAM_TO:
        return true;
        break;
      case AQVideoWebsite.UP_TO_STREAM: // must click on video first
      case AQVideoWebsite.UP_TO_BOX: // must click on video first
      case AQVideoWebsite.FEMBED: // webview.
      case AQVideoWebsite.FEURL: // webview.
      case AQVideoWebsite.VIDLOX: // generated link doesn't work.
      case AQVideoWebsite.MIXDROP: // have captcha and other stuff.
      case AQVideoWebsite.OK_RU: // unknown.
      case AQVideoWebsite.MEGA_NZ: // hard to fetch.
      case AQVideoWebsite.GOOGLE_DRIVE: // need account access.
      default:
        return false;
        break;
    }
  }
}
