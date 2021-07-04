import 'dart:async';
import 'package:flutter/material.dart';
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
  String nomePagina = '';

  List<RssItem> articlesList = [];
  bool loading = true;

  @override
  void initState() {
    nomePagina = 'Destaques';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: 'Legendas.TV  ',
                  style: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .headline6!
                          .color!
                          .withOpacity(0.9),
                      fontSize: 19,
                      fontWeight: FontWeight.w700)),
              TextSpan(
                  text: nomePagina,
                  style: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ),
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
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        elevation: 0.0,
        onTap: (index) {
          setState(() {
            loading = true;
            _currentIndex = index;
            if (index == 0) {
              feedSelecionado = destaques;
              nomePagina = 'Destaques';
            } else if (index == 1) {
              feedSelecionado = filmes;
              nomePagina = 'Filmes';
            } else if (index == 2) {
              feedSelecionado = series;
              nomePagina = 'Séries';
            } else if (index == 3) {
              feedSelecionado = cartoons;
              nomePagina = 'Cartoons';
            } else if (index == 4) {
              feedSelecionado = novidades;
              nomePagina = 'Novidades';
            }
          });
          getRssData(feedSelecionado);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.new_releases_outlined),
            label: 'Destaques',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_creation_outlined),
            label: 'Filmes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv_outlined),
            label: 'Séries',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.brush_outlined),
            label: 'Cartoons',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time_outlined),
            label: 'Novidades',
          ),
        ],
      ),
    );
  }
}
