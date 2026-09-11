import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/amoled_theme.dart';

/// The big centered clock face. Updates every second, stays minimal on
/// purpose — this is what sits on the nightstand all night.
class ClockFace extends StatefulWidget {
  const ClockFace({super.key});

  @override
  State<ClockFace> createState() => _ClockFaceState();
}

class _ClockFaceState extends State<ClockFace> {
  late Timer _timer;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _two(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '${_two(_now.hour)}:${_two(_now.minute)}',
          style: const TextStyle(
            fontSize: 96,
            fontWeight: FontWeight.w200,
            color: AmoledTheme.primaryText,
            letterSpacing: 4,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _weekdayLabel(_now.weekday),
          style: const TextStyle(fontSize: 16, color: AmoledTheme.dimText, letterSpacing: 3),
        ),
      ],
    );
  }

  String _weekdayLabel(int weekday) {
    const labels = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
    return labels[weekday - 1];
  }
}
