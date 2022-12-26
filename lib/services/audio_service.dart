abstract class AudioService {
  Future<void> playSound(AudioServiceSound sound);
}

enum AudioServiceSound { capture, move, undo, flip }
