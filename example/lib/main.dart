import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_links/get_links.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(AQGetLinksApp());

class AQGetLinksApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AQ Get Link Package Example.',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AQHomePage(),
    );
  }
}

class AQHomePage extends StatefulWidget {
  @override
  _AQHomePageState createState() => _AQHomePageState();
}

class _AQHomePageState extends State<AQHomePage> {
  bool _isLoading = false;
  String _fetchingLink;
  List<String> _links = [];
  List<String> _testingLinks = [
    "http://ok.ru/video/1826829830855",
    "https://mystream.to/watch/leyn3wamlk4j",
    "https://mega.nz/file/DvolUAKa#DUG062i7rdC-PMT5G6zlvPY_AJAxH3xAwWEIP_DYxrk",
    "http://www.mediafire.com/?xd9ocis79brkqnj",
    "http://www.solidfiles.com/v/88jakRaX4Q8pp",
    "https://www.fembed.com/api/source/n80d0b23x6gnp2j",
    "https://feurl.com/v/54x36ide7j2ynkg",
    "https://drive.google.com/file/d/1oJJRVprpeFELXK9vxbB8tuCvlTqQpVXP/view?usp=sharing",
    "https://vidlox.me/embed-oeice9s9u6ek.html",
    "https://tune.pk/video/8938703/100-man-no-03-hd",
    "https://mixdrop.co/e/3n69pkxof9xv1",
    "http://jawcloud.co/embed-wto9u79ejgrr.html",
    "https://uptostream.com/uynbcocfvufc",
    "https://uptobox.com/uynbcocfvufc",
  ];

  Future<void> _fetch(BuildContext context, String val) async {
    try {
      // Enable Loading...
      _fetchingLink = val;
      _isLoading = true;
      setState(() {});

      // Delay One Sec. For no reason.
      await Future.delayed(Duration(seconds: 1));

      // Get Links.
      _links = await AQFetcher().getByLink(link: val);

      // Disable Loading...
      _isLoading = false;
      _fetchingLink = null;
      setState(() {});
    } catch (e) {
      // Disable Loading...
      _isLoading = false;
      _fetchingLink = null;

      // Add Error To Links.
      _links = ['$e'];

      // Rebuild Screen.
      setState(() {});
    }
  }

  String get _getSupportedWebsites => AQVideoWebsite.values
      .map((e) => ' ${e.toString().split('AQVideoWebsite.')[1]} ')
      .toString();

  Widget _getBodyWidget(BuildContext context) {
    if (_isLoading)
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset('assets/logo.png', width: 64, height: 64),
            SizedBox(height: 16, width: double.infinity),
            Text(
              '$_fetchingLink',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8, width: double.infinity),
            CupertinoActivityIndicator(),
          ],
        ),
      );

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset('assets/logo.png', width: 64, height: 64),
            SizedBox(height: 16, width: double.infinity),
            TextField(
              autofillHints: <String>[AutofillHints.url],
              keyboardAppearance: Brightness.dark,
              keyboardType: TextInputType.url,
              onSubmitted: (val) => _fetch(context, val),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Website Url',
                hintText: _getSupportedWebsites,
                helperText: _links.isEmpty
                    ? 'We Support Those Links: $_getSupportedWebsites'
                    : '',
                helperMaxLines: 5,
                helperStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                hintStyle: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                labelStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 24),
            for (String i in _links) ...[
              SizedBox(height: 4),
              GestureDetector(
                onTap: () => launch(i),
                child: Text(
                  i,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.0,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Divider(),
            ],
            SizedBox(height: 16, width: double.infinity),
            Divider(),
            Text(
              'Testing Links, Press Any.',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              textScaleFactor: 1.0,
              style: TextStyle(
                color: Colors.red,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8, width: double.infinity),
            for (String i in _testingLinks) ...[
              SizedBox(height: 4),
              GestureDetector(
                onTap: () => _fetch(context, i),
                child: Text(
                  i,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.0,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Divider(),
            ],
            SizedBox(height: 16, width: double.infinity),
          ],
        ),
      ),
    );
  }

  void _showWebsites(BuildContext context){
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Supported Website',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              textScaleFactor: 1.0,
              style: TextStyle(
                color: Colors.red,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            for(AQVideoWebsite i in AQVideoWebsite.values) ...[
              SizedBox(height: 4),
              Text(
                i.toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                textScaleFactor: 1.0,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
            ],
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('AQGetLink Example'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.link),
            onPressed: () => _showWebsites(context),
          ),
        ],
      ),
      body: _getBodyWidget(context),
    );
  }
}
