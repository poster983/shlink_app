import 'dart:ui';

class ChartEntryData {


  final String label;
  final double value;
  final Color? color;

  ChartEntryData({
    required this.label, 
    required this.value, 
    this.color
  });


  

  @override
  String toString() {
    return 'ChartEntryData{label: $label, value: $value, color: $color}';
  }
}