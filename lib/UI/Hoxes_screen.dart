import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Impor package url_launcher
import '../Service/api_service.dart';
import '../model/Hoax.dart';
import 'package:intl/intl.dart';

class HoxesScreen extends StatefulWidget {
  const HoxesScreen({super.key});

  @override
  State<HoxesScreen> createState() => _HoxesScreenState();
}

class _HoxesScreenState extends State<HoxesScreen> {
  late Future<List<Hoax>?> hoaxFuture;

  @override
  void initState() {
    super.initState();
    hoaxFuture = ApiService().getHoaxes();
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hoaxes News', style: TextStyle(color: Colors.white, fontSize: 30)),
        backgroundColor: Colors.green[800], // Warna sesuai dengan tema
      ),
      body: FutureBuilder<List<Hoax>?>(
        future: hoaxFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hoaxes found.'));
          }

          final hoaxes = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: hoaxes.length,
            itemBuilder: (context, index) {
              final hoax = hoaxes[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    if (hoax.url != null && hoax.url!.isNotEmpty) {
                      _launchURL(hoax.url!);
                    }
                  },
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    leading: Icon(
                      Icons.close_sharp,
                      color: Colors.red[600], // Ikon X warna merah
                      size: 40,
                    ),
                    title: Text(
                      hoax.title.toString(),
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
                            DateTime.fromMillisecondsSinceEpoch(hoax.timestamp!),
                          )}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
