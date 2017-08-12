part of 'sass_watcher.dart';

class Compiler {
  static final String _scssExtensionGlob = '**.scss';
  final String _path;
  final Ignores _ignores;
  final Glob _sassFile;

  Compiler(this._path, this._ignores)
      : _sassFile = new Glob(pathLib.absolute(_path, _scssExtensionGlob));

  Future run() async {
    final compileResult = new CompileResult();

    for (final entity in _sassFile.listSync()) {
      final path = pathLib.normalize(entity.path);

      if (_isCompileTarget(path)) {
        print('Compiling ${path}');
        final resultCSS = sass.compile(path);
        final resultPath =
            '${pathLib.dirname(path)}/${pathLib.basenameWithoutExtension(
            path)}.css';
        compileResult.add(resultPath, resultCSS);
      }
    }

    print('Writing all compiled css files...');
    await compileResult.writeAll();
    print('Done.');
  }

  bool _isCompileTarget(String path) {
    return !_isPartialSassFile(pathLib.basename(path)) &&
        !_ignores.isTarget(path);
  }

  bool _isPartialSassFile(String sassBasename) {
    return sassBasename.startsWith('_');
  }
}

class Ignores {
  final List<String> _ignores;
  Ignores(this._ignores);

  bool isTarget(String path) {
    if (_ignores == null) return false;
    return pathLib.split(path).any((e) => _ignores.contains(e));
  }
}
