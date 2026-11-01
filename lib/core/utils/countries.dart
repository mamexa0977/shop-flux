// lib/core/utils/countries.dart

class Country {
  final String code;
  final String name;
  const Country({required this.code, required this.name});
}

const List<Country> countries = [
  Country(code: 'ET', name: 'Ethiopia'),
  Country(code: 'KE', name: 'Kenya'),
  Country(code: 'UG', name: 'Uganda'),
  Country(code: 'TZ', name: 'Tanzania'),
  Country(code: 'RW', name: 'Rwanda'),
  Country(code: 'DJ', name: 'Djibouti'),
  // Add more as needed
];

/// Get country name from code (for display)
String getCountryName(String code) {
  return countries.firstWhere(
    (c) => c.code == code,
    orElse: () => Country(code: code, name: code),
  ).name;
}