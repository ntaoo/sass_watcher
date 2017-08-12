import 'package:args/args.dart';
import 'package:sass_watcher/sass_watcher.dart';

main(List<String> arguments) async {
  final parser = new ArgParser()..addOption(ArgOptions.path, defaultsTo: './');
  ArgResults argResults = parser.parse(arguments);
  final path = argResults[ArgOptions.path];
  new SassWatcher(path, ignores: ignores).run();
}

/// Ignores in a Dart project.
/// TODO: to arg options.
const List<String> ignores = const ['.pub', 'build', 'packages'];

class ArgOptions {
  static final String path = 'path';
}
