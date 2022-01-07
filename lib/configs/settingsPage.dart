import 'package:flutter/material.dart';
import 'package:legendas_tv_rss/util/changelog.dart';
import 'package:legendas_tv_rss/util/theme.dart';
import 'package:provider/provider.dart';

import 'appInfoPage.dart';
import 'changelogPage.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();

  SettingsPage({Key? key}) : super(key: key);
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Color themeColorApp = Theme.of(context).colorScheme.primary;

    return Scaffold(
        appBar: AppBar(
          title: Text("Configurações"),
        ),
        body: ListView(
          children: <Widget>[
            Card(
              elevation: 1,
              margin: const EdgeInsets.fromLTRB(16, 20, 16, 25),
              color: themeColorApp,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: ListTile(
                title: Text(
                  Changelog.appName + " " + Changelog.appVersion,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17.5, color: Colors.black),
                ),
              ),
            ),
            const Divider(),
            ListTile(
              leading: SizedBox(height: 0.1,),
              title:    Text(
                  "Sobre".toUpperCase(),
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: themeColorApp)
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.info_outline,
              ),
              title: Text(
                "Informações",
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => AppInfoPage(),
                      fullscreenDialog: true,
                    ));
              },
            ),
            const SizedBox(
              height: 10.0,
            ),
            ListTile(
              leading: Icon(
                Icons.article_outlined,
              ),
              title: Text(
                "Changelog",
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => ChangelogPage(),
                      fullscreenDialog: true,
                    ));
              },
            ),
            const Divider(),
            ListTile(
              leading: SizedBox(height: 0.1,),
              title:    Text(
                  "Geral".toUpperCase(),
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: themeColorApp)
              ),
            ),
            Consumer<ThemeNotifier>(
              builder: (context, notifier, child) => SwitchListTile(
                  title: Text(
                    "Tema Escuro",
                    style: TextStyle(fontSize: 16),
                  ),
                  secondary: Icon(Icons.brightness_6_outlined),
                  activeColor: Colors.blue,
                  value: notifier.darkTheme,
                  onChanged: (value) {
                    notifier.toggleTheme();
                  }),
            ),
          ],
        ));
  }
}
