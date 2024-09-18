import 'package:covid_tracker/UI/Stats_detail.dart';
import 'package:flutter/material.dart';
import 'package:covid_tracker/model/Stats.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Service/api_service.dart';


class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  late Future<Stats?> statsFuture;

  @override
  void initState() {
    super.initState();
    statsFuture = ApiService().getStats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text('Covid 19 Stats',style: TextStyle(color: Colors.white,fontSize: 30),),
        backgroundColor: Colors.green[800], // Warna sesuai dengan tema
      ),
      body: FutureBuilder<Stats?>(
        future: statsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data available.'));
          }

          final stats = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Text('Live Data',style: TextStyle(fontSize: 40,color: Colors.green,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              Column(
                children: [
                  StatsCard(
                    icon: Icons.sick,
                    color: Colors.orange,
                    label: 'Infected',
                    number: stats.numbers?.infected ?? 0,
                  ),
                  const SizedBox(height: 8),
                  StatsCard(
                    icon: Icons.mood,
                    color: Colors.green,
                    label: 'Recovered',
                    number: stats.numbers?.recovered ?? 0,
                  ),
                  const SizedBox(height: 8),
                  StatsCard(
                    icon: FontAwesomeIcons.skullCrossbones,
                    color: Colors.redAccent,
                    label: 'Dead',
                    number: stats.numbers?.fatal ?? 0,
                  ),
                  // Tambahkan lebih banyak StatsCard jika diperlukan
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Daerah',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: stats.regions?.length ?? 0,
                itemBuilder: (context, index) {
                  final region = stats.regions![index];
                  return RegionCard(
                    regionName: region.name!,
                    onTap: () {
                      _navigateToDetail(context, region);
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  void _navigateToDetail(BuildContext context, Region region) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StatsDetailScreen(region: region),
      ),
    );
  }
}

class StatsCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final int number;

  const StatsCard({
    required this.icon,
    required this.color,
    required this.label,
    required this.number,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color, width: 2), // Outline berwarna
      ),
      color: Colors.white, // Background putih
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: color, size: 36),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  number.toString(),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RegionCard extends StatelessWidget {
  final String regionName;
  final VoidCallback onTap;

  const RegionCard({
    required this.regionName,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: Icon(
          FontAwesomeIcons.city,
          color: Colors.green[500], // Ikon kota dengan warna teal
          size: 28,
        ),
        title: Text(
          regionName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey[600],
        ),
        onTap: onTap,
      ),
    );
  }
}
