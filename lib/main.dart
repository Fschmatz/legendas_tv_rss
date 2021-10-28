import 'package:flutter/material.dart';
import 'package:legendas_tv_rss/util/theme.dart';
import 'package:provider/provider.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ChangeNotifierProvider(
    create: (_) => ThemeNotifier(),

    child: Consumer<ThemeNotifier>(
      builder:(context, ThemeNotifier notifier, child){

        return MaterialApp(
          theme: notifier.darkTheme ? dark : light,
          home: App(),
        );
      },
    ),
  )
  );
}


