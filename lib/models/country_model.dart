class Country {
  final String commonName;
  final String officialName;
  final List<String> tld;
  final String cca2;
  final String ccn3;

  Country({
    required this.commonName,
    required this.officialName,
    required this.tld,
    required this.cca2,
    required this.ccn3,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      commonName: json['name']['common'],
      officialName: json['name']['official'],
      tld: List<String>.from(json['tld']),
      cca2: json['cca2'],
      ccn3: json['ccn3'],
    );
  }
}