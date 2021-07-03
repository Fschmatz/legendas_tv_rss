import 'package:jiffy/jiffy.dart';

class Feed {

  final String title;
  final String link;
  final String data;

  Feed({required this.title, required this.link, required this.data});

  get formattedDate{
    return Jiffy(this.data).format("dd/MM/yyyy");
  }
}