class AQLinkResult {
  String url;
  String cookie;
  String quality;
  String size;

  AQLinkResult.fromMap(Map<String, dynamic> map) {
    url = map['url'];
    cookie = map['cookie'];
    quality = map['quality'];
    size = map['size'];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': this.url,
      'cookie': this.cookie,
      'quality': this.quality,
      'size': this.size,
    };
  }
}