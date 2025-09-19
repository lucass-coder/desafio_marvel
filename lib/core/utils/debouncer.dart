import 'dart:async';
import 'dart:ui';

class Debouncer {
  final Duration duration;
  Timer? _timer;
  Debouncer({required this.duration});

  run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(duration, action);
  }

  cancel() {
    _timer?.cancel();
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}
