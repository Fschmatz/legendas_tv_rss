import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:legendas_tv_rss/classes/feed.dart';
import 'package:legendas_tv_rss/configs/settingsPage.dart';
import 'package:legendas_tv_rss/widgets/newsTile.dart';
import 'package:webfeed/webfeed.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //FEED 20 itens
  static const String destaques = 'http://legendas.tv/rss/destaques.rss';
  static const String filmes = 'http://legendas.tv/rss/destaques_filmes.rss';
  static const String series = 'http://legendas.tv/rss/destaques_series.rss';
  static const String novidades = 'http://legendas.tv/rss/ultimas_legendas.rss';
  static const String cartoons =
      'http://legendas.tv/rss/destaques_cartoons.rss';
  String feedSelecionado = '';

  List<RssItem> articlesList = [];
  bool loading = true;

  @override
  void initState() {
    feedSelecionado = destaques;
    getRssData(feedSelecionado);
    super.initState();
  }

  Future<void> getRssData(String feedUrl) async {
    var client = http.Client();
    var response = await client.get(Uri.parse(feedUrl));
    var channel = RssFeed.parse(response.body);
    setState(() {
      articlesList = channel.items!.toList();
      loading = false;
    });
    client.close();
  }

  int _currentIndex = 0;

  /* static const TextStyle optionStyle =
  TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Destaques',
      style: optionStyle,
    ),
    Text(
      'Filmes',
      style: optionStyle,
    ),
    Text(
      'Séries',
      style: optionStyle,
    ),
    Text(
      'Cartoons',
      style: optionStyle,
    ),
    Text(
      'Novidades',
      style: optionStyle,
    ),
  ];*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Legendas.TV'),
        actions: [
          IconButton(
              icon: Icon(
                Icons.settings_outlined,
                color: Theme.of(context)
                    .textTheme
                    .headline6!
                    .color!
                    .withOpacity(0.7),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => SettingsPage(),
                      fullscreenDialog: true,
                    ));
              }),
        ],
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: loading
            ? Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).accentColor,
                ),
              )
            : RefreshIndicator(
                onRefresh: () => getRssData(feedSelecionado),
                color: Theme.of(context).accentColor,
                child: ListView(
                    physics: AlwaysScrollableScrollPhysics(),
                    children: [
                      ListView.separated(
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: articlesList.length,
                        itemBuilder: (context, index) {
                          return NewsTile(
                            feed: Feed(
                                data: articlesList[index].pubDate!.toString(),
                                title: articlesList[index].title!,
                                link: articlesList[index].link!),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ]),
              ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Theme.of(context).accentColor.withOpacity(0.4),
              hoverColor: Theme.of(context).accentColor.withOpacity(0.4),
              gap: 5,
              activeColor: Theme.of(context).accentColor,
              iconSize: 20,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor:
                  Theme.of(context).accentColor.withOpacity(0.3),
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
              tabs: [
                GButton(
                  icon: Icons.priority_high_outlined,
                  text: 'Destaques',
                ),
                GButton(
                  icon: Icons.movie_creation_outlined,
                  text: 'Filmes',
                ),
                GButton(
                  icon: Icons.tv_outlined,
                  text: 'Séries',
                ),
                GButton(
                  icon: Icons.brush_outlined,
                  text: 'Cartoons',
                ),
                GButton(
                  icon: Icons.access_time_outlined,
                  text: 'Novidades',
                ),
              ],
              selectedIndex: _currentIndex,
              onTabChange: (index) {
                setState(() {
                  loading = true;
                  _currentIndex = index;
                  if (index == 0) {
                    feedSelecionado = destaques;
                  } else if (index == 1) {
                    feedSelecionado = filmes;
                  } else if (index == 2) {
                    feedSelecionado = series;
                  } else if (index == 3) {
                    feedSelecionado = cartoons;
                  } else if (index == 4) {
                    feedSelecionado = novidades;
                  }
                });
                getRssData(feedSelecionado);
              },
            ),
          ),
        ),
      ),
    );
  }
}
