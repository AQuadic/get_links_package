class AQLinkResult {
  String url;
  String cookie;
  String quality;

  AQLinkResult.fromMap(Map<String, dynamic> map) {
    url = map['url'];
    cookie = map['cookie'];
    quality = map['quality'];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': this.url,
      'cookie': this.cookie,
      'quality': this.quality,
    };
  }
}