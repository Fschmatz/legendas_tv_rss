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
  /*final tabs = [
    HomeBuilder(),
    ChannelList(),
    SettingsPage(),
  ];*/

  List<Widget> pageList = [];

  @override
  Widget build(BuildContext context) {

    //pageList.add(HomeBuilder());
    //pageList.add(ChannelList());
    //pageList.add(SettingsPage());

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

      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        elevation: 0.0,
        onTap: (index) {
          setState(() {
            loading = true;
            _currentIndex = index;
            if (index == 0){
              feedSelecionado = destaques;
            }else if(index == 1){
              feedSelecionado = filmes;
            }else if(index == 2){
              feedSelecionado = series;
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
        ],
      ),
    );
  }
}
