extension StringExtensions on String?{
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  
  //Convertions 
  double get toDouble => double.parse(this ?? '0');
  int get toInt => int.parse(this ?? '0');
}