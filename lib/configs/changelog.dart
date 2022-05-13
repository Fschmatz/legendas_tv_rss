import 'package:flutter/material.dart';
import 'package:legendas_tv_rss/util/app_details.dart';

class ChangelogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color themeColorApp = Theme.of(context).colorScheme.primary;

    return Scaffold(
        appBar: AppBar(
          title: Text("Changelog"),
        ),
        body: ListView(children: <Widget>[
          ListTile(
              title: Text("Versão Atual",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: themeColorApp))),
          ListTile(
            leading: Icon(
              Icons.article_outlined,
            ),
            title: Text(
              AppDetails.changelogCurrent,
            ),
          ),
          ListTile(
            title: Text("Versões Anteriores",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: themeColorApp)),
          ),
          ListTile(
            leading: Icon(
              Icons.article_outlined,
            ),
            title: Text(
              AppDetails.changelogsOld,
            ),
          ),
        ]));
  }
}
