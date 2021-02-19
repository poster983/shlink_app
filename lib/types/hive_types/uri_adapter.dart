import 'package:hive/hive.dart';

/// Hive adapter for the URI class.  Uses tostring and parse 
class UriAdapter extends TypeAdapter<Uri> {
  @override
  final typeId = 1;

  @override
  Uri read(BinaryReader reader) {
    var url = reader.readString();
    //print(url);
    return Uri.parse(url);
  }

  @override
  void write(BinaryWriter writer, Uri obj) {
    writer.writeString(obj.toString());
  }
}
