import 'dart:async';

import 'package:get_links/enum/video_website.dart';
import 'package:get_links/src/link_parser.dart';
import 'package:interactive_webview/interactive_webview.dart';

class AQWebViewFetcher {
  final _webView = new InteractiveWebView();
  final streamController = StreamController<List<String>>();
  AQVideoWebsite type;
  String link;
  Timer _timer;

  AQWebViewFetcher(this.type, this.link) {
    _activeListeners();
    _webView.loadUrl(link);
    _activeTimer();
  }

  dispose() async {
    _webView.loadUrl('localhost');
    _webView.didReceiveMessage.listen((event) {});
    _webView.stateChanged.listen((event) {});
    await streamController?.close();
    _timer?.cancel();
  }

  _activeTimer() {
    _timer = Timer(Duration(seconds: 20), () async {
      streamController.addError('Website Timeout', StackTrace.current);
      streamController.add(<String>[]);
      await dispose();
    });
  }

  _activeListeners() {
    _webView.stateChanged.listen(_onStateChanged);
    _webView.didReceiveMessage.listen(_didReceiveMessage);
  }

  _didReceiveMessage(WebkitMessage message) {
    // this is semi work around to check if this is the desired message.
    if (message.data is Map<dynamic, dynamic> &&
        ((message.data as Map<dynamic, dynamic>).keys).contains('name') &&
        message.data['name'] == 'AQ_NAME_DATA') {
      // debugPrint(message.data['data'].toString(), wrapWidth: 512);
      final links = AQHTMLParser().parseHTML(type, message.data['data']);
      if (streamController.isClosed) return;
      streamController.add(links);
    }
  }

  _onStateChanged(WebViewStateChanged event) {
    if (event.type == WebViewState.didFinish) {
      _webView.evalJavascript('''

        function aqFetcher(){
        const nativeCommunicator = typeof webkit !== 'undefined' ? webkit.messageHandlers.native : window.native;
        
        const x = document.documentElement.innerHTML;
        
        const array = {name: "AQ_NAME_DATA", data: x};
        
        nativeCommunicator.postMessage(JSON.stringify(array));
        
        }
        
        aqFetcher();
        
        ''');
    }
  }
}
