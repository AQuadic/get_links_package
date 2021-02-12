import 'package:get_links/enum/video_website.dart';

class WebsiteDetector {
  String getWebsiteString(VideoWebsite website, String id) {
    switch (website) {
      case VideoWebsite.OK_RU:
        return "https://ok.ru/video/$id";
        break;
      case VideoWebsite.MYSTREAM_TO:
        return "https://mystream.to/watch/$id";
        break;
      case VideoWebsite.MEGA_NZ:
        return _completeMegaLink(id);
        break;
      case VideoWebsite.MEDIAFIRE:
        return "http://www.mediafire.com/file/$id";
        break;
      case VideoWebsite.SOLIDFILES:
        return "http://www.solidfiles.com/v/$id";
        break;
      case VideoWebsite.FEMBED:
      case VideoWebsite.FEURL:
        return "https://feurl.com/v/$id";
        break;
      case VideoWebsite.GOOGLE_DRIVE:
        return "https://drive.google.com/file/d/$id/view?usp=sharing";
        break;
      case VideoWebsite.VIDLOX:
        return "http://vidlox.me/embed-$id";
        break;
      case VideoWebsite.TUNE:
        return "https://tune.pk/video/$id";
        break;
      case VideoWebsite.MIXDROP:
        return "https://mixdrop.co/e/$id";
        break;
      case VideoWebsite.JAWCLOUD:
        return "http://jawcloud.co/embed-$id.html";
        break;
      default:
        throw "Website Not Found";
    }
  }

  VideoWebsite getWebsiteType(String link) {
    if (link.contains('ok.ru'))
      return VideoWebsite.OK_RU;
    //
    else if (link.contains('mystream.to'))
      return VideoWebsite.MYSTREAM_TO;
    //
    else if (link.contains('mega.nz'))
      return VideoWebsite.MEGA_NZ;
    //
    else if (link.contains('mediafire.com'))
      return VideoWebsite.MEDIAFIRE;
    //
    else if (link.contains('solidfiles.com'))
      return VideoWebsite.SOLIDFILES;
    //
    else if (link.contains('feurl.com'))
      return VideoWebsite.FEURL;
    //
    else if (link.contains('vidlox.me'))
      return VideoWebsite.VIDLOX;
    //
    else if (link.contains('tune.pk'))
      return VideoWebsite.TUNE;
    //
    else if (link.contains('mixdrop.co'))
      return VideoWebsite.MIXDROP;
    //
    else if (link.contains('jawcloud.co'))
      return VideoWebsite.JAWCLOUD;
    //
    else if (link.contains('drive.google.com'))
      return VideoWebsite.GOOGLE_DRIVE;

    throw "Website Not Found";
  }

  _completeMegaLink(String id) {
    return id.replaceFirst("!", "#");
  }

  String getServerNickName(String link) {
    final _type = getWebsiteType(link);
    switch (_type) {
      case VideoWebsite.OK_RU:
        return "RU";
        break;
      case VideoWebsite.MYSTREAM_TO:
        return "MS";
        break;
      case VideoWebsite.MEGA_NZ:
        return "MZ";
        break;
      case VideoWebsite.MEDIAFIRE:
        return "AE";
        break;
      case VideoWebsite.SOLIDFILES:
        return "SS";
        break;
      case VideoWebsite.FEMBED:
      case VideoWebsite.FEURL:
        return "FF";
        break;
      case VideoWebsite.GOOGLE_DRIVE:
        return "DG";
        break;
      case VideoWebsite.VIDLOX:
        return "VX";
        break;
      case VideoWebsite.TUNE:
        return "TE";
        break;
      case VideoWebsite.MIXDROP:
        return "MP";
        break;
      case VideoWebsite.JAWCLOUD:
        return "JD";
        break;
      default:
        return "AQ";
    }
  }
}
