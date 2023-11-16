class AppSettings {
  final String appVersion;

  AppSettings({
    required this.appVersion,
  });

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      appVersion: json['app_version'],
    );
  }
}
class IPInfoLearn {
  final String ip;
  final String city;
  final String region;
  final String country;
  final String loc;
  final String org;
  final String postal;
  final String timezone;
  final String readme;

  IPInfoLearn({
    required this.ip,
    required this.city,
    required this.region,
    required this.country,
    required this.loc,
    required this.org,
    required this.postal,
    required this.timezone,
    required this.readme,
  });

  factory IPInfoLearn.fromJson(Map<String, dynamic> json) {
    return IPInfoLearn(
      ip: json['ip'],
      city: json['city'],
      region: json['region'],
      country: json['country'],
      loc: json['loc'],
      org: json['org'],
      postal: json['postal'],
      timezone: json['timezone'],
      readme: json['readme'],
    );
  }
}