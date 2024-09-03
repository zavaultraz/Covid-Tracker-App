import 'package:flutter/material.dart';
import 'package:covid_tracker/model/Stats.dart';
import '../component/piechart.dart';

class StatsDetailScreen extends StatelessWidget {
  final Region region;

  const StatsDetailScreen({super.key, required this.region});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Stats for ${region.name}',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        backgroundColor: Colors.green[800],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_city_outlined,
                    color: Colors.green[700],
                    size: 200,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.pin_drop, size: 29),
                      SizedBox(width: 10),
                      Text(
                        region.name ?? 'Province',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Text(
                'COVID Chart ${region.name!.toUpperCase()}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.green[700],
                ),
              ),

              // Pie Chart
              Container(
                height: 200, // Adjust height as needed
                child: PieChartSample2(
                  infected: region.numbers?.infected ?? 0,
                  recovered: region.numbers?.recovered ?? 0,
                  fatal: region.numbers?.fatal ?? 0,
                ),
              ),
              const SizedBox(height: 29),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'DATA COVID ${region.name!.toUpperCase()}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.green[700],
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              // Kolom statistik
              StatsDetailCard(
                icon: Icons.sick,
                color: Colors.orange,
                label: 'Infected',
                number: region.numbers?.infected ?? 0,
              ),
              const SizedBox(height: 16),
              StatsDetailCard(
                icon: Icons.mood,
                color: Colors.green,
                label: 'Recovered',
                number: region.numbers?.recovered ?? 0,
              ),
              const SizedBox(height: 16),
              StatsDetailCard(
                icon: Icons.sentiment_very_dissatisfied_outlined,
                color: Colors.red,
                label: 'Dead',
                number: region.numbers?.fatal ?? 0,
              ),
              const SizedBox(height: 32),
              // Grafik data

            ],
          ),
        ),
      ),
    );
  }
}

class StatsDetailCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final int number;

  const StatsDetailCard({
    required this.icon,
    required this.color,
    required this.label,
    required this.number,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: color, size: 36),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    number.toString(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: color,
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
