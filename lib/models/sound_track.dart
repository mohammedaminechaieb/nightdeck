/// A single ambient sleep sound in the mixer (e.g. rain, white noise).
/// [assetPath] points into assets/sounds/ — add the actual audio files
/// yourself (see README), they aren't something I can generate.
class SoundTrack {
  final String id;
  final String label;
  final String icon; // emoji, kept simple for v0.1
  final String assetPath;
  double volume; // 0.0 - 1.0, 0 = off/paused

  SoundTrack({
    required this.id,
    required this.label,
    required this.icon,
    required this.assetPath,
    this.volume = 0.0,
  });
}

final List<SoundTrack> defaultTracks = [
  SoundTrack(id: 'rain', label: 'Rain', icon: '🌧️', assetPath: 'sounds/rain.mp3'),
  SoundTrack(id: 'white_noise', label: 'White Noise', icon: '📻', assetPath: 'sounds/white_noise.mp3'),
  SoundTrack(id: 'ocean', label: 'Ocean Waves', icon: '🌊', assetPath: 'sounds/ocean.mp3'),
  SoundTrack(id: 'fan', label: 'Fan Hum', icon: '🌀', assetPath: 'sounds/fan.mp3'),
  SoundTrack(id: 'forest', label: 'Night Forest', icon: '🌲', assetPath: 'sounds/forest.mp3'),
];
