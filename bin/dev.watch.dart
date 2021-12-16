import 'package:server/app.dart';
import 'package:watcher/watcher.dart';

void main() {
  final App app = App();
  final Watcher watcher = Watcher('lib');
  watcher.events.listen((WatchEvent event) async {
    print('${event.type} ${event.path}');
    await app.shutdown();
    app.run();
  });

  app.run();
}
