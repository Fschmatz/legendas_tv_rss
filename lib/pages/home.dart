import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:legendas_tv_rss/classes/feed.dart';
import 'package:legendas_tv_rss/configs/settingsPage.dart';
import 'package:legendas_tv_rss/widgets/feedTile.dart';
import 'package:webfeed/webfeed.dart';
import 'package:jiffy/jiffy.dart';

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
  int _currentIndex = 0;
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
    var response = await client.get(Uri.parse(feedUrl)).timeout(
      const Duration(seconds: 15),
      onTimeout: () {
        throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          content: const Text('Loading Error'),
          duration: const Duration(seconds: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          action: SnackBarAction(
            label: 'RETRY',
            onPressed: () => getRssData(feedUrl),
          ),
        ));
      },
    );
    var channel = RssFeed.parse(response.body);
    setState(() {
      articlesList = channel.items!.toList();
      loading = false;
    });
    client.close();
  }

  bool dataDiferente(int index) {
    return Jiffy(articlesList[index == 0 ? index : index - 1].pubDate!)
            .format("dd/MM/yyyy") !=
        Jiffy(articlesList[index].pubDate!).format("dd/MM/yyyy");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Legendas.TV'),
        actions: [
          IconButton(
              icon: Icon(
                Icons.settings_outlined,
                color: Theme.of(context)
                    .textTheme
                    .headline6!
                    .color!
                    .withOpacity(0.8),
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
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
            : RefreshIndicator(
                onRefresh: () => getRssData(feedSelecionado),
                color: Theme.of(context).colorScheme.primary,
                child: ListView(
                    physics: AlwaysScrollableScrollPhysics(),
                    children: [
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: articlesList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Visibility(
                                  visible: index == 0,
                                  child: dataTile(articlesList[index].pubDate!,
                                      context, index)),
                              Visibility(
                                  visible: dataDiferente(index),
                                  child: dataTile(articlesList[index].pubDate!,
                                      context, index)),
                              FeedTile(
                                feed: Feed(
                                    data:
                                        articlesList[index].pubDate!.toString(),
                                    title: articlesList[index].title!,
                                    link: articlesList[index].link!),
                              ),
                            ],
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
              rippleColor: Theme.of(context).colorScheme.primary.withOpacity(0.4),
              hoverColor: Theme.of(context).colorScheme.primary.withOpacity(0.4),
              color: Theme.of(context)
                  .textTheme
                  .headline6!
                  .color!
                  .withOpacity(0.7),
              gap: 8,
              activeColor: Theme.of(context).colorScheme.primary,
              iconSize: 20,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.3),
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
                  icon: Icons.watch_later_outlined,
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

Widget dataTile(DateTime data, BuildContext context, int index) {
  Color corDataTile = Theme.of(context).colorScheme.primary.withOpacity(0.9);

  return Column(
    children: [
      Visibility(visible: index != 0, child: const Divider()),
      ListTile(
        leading: Icon(
          Icons.calendar_today_outlined,
          color: corDataTile,
          size: 22,
        ),
        title: Text(
          Jiffy(data).format("dd/MM/yyyy"),
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w700, color: corDataTile),
        ),
      ),
    ],
  );
}
