import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:filesize/filesize.dart';
import 'package:get_links/enum/video_website.dart';
import 'package:get_links/get_links.dart';
import 'package:quiver/strings.dart';

class DioFetcher {
  DioFetcher._() {
    // Attach Interceptors
    _dio.interceptors.add(CookieManager(cookieJar));
  }

  // Singleton Instance.
  static final DioFetcher instance = DioFetcher._();

  // Cookie Jar.
  final cookieJar = CookieJar();

  // Http Client.
  final Dio _dio = Dio();

  bool isSupported(AQVideoWebsite type) => <AQVideoWebsite>[
        AQVideoWebsite.SOLIDFILES,
        AQVideoWebsite.FEURL,
        AQVideoWebsite.FEMBED,
        AQVideoWebsite.MEDIAFIRE,
        AQVideoWebsite.FOUR_SHARED,
        AQVideoWebsite.GOOGLE_DRIVE,
        AQVideoWebsite.OK_RU,
      ].contains(type);

  Future<List<AQLinkResult>> fetch(AQVideoWebsite type, String id,
      {String token}) async {
    switch (type) {
      case AQVideoWebsite.SOLIDFILES:
        return _fetchSolidFiles(id: id);
        break;
      case AQVideoWebsite.FEURL:
      case AQVideoWebsite.FEMBED:
        return _fetchFembed(id: id);
        break;
      case AQVideoWebsite.MEDIAFIRE:
        return _fetchMediaFire(id: id);
        break;
      case AQVideoWebsite.FOUR_SHARED:
        return _fetchFourShared(id: id);
        break;
      case AQVideoWebsite.GOOGLE_DRIVE:
        return _fetchGoogleDrive(id: id, token: token);
        break;
      case AQVideoWebsite.OK_RU:
        return _fetchOkRu(id: id);
        break;
      case AQVideoWebsite.TUNE:
      case AQVideoWebsite.USER_LOAD:
      case AQVideoWebsite.DOOD_WATCH:
      case AQVideoWebsite.MIXDROP:
      case AQVideoWebsite.YOUR_UPLOAD:
      case AQVideoWebsite.SEND_VID:
      case AQVideoWebsite.MEGA_NZ:
      case AQVideoWebsite.MYSTREAM_TO:
      case AQVideoWebsite.SAMA_SHARE:
      case AQVideoWebsite.ONE_FICHIER:
      case AQVideoWebsite.UP_TO_STREAM:
      case AQVideoWebsite.UP_TO_BOX:
      case AQVideoWebsite.MP4UPLOAD:
      case AQVideoWebsite.VIDLOX:
      case AQVideoWebsite.YOUD_BOX:
      case AQVideoWebsite.UQ_LOAD:
      case AQVideoWebsite.JAWCLOUD:
      case AQVideoWebsite.VID_BEM:
      case AQVideoWebsite.VID_BOOM:
      case AQVideoWebsite.VED_SHAAR:
      default:
        return await Future.value(<AQLinkResult>[]);
    }
  }

  Future<String> getVideoSize({AQLinkResult link}) async {
    if (isNotBlank(link.cookie)) {
      cookieJar.loadForRequest(Uri.parse(link.cookie));
    }

    final _response = await _dio.head(link.url);

    final _contentLength = _response.headers.value('content-length');

    if (isBlank(_contentLength)) throw '';
    return filesize(_contentLength);
  }

  Future<List<AQLinkResult>> _fetchFourShared({String id}) async {
    final _response = await _dio.get(
      'https://www.4shared.com/web/embed/file/$id',
    );

    final _link =
        (_response.data as String).split('<source src=\"')[1].split('\"').first;

    return <AQLinkResult>[
      AQLinkResult(
        quality: 'Available',
        url: _link,
        size: null,
        cookie: null,
      ),
    ];
  }

  Future<List<AQLinkResult>> _fetchOkRu({String id}) async {
    final _response = await _dio.get(
      'https://ok.ru/videoembed/$id',
    );

    final _link = (_response.data as String)
        .split('data-options=\"')[1]
        .split('\"')
        .first
        .replaceAll('&quot;', '\"');

    // We Decode response then decode flashvars => metadata.
    final _data = json.decode((json.decode(_link)['flashvars']['metadata']));

    final _aqLinks = <AQLinkResult>[];

    (_data['videos'] as List).forEach(
      (element) {
        _aqLinks.add(
          AQLinkResult(
            quality: _fixOkRuQuality(element['name']),
            url: element['url'],
            size: null,
            cookie: null,
          ),
        );
      },
    );

    return _aqLinks;
  }

  String _fixOkRuQuality(String name) {
    if (name == "mobile") {
      return "144p";
    } else if (name == "lowest") {
      return "240p";
    } else if (name == "low") {
      return "360p";
    } else if (name == "sd") {
      return "480p";
    } else if (name == "hd") {
      return "720p";
    } else if (name == "full") {
      return "1080p";
    } else if (name == "quad") {
      return "2000p";
    } else if (name == "ultra") {
      return "4000p";
    } else {
      return "Available";
    }
  }

  Future<List<AQLinkResult>> _fetchMediaFire({String id}) async {
    final _response = await _dio.get(
      'http://www.mediafire.com/file/$id/$id/file',
    );

    final _link = (_response.data as String)
        .split('aria-label=\"Download file\"\n')[1]
        .split('href=\"')[1]
        .split('\"')
        .first;

    return <AQLinkResult>[
      AQLinkResult(
        quality: 'Available',
        url: _link,
        size: null,
        cookie: null,
      ),
    ];
  }

  Future<List<AQLinkResult>> _fetchSolidFiles({String id}) async {
    final _response = await _dio.get(
      'https://www.solidfiles.com/e/$id',
    );

    final _link = (_response.data as String)
        .split('(\'viewerOptions\', ')[1]
        .split(');')
        .first;

    final _data = json.decode(_link);

    return <AQLinkResult>[
      AQLinkResult(
        quality: 'Stream',
        url: _data['streamUrl'],
        size: null,
        cookie: null,
      ),
      AQLinkResult(
        quality: 'Download',
        url: _data['downloadUrl'],
        size: null,
        cookie: null,
      ),
    ];
  }

  Future<List<AQLinkResult>> _fetchFembed({String id}) async {
    final _response = await _dio.post(
      'https://www.fembed.com/api/source/$id',
    );

    final _data = _response.data as Map<String, dynamic>;

    if (_data['success'] == false) {
      // wrong response
      return <AQLinkResult>[];
    }

    final _aqLinks = <AQLinkResult>[];

    (_data['data'] as List).forEach(
      (element) {
        _aqLinks.add(
          AQLinkResult(
            quality: element['label'],
            url: element['file'],
            size: null,
            cookie: null,
          ),
        );
      },
    );

    return _aqLinks;
  }

  Future<AQLinkResult> _fetchGDriveFullQ({String id, String token}) async {
    final _res = AQLinkResult.fromMap({
      "quality": "Best Quality",
      "url":
          "https://www.googleapis.com/drive/v3/files/$id?key=$token&alt=media",
      // "cookie": "https://drive.google.com",
    });

    _res.size = await getVideoSize(link: _res);
    return _res;
  }

  Future<List<AQLinkResult>> _fetchGoogleDrive(
      {String id, String token}) async {
    // Get Full Quality.
    final _fullQuality = await _fetchGDriveFullQ(id: id, token: token);
    return [_fullQuality];

    final _response = await _dio.get(
      'https://drive.google.com/get_video_info',
      queryParameters: {
        'docid': id,
      },
    );

    // 1stParse Video Info.
    final _fParse = Uri.parse('https://x.y?${_response.data}');
    if (_fParse.queryParameters['status'] != 'ok') return <AQLinkResult>[];

    // fetch Cookies.
    var c = _response.headers.map['set-cookie'] ?? <String>[];
    final cookies = c.map((e) => Cookie.fromSetCookieValue(e)).toList();

    // Save Cookies.
    cookieJar.saveFromResponse(
      Uri.parse("https://drive.google.com"),
      cookies,
    );

    // 2ndParse Video Info.
    final _sParse = Uri.parse(
      'https://x.y?${_fParse.queryParameters['url_encoded_fmt_stream_map']}',
    );

    // Extract Video Links.
    final _links = <AQLinkResult>[_fullQuality];
    for (int i = 0; i < _sParse.queryParametersAll['url'].length; i++) {
      _links.add(AQLinkResult.fromMap({
        "quality": _sParse.queryParametersAll['quality'][i],
        "url": _sParse.queryParametersAll['url'][i],
        "cookie": "https://drive.google.com",
      }));
    }
    return _links;
  }
}
