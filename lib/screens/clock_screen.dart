import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../theme/amoled_theme.dart';
import '../widgets/clock_face.dart';
import 'sound_mixer_sheet.dart';
import 'settings_screen.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({super.key});

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  @override
  void initState() {
    super.initState();
    WakelockPlus.enable(); // bedside clock should never dim/lock while foregrounded
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    super.dispose();
  }

  void _openMixer() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AmoledTheme.surface,
      isScrollControlled: true,
      builder: (_) => const SoundMixerSheet(),
    );
  }

  void _openSettings() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SettingsScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AmoledTheme.background,
      body: GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity != null && details.primaryVelocity! < -200) {
            _openMixer(); // swipe up
          }
        },
        onLongPress: _openSettings,
        child: Stack(
          children: [
            const Center(child: ClockFace()),
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Text(
                'swipe up for sounds · hold for settings',
                textAlign: TextAlign.center,
                style: TextStyle(color: AmoledTheme.dimText.withOpacity(0.6), fontSize: 11, letterSpacing: 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
