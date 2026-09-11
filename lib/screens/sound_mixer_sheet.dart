import 'package:flutter/material.dart';
import '../models/sound_track.dart';
import '../services/sound_mixer_service.dart';
import '../theme/amoled_theme.dart';

class SoundMixerSheet extends StatefulWidget {
  const SoundMixerSheet({super.key});

  @override
  State<SoundMixerSheet> createState() => _SoundMixerSheetState();
}

class _SoundMixerSheetState extends State<SoundMixerSheet> {
  final _mixer = SoundMixerService();
  final _tracks = defaultTracks;

  @override
  void dispose() {
    // Intentionally NOT stopping playback here — sounds should keep
    // playing after the sheet closes, that's the whole point of a mixer.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Sleep Sounds', style: TextStyle(color: AmoledTheme.primaryText, fontSize: 20, fontWeight: FontWeight.w300)),
          const SizedBox(height: 16),
          ..._tracks.map((track) => _trackRow(track)),
        ],
      ),
    );
  }

  Widget _trackRow(SoundTrack track) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(track.icon, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 12),
          SizedBox(
            width: 90,
            child: Text(track.label, style: const TextStyle(color: AmoledTheme.primaryText, fontSize: 13)),
          ),
          Expanded(
            child: Slider(
              value: track.volume,
              onChanged: (v) {
                setState(() => track.volume = v);
                _mixer.setVolume(track, v);
              },
            ),
          ),
        ],
      ),
    );
  }
}
