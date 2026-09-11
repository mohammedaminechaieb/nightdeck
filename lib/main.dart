import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/clock_screen.dart';
import 'services/notification_service.dart';
import 'services/home_widget_service.dart';
import 'theme/amoled_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Bedside app: force landscape-off, keep it portrait, hide system UI
  // for the true "ambient nightstand display" feel.
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  await NotificationService.instance.init();
  await HomeWidgetService.init();

  runApp(const NightDeckApp());
}

class NightDeckApp extends StatelessWidget {
  const NightDeckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NightDeck',
      debugShowCheckedModeBanner: false,
      theme: AmoledTheme.theme,
      home: const ClockScreen(),
    );
  }
}
