library sass_watcher;

import 'dart:async';
import 'dart:io';

import 'package:glob/glob.dart';
import 'package:path/path.dart' as pathLib;
import 'package:sass/sass.dart' as sass;
import 'package:tuple/tuple.dart';
import 'package:watcher/watcher.dart';

part './compile_result.dart';
part './compiler.dart';

class SassWatcher {
  final String _path;
  final Compiler _compileRunner;
  final Ignores _ignores;

  factory SassWatcher(String path, {List<String> ignores}) {
    final i = new Ignores(ignores);
    return new SassWatcher._(path, new Compiler(path, i), i);
  }

  SassWatcher._(this._path, this._compileRunner, this._ignores);

  Future run() async {
    await _compileRunner.run();

    final watcher = new DirectoryWatcher(pathLib.canonicalize(_path));
    print('Watching scss file changes...');
    watcher.events.listen((WatchEvent event) async {
      if (_isSassFile(event.path) && _ignores.isTarget(event.path)) {
        await _compileRunner.run();
        print('Watching scss file changes...');
      }
    });
  }

  bool _isSassFile(String basename) {
    return basename.endsWith('.scss');
  }
}
