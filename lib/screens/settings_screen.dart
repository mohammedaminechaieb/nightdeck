import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/notification_service.dart';
import '../theme/amoled_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TimeOfDay _bedtime = const TimeOfDay(hour: 22, minute: 30);
  bool _reminderEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _bedtime = TimeOfDay(
        hour: prefs.getInt('bedtime_hour') ?? 22,
        minute: prefs.getInt('bedtime_minute') ?? 30,
      );
      _reminderEnabled = prefs.getBool('reminder_enabled') ?? false;
    });
  }

  Future<void> _savePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('bedtime_hour', _bedtime.hour);
    await prefs.setInt('bedtime_minute', _bedtime.minute);
    await prefs.setBool('reminder_enabled', _reminderEnabled);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: _bedtime);
    if (picked != null) {
      setState(() => _bedtime = picked);
      await _savePrefs();
      if (_reminderEnabled) {
        await NotificationService.instance.scheduleBedtimeReminder(hour: picked.hour, minute: picked.minute);
      }
    }
  }

  Future<void> _toggleReminder(bool enabled) async {
    setState(() => _reminderEnabled = enabled);
    await _savePrefs();
    if (enabled) {
      await NotificationService.instance.scheduleBedtimeReminder(hour: _bedtime.hour, minute: _bedtime.minute);
    } else {
      await NotificationService.instance.cancelBedtimeReminder();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AmoledTheme.background,
      appBar: AppBar(backgroundColor: AmoledTheme.background, title: const Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Bedtime reminder', style: TextStyle(color: AmoledTheme.primaryText)),
            value: _reminderEnabled,
            onChanged: _toggleReminder,
            activeColor: AmoledTheme.accent,
          ),
          ListTile(
            title: const Text('Reminder time', style: TextStyle(color: AmoledTheme.primaryText)),
            subtitle: Text(_bedtime.format(context), style: const TextStyle(color: AmoledTheme.dimText)),
            onTap: _pickTime,
            enabled: _reminderEnabled,
          ),
        ],
      ),
    );
  }
}
