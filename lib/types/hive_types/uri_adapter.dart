import 'package:hive/hive.dart';

/// Hive adapter for the URI class.  Uses tostring and parse 
class UriAdapter extends TypeAdapter<Uri> {
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
