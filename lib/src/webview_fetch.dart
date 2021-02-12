class WebViewFetcher {
  Future<String> getHtmlFromWebView(String link) async{
    //TODO get html from web view
    return '';
    // print('get from web $link');
    // WebViewController _controller;
    // String html;
    // final htm = WebView(
    //   initialUrl: link,
    //   javascriptMode: JavascriptMode.unrestricted,
    //   onWebViewCreated: (WebViewController webViewController) {
    //     // Get reference to WebView controller to access it globally
    //     _controller = webViewController;
    //   },
    //   javascriptChannels: <JavascriptChannel>[
    //     // Set Javascript Channel to WebView
    //     JavascriptChannel(
    //       name: 'Flutter',
    //       onMessageReceived: (JavascriptMessage message) {
    //         String pageBody = message.message;
    //         print('page body: $pageBody');
    //       },
    //     )
    //   ].toSet(),
    //   onPageStarted: (String url) {
    //     print('Page started loading: $url');
    //   },
    //   onPageFinished: (String url) async {
    //     print('Page finished loading: $url');
    //     // In the final result page we check the url to make sure  it is the last page.
    //     try {
    //       String docu = await _controller
    //           .evaluateJavascript("document.documentElement.innerHTML");
    //       html = docu;
    //       return docu;
    //       print(docu);
    //     } catch (e, s) {
    //       print(e);
    //       print(s);
    //     }
    //   },
    // );
    // return html;
  }
}