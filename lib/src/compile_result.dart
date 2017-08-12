part of 'sass_watcher.dart';

class CompileResult {
  final List<Tuple2<String, String>> _filePathAndCompiledCssTupleList = [];

  void add(String filePath, String compiledCss) {
    _filePathAndCompiledCssTupleList.add(new Tuple2(filePath, compiledCss));
  }

  Future<Null> writeAll() async {
    await Future.wait(_filePathAndCompiledCssTupleList
        .map((result) => new File(result.item1).writeAsString(result.item2)));
    return null;
  }
}
