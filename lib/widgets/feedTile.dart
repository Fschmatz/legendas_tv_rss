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

  _launchBrowser(String url) async {
    launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 5),
      onTap: () {
        _launchBrowser(widget.feed.link);
      },
      onLongPress: () {
        Share.share(widget.feed.link);
      },
      title:Text(
        widget.feed.title,
        style: TextStyle(fontSize: 16),
      ),

    );
  }
}
