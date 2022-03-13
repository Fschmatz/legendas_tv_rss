import 'package:flutter/material.dart';
import 'package:legendas_tv_rss/util/app_details.dart';
import 'package:url_launcher/url_launcher.dart';

class AppInfoPage extends StatelessWidget {
  _launchGithub() {
    String url = AppDetails.repositoryLink;
    launch(url);
  }

  @override
  Widget build(BuildContext context) {
    Color themeColorApp = Theme.of(context).colorScheme.primary;

    return Scaffold(
        appBar: AppBar(
          title: Text("Informações"),
        ),
        body: ListView(children: <Widget>[
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 55,
            backgroundColor: Colors.redAccent,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/avatar.jpg'),
            ),
          ),
          const SizedBox(height: 15),
          Center(
            child: Text(AppDetails.appName + " " + AppDetails.appVersion,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: themeColorApp)),
          ),
          const SizedBox(height: 15),
          ListTile(
            title: Text("Dev",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: themeColorApp)),
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text(
              "Aplicativo criado usando Flutter e a linguagem Dart, usado para teste e aprendizado.",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          ListTile(
            title: Text("Source Code",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: themeColorApp)),
          ),
          ListTile(
            onTap: () {
              _launchGithub();
            },
            leading: Icon(Icons.open_in_new_outlined),
            title: Text("View on GitHub",
                style: TextStyle(
                    decoration: TextDecoration.underline, color: Colors.blue)),
          ),
          ListTile(
            title: Text("Quote",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: themeColorApp)),
          ),
          ListTile(
            leading: Icon(Icons.messenger_outline),
            title: Text(
              "I've seen things you people wouldn't believe.\nAttack ships on fire off the shoulder of Orion.\nI watched c-beams glitter in the dark near the Tannhäuser Gate.\nAll those moments will be lost in time, like tears in rain. Time to die.\n\nRoy Batty - Rutger Hauer",
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ]));
  }
}
