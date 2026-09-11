import 'package:audioplayers/audioplayers.dart';
import '../models/sound_track.dart';

/// Manages one looping AudioPlayer per SoundTrack so several ambient
/// sounds can be mixed together at independent volumes (e.g. rain @ 0.6
/// + fan hum @ 0.2 at the same time).
class SoundMixerService {
  final Map<String, AudioPlayer> _players = {};

  Future<void> setVolume(SoundTrack track, double volume) async {
    track.volume = volume;
    final player = _players.putIfAbsent(track.id, () => AudioPlayer());

    if (volume <= 0) {
      await player.stop();
      return;
    }

    await player.setReleaseMode(ReleaseMode.loop);
    await player.setVolume(volume);

    if (player.state != PlayerState.playing) {
      await player.play(AssetSource(track.assetPath), volume: volume);
    }
  }

  Future<void> stopAll() async {
    for (final p in _players.values) {
      await p.stop();
    }
  }

  Future<void> dispose() async {
    for (final p in _players.values) {
      await p.dispose();
    }
    _players.clear();
  }
}
