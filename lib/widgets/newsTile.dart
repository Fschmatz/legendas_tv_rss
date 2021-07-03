import 'package:flutter/material.dart';
import 'package:legendas_tv_rss/classes/feed.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsTile extends StatefulWidget {
  @override
  _NewsTileState createState() => _NewsTileState();

  Feed feed;

  NewsTile({Key? key, required this.feed}) : super(key: key);
}

class _NewsTileState extends State<NewsTile> {
  //URL LAUNCHER
  _launchBrowser(String url) async {
    if (await launch(url)) {
      await launch(url);
    } else {
      throw 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _launchBrowser(widget.feed.link);
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    widget.feed.title,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                    child: Text(
                      widget.feed.formattedDate,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color:
                              Theme.of(context).accentColor.withOpacity(0.9)),
                    ),
                  ),
                  Container(
                    width: 50,
                    child: TextButton(
                      onPressed: () {
                        Share.share(widget.feed.link);
                      },
                      child: Icon(
                        Icons.share_outlined,
                        size: 17.0,
                        color: Theme.of(context)
                            .textTheme
                            .headline6!
                            .color!
                            .withOpacity(0.7),
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Theme.of(context).cardTheme.color,
                        onPrimary: Theme.of(context).accentColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
