library get_links;

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum Links {
  OK_RU,
  MYSTREAM_TO,
  MEGA_NZ,
  MEDIAFIRE,
  SOLIDFILES,
  FEMBED,
  FEURL,
  GOOGLE_DRIVE,
  VIDLOX,
  TUNE,
  MIXDROP,
  JAWCLOUD
}

class GetLinks {
  final _dio = Dio();
  String _getLinkForResponse(Links link, String id) {
    switch (link) {
      case Links.OK_RU:
        return "https://ok.ru/video/$id";
        break;
      case Links.MYSTREAM_TO:
        return "https://mystream.to/watch/$id";
        break;
      case Links.MEGA_NZ:
        //TODO id is changing
        return "https://mega.nz/file/$id";
        break;
      case Links.MEDIAFIRE:
        return "http://www.mediafire.com/file/$id";
        break;
      case Links.SOLIDFILES:
        return "http://www.solidfiles.com/v/$id";
        break;
      case Links.FEMBED:
      case Links.FEURL:
        return "https://feurl.com/v/$id";
        break;
      case Links.GOOGLE_DRIVE:

        // TODO: Handle this case.
        break;
      case Links.VIDLOX:
        return "http://vidlox.me/embed-$id";
        break;
      case Links.TUNE:
        return "https://tune.pk/video/$id";
        break;
      case Links.MIXDROP:
        return "https://mixdrop.co/e/$id";
        break;
      case Links.JAWCLOUD:
        return "http://jawcloud.co/embed-$id.html";
        break;
    }
  }

  Future<List<String>> getLinksById(
      {@required Links type, @required String id}) async {
    final url = _getLinkForResponse(type, id);
    return await getByLink(url);
  }

  Future<List<String>> getByLink(String link) async {
    final html = await _getHtml(link);
    return _extractLink(html);
  }

  Future<String> _getHtml(String link) async {
    final _response = await _dio.get(link);

    if (_response.statusCode >= 200 && _response.statusCode < 300) {
      return _response.data;
    } else {
      throw _response.data;
    }
  }

  List<String> _extractLink(String html) {
    final text = RegExp(r'(?:(?:https?):\/\/)[\w/\-?=%.,]+\.(m3u8|mp4)+')
        .allMatches(html);
    final listOfLinks =
        text.map((e) => html.substring(e.start, e.end)).toSet().toList();
  }

  String _gethtmlfrom() {
    WebViewController _controller;

    WebView(
      initialUrl:
          'https://mega.nz/file/DvolUAKa#DUG062i7rdC-PMT5G6zlvPY_AJAxH3xAwWEIP_DYxrk',
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) {
        // Get reference to WebView controller to access it globally
        _controller = webViewController;
      },
      javascriptChannels: <JavascriptChannel>[
        // Set Javascript Channel to WebView
        JavascriptChannel(
          name: 'Flutter',
          onMessageReceived: (JavascriptMessage message) {
            String pageBody = message.message;
            print('page body: $pageBody');
          },
        )
      ].toSet(),
      onPageStarted: (String url) {
        print('Page started loading: $url');
      },
      onPageFinished: (String url) async {
        print('Page finished loading: $url');
        // In the final result page we check the url to make sure  it is the last page.
        try {
          String docu = await _controller.evaluateJavascript(
              "document.documentElement.innerHTML") as String;
          print(docu);
        } catch (e, s) {
          print(e);
          print(s);
        }
      },
    );
  }
}
