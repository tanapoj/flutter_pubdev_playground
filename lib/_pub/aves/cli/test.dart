import 'dart:io';

/// Creates a new file from a [path] and [value].
createNewFile(
  String path,
  String value, {
  bool forceCreate = false,
}) async {
  if (!forceCreate && await File(path).exists()) {
    throw Exception('File exist');
  }
  final File file = File(path);
  print(file);
  await file.writeAsString(value);
}

/// Creates a new directory from a [path] if it doesn't exist.
makeDirectory(String path) async {
  try {
    Directory directory = Directory(path);
    print('1 $directory');
    print('2 exist: ${await directory.exists()}');
    if (!(await directory.exists())) {
      var d = await directory.create();
      print('create dir: $directory, $d');
    }
  } catch (e) {
    print(e);
  }
}
