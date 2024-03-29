import 'package:get_links/enum/video_website.dart';

class AQWebsiteDetector {
  String getEmbedWebsiteUrl(AQVideoWebsite website, String id) {
    switch (website) {
      case AQVideoWebsite.OK_RU:
        return "https://ok.ru/videoembed/$id";
        break;
      case AQVideoWebsite.MYSTREAM_TO:
        return "https://embed.mystream.to/$id";
        break;
      case AQVideoWebsite.UP_TO_STREAM:
      case AQVideoWebsite.UP_TO_BOX:
        return "https://uptostream.com/iframe/$id";
        break;
      case AQVideoWebsite.MEGA_NZ:
        return "https://mega.nz/file/$id";
        break;
      case AQVideoWebsite.SOLIDFILES:
        return "https://www.solidfiles.com/e/$id";
        break;
      case AQVideoWebsite.FEMBED:
      case AQVideoWebsite.FEURL:
        return "https://fembed.com/v/$id";
        break;
      case AQVideoWebsite.GOOGLE_DRIVE:
        return "https://drive.google.com/file/d/$id/view?usp=sharing";
        break;
      case AQVideoWebsite.VIDLOX:
        return "https://vidlox.me/embed-$id";
        break;
      case AQVideoWebsite.MIXDROP:
        return "https://mixdrop.co/e/$id";
        break;
      case AQVideoWebsite.JAWCLOUD:
        return "https://jawcloud.co/embed-$id.html";
        break;
      case AQVideoWebsite.MP4UPLOAD:
        return "https://www.mp4upload.com/embed-$id.html";
        break;
      case AQVideoWebsite.USER_LOAD:
        return "https://userload.co/embed/$id";
      case AQVideoWebsite.SAMA_SHARE:
        return "https://sama-share.com/embed-$id-1256x718.html";
      case AQVideoWebsite.DOOD_WATCH:
        return "https://dood.watch/e/$id";
      case AQVideoWebsite.YOUD_BOX:
        return "https://youdbox.net/embed-$id.html";
      case AQVideoWebsite.VID_BEM:
      case AQVideoWebsite.VID_BOOM:
        return "https://vidbem.com/embed-$id.html";
      case AQVideoWebsite.UQ_LOAD:
        return "https://uqload.com/embed-$id.html";
      case AQVideoWebsite.VED_SHAAR:
        return "https://vedshaar.com/embed-$id.html";
      case AQVideoWebsite.YOUR_UPLOAD:
        return "https://www.yourupload.com/embed/$id";
      case AQVideoWebsite.FOUR_SHARED:
        return "https://www.4shared.com/web/embed/file/$id";
      case AQVideoWebsite.ONE_FICHIER:
      case AQVideoWebsite.MEDIAFIRE:
      //   return "https://www.mediafire.com/file/$id";
      //   break;
      case AQVideoWebsite.TUNE:
      // ex: https://tune.pk/js/open/embed.js?vid=8930819&userid=569794
      //   return "https://tune.pk/video/$id";
      //   break;
      default:
        return null;
    }
  }

  String getXGetterUrl(AQVideoWebsite website, String id) {
    switch (website) {
      case AQVideoWebsite.UP_TO_STREAM:
      case AQVideoWebsite.UP_TO_BOX:
        return "https://uptostream.com/iframe/$id";
        break;
      case AQVideoWebsite.OK_RU:
      case AQVideoWebsite.SOLIDFILES:
      case AQVideoWebsite.FEMBED:
      case AQVideoWebsite.FEURL:
      case AQVideoWebsite.MEDIAFIRE:
      case AQVideoWebsite.GOOGLE_DRIVE:
      case AQVideoWebsite.MP4UPLOAD:
      case AQVideoWebsite.FOUR_SHARED:
      case AQVideoWebsite.MYSTREAM_TO:
      case AQVideoWebsite.VIDLOX:
      case AQVideoWebsite.MEGA_NZ:
      case AQVideoWebsite.MIXDROP:
      case AQVideoWebsite.JAWCLOUD:
      case AQVideoWebsite.TUNE:
      case AQVideoWebsite.USER_LOAD:
      case AQVideoWebsite.SAMA_SHARE:
      case AQVideoWebsite.ONE_FICHIER:
      case AQVideoWebsite.DOOD_WATCH:
      case AQVideoWebsite.YOUD_BOX:
      case AQVideoWebsite.VID_BEM:
      case AQVideoWebsite.VID_BOOM:
      case AQVideoWebsite.UQ_LOAD:
      case AQVideoWebsite.YOUR_UPLOAD:
      case AQVideoWebsite.VED_SHAAR:
      default:
        return null;
    }
  }

  AQVideoWebsite getWebsiteType(String link) {
    link = link.toLowerCase(); // just to make sure detector is accurate.
    //
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
    else if (link.contains('mixdrop.co/') || link.contains('mixdrop.to/'))
      return AQVideoWebsite.MIXDROP;
    //
    else if (link.contains('jawcloud.co/'))
      return AQVideoWebsite.JAWCLOUD;
    //
    else if (link.contains('drive.google.com/'))
      return AQVideoWebsite.GOOGLE_DRIVE;
    //
    else if (link.contains('mp4upload.com/'))
      return AQVideoWebsite.MP4UPLOAD;
    //
    else if (link.contains('userload.co/'))
      return AQVideoWebsite.USER_LOAD;
    //
    else if (link.contains('sama-share.com/'))
      return AQVideoWebsite.SAMA_SHARE;
    //
    else if (link.contains('1fichier.com/'))
      return AQVideoWebsite.ONE_FICHIER;
    //
    else if (link.contains('dood.watch/'))
      return AQVideoWebsite.DOOD_WATCH;
    //
    else if (link.contains('youdbox.net/'))
      return AQVideoWebsite.YOUD_BOX;
    //
    else if (link.contains('vidbem.com/'))
      return AQVideoWebsite.VID_BEM;
    //
    else if (link.contains('vedboom.com/'))
      return AQVideoWebsite.VID_BOOM;
    //
    else if (link.contains('uqload.com/'))
      return AQVideoWebsite.UQ_LOAD;
    //
    else if (link.contains('yourupload.com/'))
      return AQVideoWebsite.YOUR_UPLOAD;
    //
    else if (link.contains('4shared.com/'))
      return AQVideoWebsite.FOUR_SHARED;
    //
    else if (link.contains('vedshaar.com/')) return AQVideoWebsite.VED_SHAAR;

    return AQVideoWebsite.UNKNOWN;
  }

  String extractIdFromLink(AQVideoWebsite type, String link) {
    // TODO: Needs More Refactor.
    final _splits = link.split('/');

    switch (type) {
      case AQVideoWebsite.OK_RU:
      case AQVideoWebsite.SOLIDFILES:
      case AQVideoWebsite.FEURL:
      case AQVideoWebsite.TUNE: // bullshit.
      case AQVideoWebsite.USER_LOAD:
      case AQVideoWebsite.DOOD_WATCH:
      case AQVideoWebsite.MIXDROP:
      case AQVideoWebsite.YOUR_UPLOAD:
        return _splits[4];
        break;
      case AQVideoWebsite.SEND_VID:
        return _splits[3] == 'embed' ? _splits[4] : _splits[3];
      case AQVideoWebsite.MEGA_NZ:
        String _val =
            (_splits[4] == '/' || _splits[4] == '') ? _splits[5] : _splits[4];
        if (_val[0] == '!') _val = _val.substring(1);
        return _val.replaceFirst('!', '#');
        break;
      case AQVideoWebsite.MYSTREAM_TO:
        return _splits[3] == 'watch' ? _splits[4] : _splits[3];
        break;
      case AQVideoWebsite.MEDIAFIRE:
        return _splits[3] == 'file'
            ? _splits[4]
            : _splits[3].replaceFirst('?', '');
        break;
      case AQVideoWebsite.FOUR_SHARED:
        return _splits[3] == 'web' ? _splits[6] : _splits[4];
      case AQVideoWebsite.SAMA_SHARE:
        return _splits[3].contains('embed-')
            ? _splits[3].split('-')[1]
            : _splits[3];
      case AQVideoWebsite.ONE_FICHIER:
      case AQVideoWebsite.UP_TO_STREAM:
        return _splits[3] == 'iframe' ? _splits[4] : _splits[3];
      case AQVideoWebsite.UP_TO_BOX:
        return _splits[3].replaceFirst('?', '');
        break;
      case AQVideoWebsite.FEMBED:
        return _splits.length >= 6 ? _splits[5] : _splits[4];
        break;
      case AQVideoWebsite.GOOGLE_DRIVE:
        List<String> _newSplit = link.split('/d/');
        if (_newSplit.length == 2) {
          _newSplit = _newSplit[1].split('/');
          return _newSplit.first;
        }
        return Uri.parse(link).queryParameters['id'];
        break;
      case AQVideoWebsite.MP4UPLOAD:
        if (!_splits[3].contains('embed-')) return _splits[3];
        final _firstSplit = _splits[3];
        return _firstSplit.split('embed-')[1].split('.html')[0];
        break;
      case AQVideoWebsite.VIDLOX:
      case AQVideoWebsite.YOUD_BOX:
      case AQVideoWebsite.UQ_LOAD:
      case AQVideoWebsite.JAWCLOUD:
      case AQVideoWebsite.VID_BEM:
      case AQVideoWebsite.VID_BOOM:
      case AQVideoWebsite.VED_SHAAR:
        final _firstSplit = _splits[3];
        return _firstSplit.split('embed-')[1].split('.html')[0];
        break;

      default:
        return link;
    }
  }

  String getServerNickName(AQVideoWebsite link) {
    switch (link) {
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
      case AQVideoWebsite.MP4UPLOAD:
        return "MU";
        break;
      case AQVideoWebsite.USER_LOAD:
        return "UL";
        break;
      case AQVideoWebsite.SAMA_SHARE:
        return "SS";
        break;
      case AQVideoWebsite.ONE_FICHIER:
        return "OF";
        break;
      case AQVideoWebsite.DOOD_WATCH:
        return "DW";
        break;
      case AQVideoWebsite.YOUD_BOX:
        return "YB";
        break;
      case AQVideoWebsite.VID_BEM:
      case AQVideoWebsite.VID_BOOM:
        return "VB";
        break;
      case AQVideoWebsite.UQ_LOAD:
        return "UQ";
        break;
      case AQVideoWebsite.YOUR_UPLOAD:
        return "YU";
        break;
      case AQVideoWebsite.FOUR_SHARED:
        return "4S";
        break;
      case AQVideoWebsite.SEND_VID:
        return "SV";
        break;
      case AQVideoWebsite.VED_SHAAR:
        return "SV";
        break;
      default:
        return "AQ";
    }
  }

  String getServerFullName(AQVideoWebsite type) {
    switch (type) {
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
      case AQVideoWebsite.MP4UPLOAD:
        return "Mp4Upload";
        break;
      case AQVideoWebsite.USER_LOAD:
      case AQVideoWebsite.SAMA_SHARE:
      case AQVideoWebsite.ONE_FICHIER:
      case AQVideoWebsite.DOOD_WATCH:
      case AQVideoWebsite.YOUD_BOX:
      case AQVideoWebsite.VID_BEM:
      case AQVideoWebsite.VID_BOOM:
      case AQVideoWebsite.UQ_LOAD:
      case AQVideoWebsite.YOUR_UPLOAD:
      case AQVideoWebsite.FOUR_SHARED:
      case AQVideoWebsite.SEND_VID:
      case AQVideoWebsite.VED_SHAAR:
      default:
        return null;
    }
  }
}
