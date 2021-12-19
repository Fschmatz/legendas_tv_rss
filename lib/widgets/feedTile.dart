import 'package:flutter/material.dart';
import 'package:legendas_tv_rss/classes/feed.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedTile extends StatefulWidget {
  @override
  _FeedTileState createState() => _FeedTileState();

  Feed feed;

  FeedTile({Key? key, required this.feed}) : super(key: key);
}

class _FeedTileState extends State<FeedTile> {

  //URL LAUNCHER
  _launchBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(16, 7, 16, 7),
      onTap: () {
        _launchBrowser(widget.feed.link);
      },
      title:Text(
        widget.feed.title,
        style: TextStyle(fontSize: 16),
      ),
      trailing:Container(
        width: 55,
        child: TextButton(
          onPressed: () {
            Share.share(widget.feed.link);
          },
          child: Icon(
            Icons.share_outlined,
            size: 20,
            color: Theme.of(context)
                .textTheme
                .headline6!
                .color!
                .withOpacity(0.6),
          ),
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: Theme.of(context).cardTheme.color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
      ),
    );
  }
}
