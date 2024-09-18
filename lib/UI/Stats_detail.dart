import 'package:flutter/material.dart';
import 'package:covid_tracker/model/Stats.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../component/piechart.dart';

class StatsDetailScreen extends StatefulWidget {
  final Region region;

  const StatsDetailScreen({super.key, required this.region});

  @override
  _StatsDetailScreenState createState() => _StatsDetailScreenState();
}

class _StatsDetailScreenState extends State<StatsDetailScreen> {
  String selectedStat = 'Infected'; // Default stat yang ditampilkan

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Bagian Header dengan 3 Lingkaran
            Container(
              decoration: BoxDecoration(
                color: Colors.green[700],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  Icon(FontAwesomeIcons.city,size: 100,color: Colors.white,),
                  SizedBox(height: 10,),
                  Text(
                    'Stats COVID ${widget.region.name}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Tiga lingkaran dengan interaksi
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatButton(
                        context,
                        icon: Icons.sick,
                        label: 'Infected',
                        color: Colors.orange,
                        value: widget.region.numbers?.infected ?? 0,
                      ),
                      _buildStatButton(
                        context,
                        icon: Icons.mood,
                        label: 'Recovered',
                        color: Colors.green,
                        value: widget.region.numbers?.recovered ?? 0,
                      ),
                      _buildStatButton(
                        context,
                        icon: Icons.sentiment_very_dissatisfied_outlined,
                        label: 'Dead',
                        color: Colors.red,
                        value: widget.region.numbers?.fatal ?? 0,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Bagian Stats Detail (menampilkan data berdasarkan stat yang dipilih)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildSelectedStatDetail(),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk membuat tombol lingkaran dengan interaksi
  Widget _buildStatButton(BuildContext context, {required IconData icon, required String label, required Color color, required int value}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedStat = label; // Mengubah stat yang ditampilkan
        });
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: Icon(icon, color: color, size: 40),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk menampilkan data berdasarkan stat yang dipilih
  Widget _buildSelectedStatDetail() {
    if (selectedStat == 'Infected') {
      return StatsDetailCard(
        icon: Icons.sick,
        color: Colors.orange,
        label: 'Infected',
        number: widget.region.numbers?.infected ?? 0,
      );
    } else if (selectedStat == 'Recovered') {
      return StatsDetailCard(
        icon: Icons.mood,
        color: Colors.green,
        label: 'Recovered',
        number: widget.region.numbers?.recovered ?? 0,
      );
    } else if (selectedStat == 'Dead') {
      return StatsDetailCard(
        icon: Icons.sentiment_very_dissatisfied_outlined,
        color: Colors.red,
        label: 'Dead',
        number: widget.region.numbers?.fatal ?? 0,
      );
    }
    return Container(); // Return kosong kalau tidak ada yang dipilih
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
            Icon(icon, color: color, size: 50),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 29,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text(
                    number.toString(),
                    style: TextStyle(
                      fontSize: 30,
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
