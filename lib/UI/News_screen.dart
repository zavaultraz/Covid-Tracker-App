import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Service/api_service.dart';
import '../model/News.dart';
import 'package:intl/intl.dart';



class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late Future<List<News>?> newsFuture;

  @override
  void initState() {
    super.initState();
    newsFuture = ApiService().getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News',style: TextStyle(color: Colors.white,fontSize: 30),),
        backgroundColor: Colors.green[800], // Warna sesuai dengan tema
      ),
      body: FutureBuilder<List<News>?>(
        future: newsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No news found.'));
          }

          final news = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: news.length,
            itemBuilder: (context, index) {
              final newsItem = news[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text(
                    newsItem.title.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        'Published on ${DateFormat('yyyy-MM-dd').format(
                            DateTime.fromMillisecondsSinceEpoch(newsItem.timestamp!)
                        )}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),

                    ],
                  ),
                  trailing: Icon(
                    FontAwesomeIcons.solidNewspaper,
                    color: Colors.green[700], // Ikon berita berwarna hijau
                    size: 30,
                  ),
                  onTap: () {
                    _launchURL(newsItem.url.toString());
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _launchURL(String url) {
    // Anda bisa menggunakan url_launcher untuk membuka URL di browser
    // Contoh: await launch(url);
  }
}
