import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_chess/services/audio_service.dart';

class AudioplayersAudioService implements AudioService {
  static const volume = 0.2;

  static const Map<AudioServiceSound, String> sounds = {};

  @override
  Future<void> playSound(AudioServiceSound sound) async {
    final player = AudioPlayer()..setVolume(volume);
    var asset = '';

    switch (sound) {
      case AudioServiceSound.move:
        {
          asset = 'sound/move.wav';
          break;
        }
      case AudioServiceSound.capture:
        {
          asset = 'sound/capture.wav';
          break;
        }
      case AudioServiceSound.undo:
      case AudioServiceSound.flip:
        {
          asset = 'sound/shift.wav';
          break;
        }
    }

    await player.play(AssetSource(asset));
  }
}
