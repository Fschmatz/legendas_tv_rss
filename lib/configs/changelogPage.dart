import 'package:flutter/material.dart';
import 'package:legendas_tv_rss/util/changelog.dart';

class ChangelogPage extends StatelessWidget {

  Color themeColorApp = Color(0xFFA590D5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Changelog"),
          elevation: 0,
        ),
        body: ListView(children: <Widget>[
          ListTile(
              leading: SizedBox(
                height: 0.1,
              ),
              title: Text("Versão Atual".toUpperCase(),
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: themeColorApp))),
          ListTile(
            leading: Icon(
              Icons.article_outlined,
            ),
            title: Text(
              Changelog.changelogCurrent,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Divider(),
          ListTile(
            leading: SizedBox(
              height: 0.1,
            ),
            title: Text("Versões Anteriores".toUpperCase(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: themeColorApp)),
          ),
          ListTile(
            leading: Icon(
              Icons.article_outlined,
            ),
            title: Text(
              Changelog.changelogsOld,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ]));
  }
}