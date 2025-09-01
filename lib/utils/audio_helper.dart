import 'package:flappy_bird/utils/audio_constants.dart';
import 'package:flutter_soloud/flutter_soloud.dart';

class AudioHelper {
  late  SoLoud _soLoud;
  late AudioSource _backgroundSource;
  late AudioSource _scoreSource;
  SoundHandle? _playingBackground;

  Future<void> initialize() async {
    _soLoud = SoLoud.instance;
    if (_soLoud.isInitialized) {
      return;
    }
    await _soLoud.init();
    _backgroundSource = await _soLoud.loadAsset(AudioConstants.background);
    _scoreSource = await _soLoud.loadAsset(AudioConstants.score);
  }

  void playBackgroundAudio() async {
    _playingBackground = await _soLoud.play(_backgroundSource);
    _soLoud.setProtectVoice(_playingBackground!, true);
  }

  void stopBackgroundAudio() {
    if (_playingBackground == null) {
      return;
    }
    _soLoud.fadeVolume(
      _playingBackground!,
      0.0,
      const Duration(milliseconds: 500),
    );
  }

  void playScoreCollectSound() async {
    await _soLoud.play(_scoreSource);
  }
}
