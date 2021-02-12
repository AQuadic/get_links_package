import 'package:get_links/enum/video_website.dart';

class AQWebsiteDetector {
  String getWebsiteString(AQVideoWebsite website, String id) {
    switch (website) {
      case AQVideoWebsite.OK_RU:
        return "https://ok.ru/video/$id";
        break;
      case AQVideoWebsite.MYSTREAM_TO:
        return "https://mystream.to/watch/$id";
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
        throw "Website Not Found";
    }
  }

  AQVideoWebsite getWebsiteType(String link) {
    if (link.contains('ok.ru'))
      return AQVideoWebsite.OK_RU;
    //
    else if (link.contains('mystream.to'))
      return AQVideoWebsite.MYSTREAM_TO;
    //
    else if (link.contains('mega.nz'))
      return AQVideoWebsite.MEGA_NZ;
    //
    else if (link.contains('mediafire.com'))
      return AQVideoWebsite.MEDIAFIRE;
    //
    else if (link.contains('solidfiles.com'))
      return AQVideoWebsite.SOLIDFILES;
    //
    else if (link.contains('feurl.com'))
      return AQVideoWebsite.FEURL;
    //
    else if (link.contains('vidlox.me'))
      return AQVideoWebsite.VIDLOX;
    //
    else if (link.contains('tune.pk'))
      return AQVideoWebsite.TUNE;
    //
    else if (link.contains('mixdrop.co'))
      return AQVideoWebsite.MIXDROP;
    //
    else if (link.contains('jawcloud.co'))
      return AQVideoWebsite.JAWCLOUD;
    //
    else if (link.contains('drive.google.com'))
      return AQVideoWebsite.GOOGLE_DRIVE;

    throw "Website Not Found";
  }

  _completeMegaLink(String id) {
    return id.replaceFirst("!", "#");
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
}
