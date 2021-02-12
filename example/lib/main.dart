import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_links/get_links.dart';

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
          children: [
            Text(
              '$_fetchingLink',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            CupertinoActivityIndicator(),
          ],
        ),
      );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
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
            Text(
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
            Divider(),
          ]
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('AQGetLink Example'),
      ),
      body: _getBodyWidget(context),
    );
  }
}
