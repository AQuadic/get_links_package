import 'package:get_links/enum/video_website.dart';

class AQEmbedGenerator {
  Future<String> generate(String link, AQVideoWebsite type) async {
    switch (type) {
      case AQVideoWebsite.MEGA_NZ:
        return _megaVideoEmbed(link);
        break;
      case AQVideoWebsite.FEMBED: // webview.
      case AQVideoWebsite.FEURL: // webview.
      case AQVideoWebsite.MIXDROP: // have captcha and other stuff.
        return _embedVideoEmbed(link);
      break;
      case AQVideoWebsite.MEDIAFIRE:
      case AQVideoWebsite.TUNE:
      case AQVideoWebsite.JAWCLOUD:
      case AQVideoWebsite.SOLIDFILES:
      case AQVideoWebsite.MYSTREAM_TO:
      case AQVideoWebsite.OK_RU: // unknown.
        throw _normalVideoEmbed(link);
      case AQVideoWebsite.GOOGLE_DRIVE: // need account access.
      case AQVideoWebsite.UP_TO_BOX: // must click on video first.
      case AQVideoWebsite.UP_TO_STREAM: // must click on video first.
      case AQVideoWebsite.VIDLOX: // generated link doesn't work.
      default:
        throw "Website Not Supported";
    }
  }

  String _embedVideoEmbed(String link) {
    return '''
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AQAnime Player</title>
    <style>
        html,
        body {
            height: 100%;
            width: 100%;
            padding: 0;
            margin: 0;
        }

        #mediaplayer {
            height: 100%;
            width: 100%;
            padding: 0;
            margin: 0;
        }

    </style>
</head>
<body>
    <iframe src="$link" width="100%" height="100%"></iframe>
</body>
</html>
    ''';
  }

  String _megaVideoEmbed(String link) {
    return '''
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AQAnime Player</title>
</head>
<body>
<iframe src="$link" width="100%" height="100%" frameborder="0" allowfullscreen></iframe>
</body>
</html>
    ''';
  }

  String _normalVideoEmbed(String link) {
    return '''
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AQAnime Player</title>
    <script src="http://jwpsrv.com/library/FfMxTl3oEeSEiiIACxmInQ.js"></script>
    <style>
        html,
        body {
            height: 100%;
            width: 100%;
            padding: 0;
            margin: 0;
        }

        #mediaplayer {
            height: 100%;
            width: 100%;
            padding: 0;
            margin: 0;
        }

    </style>
</head>
<body>
    <div id="mediaplayer"></div>
    <script>
        jwplayer("mediaplayer").setup({
            file: "$link",
            width: "100%",
            height: "100%",
            stretching: "bestfit",
            autostart: true,
        });
    </script>
</body>
</html>
    ''';
  }
}
