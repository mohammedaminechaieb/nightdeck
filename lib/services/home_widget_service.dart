import 'package:home_widget/home_widget.dart';

/// Pushes the current time + "now playing" sound label to the native
/// widget surface via home_widget's shared storage. The actual widget
/// UI (what renders on the home/lock screen) lives in native code —
/// see native_widget_snippets/ in the project root for the Android side.
class HomeWidgetService {
  static const _appGroupId = 'group.com.nightdeck.app'; // iOS only, harmless on Android
  static const _androidWidgetProvider = 'NightDeckWidgetProvider';

  static Future<void> init() async {
    await HomeWidget.setAppGroupId(_appGroupId);
  }

  static Future<void> pushState({required String timeLabel, String? nowPlaying}) async {
    await HomeWidget.saveWidgetData<String>('time_label', timeLabel);
    await HomeWidget.saveWidgetData<String>('now_playing', nowPlaying ?? '');
    await HomeWidget.updateWidget(
      androidName: _androidWidgetProvider,
      iOSName: 'NightDeckWidget',
    );
  }
}
