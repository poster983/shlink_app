import 'package:hive/hive.dart';

class DateTimeAdapter extends TypeAdapter<Uri> {
  @override
  final typeId = 1;

  @override
  Uri read(BinaryReader reader) {
    var url = reader.readString();
    return Uri.parse(url);
  }

  @override
  void write(BinaryWriter writer, Uri obj) {
    writer.write(obj.toString());
  }
}
