import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:legendas_tv_rss/classes/feed.dart';
import 'package:legendas_tv_rss/configs/settings.dart';
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
  List<String> feedSelecionadoSelect = [
    destaques,
    filmes,
    series,
    cartoons,
    novidades
  ];

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
    if (mounted) {
      setState(() {
        articlesList = channel.items!.toList();
        loading = false;
      });
    }
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
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: const Text('Legendas.TV'),
              pinned: false,
              floating: true,
              snap: true,
              actions: [
                IconButton(
                    icon: const Icon(
                      Icons.settings_outlined,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => SettingsPage(),
                          ));
                    }),
              ],
            ),
          ];
        },
        body: AnimatedSwitcher(
          duration: Duration(milliseconds: 600),
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
                                    child: dataTile(
                                        articlesList[index].pubDate!,
                                        context,
                                        index)),
                                Visibility(
                                    visible: dataDiferente(index),
                                    child: dataTile(
                                        articlesList[index].pubDate!,
                                        context,
                                        index)),
                                FeedTile(
                                  feed: Feed(
                                      data: articlesList[index]
                                          .pubDate!
                                          .toString(),
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
      ),
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            loading = true;
            _currentIndex = index;
            feedSelecionado = feedSelecionadoSelect[index];
          });
          getRssData(feedSelecionado);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.new_releases_outlined),
            selectedIcon: Icon(
              Icons.new_releases,
            ),
            label: 'Destaques',
          ),
          NavigationDestination(
            icon: Icon(Icons.movie_creation_outlined),
            selectedIcon: Icon(
              Icons.movie_creation,
            ),
            label: 'Filmes',
          ),
          NavigationDestination(
            icon: Icon(Icons.tv_outlined),
            selectedIcon: Icon(
              Icons.tv,
            ),
            label: 'S??ries',
          ),
          NavigationDestination(
            icon: Icon(Icons.brush_outlined),
            selectedIcon: Icon(
              Icons.brush,
            ),
            label: 'Cartoons',
          ),
          NavigationDestination(
            icon: Icon(Icons.watch_later_outlined),
            selectedIcon: Icon(
              Icons.watch_later,
            ),
            label: 'Novidades',
          ),
        ],
      ),
    );
  }
}

Widget dataTile(DateTime data, BuildContext context, int index) {
  Color corDataTile = Theme.of(context).colorScheme.primary.withOpacity(0.9);

  return Column(
    children: [
      //Visibility(visible: index != 0, child: const Divider()),
      ListTile(
        leading: Icon(
          Icons.calendar_today_outlined,
          color: corDataTile,
          size: 22,
        ),
        title: Text(
          Jiffy(data).format("dd/MM/yyyy"),
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w500, color: corDataTile),
        ),
      ),
    ],
  );
}
