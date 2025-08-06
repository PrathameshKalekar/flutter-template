extension StringExtensions on String?{
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  
  //Convertions 
  double get toDouble => double.parse(this ?? '0');
  int get toInt => int.parse(this ?? '0');
  DateTime get toDateTime => DateTime.parse(this ?? '2000-01-01');
  
  //String Extensions
  String get toCapitalize => this?.isNotEmpty ?? false ? '${this![0].toUpperCase()}${this!.substring(1)}' : '';
}