import 'package:flutter/material.dart';
import 'package:legendas_tv_rss/util/changelog.dart';
import 'package:url_launcher/url_launcher.dart';

class AppInfoPage extends StatelessWidget {

  /*_launchGithub()  {
    const url = '';
    launch(url);
  }*/

  Color themeColorApp = Color(0xFFD4669D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Informações"),
          elevation: 0,
        ),
        body: ListView(children: <Widget>[
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 55,
            backgroundColor: Colors.green,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/avatar.jpg'),
            ),
          ),
          const SizedBox(height: 15),
          Center(
            child: Text(Changelog.appName +" "+ Changelog.appVersion,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: themeColorApp)),
          ),
          const SizedBox(height: 15),
          const Divider(),
          ListTile(
            leading: Icon( Icons.info_outline),
            title: Text("Dev".toUpperCase(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: themeColorApp)),
          ),
          ListTile(
            leading: SizedBox(
              height: 0.1,
            ),
            title: Text(
              "Aplicativo criado usando Flutter e a linguagem Dart, usado para teste e aprendizado.",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
         /* const Divider(),
          ListTile(
            leading: SizedBox(
              height: 0.1,
            ),
            title: Text("Source Code".toUpperCase(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: themeColorApp)),
          ),
          ListTile(
            //onTap: () {_launchGithub();},
            leading: Icon(Icons.open_in_new_outlined),
            title: Text("View on GitHub",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.blue)),
          ),*/
          const Divider(),
          ListTile(
            leading: SizedBox(
              height: 0.1,
            ),
            title: Text("Quote".toUpperCase(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: themeColorApp)),
          ),
          ListTile(
            leading: Icon(Icons.messenger_outline),
            title: Text(
              "I've seen things you people wouldn't believe.\nAttack ships on fire off the shoulder of Orion.\nI watched c-beams glitter in the dark near the Tannhäuser Gate.\nAll those moments will be lost in time, like tears in rain.\nTime to die.\n\nRoy Batty - Rutger Hauer",
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 30,)
        ]));
  }
}
