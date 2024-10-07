import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../model/Hospital.dart';

class HospitalDetailScreen extends StatelessWidget {
  final Hospital hospital;

  const HospitalDetailScreen({super.key, required this.hospital});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          hospital.name ?? 'Hospital Details',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green[800],  // Warna hijau utama
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green[100], // Warna latar belakang hijau lembut
                  ),
                  child: Icon(
                    FontAwesomeIcons.hospital,
                    size: 120,
                    color: Colors.green[800], // Warna ikon hijau utama
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Text(
                  hospital.name ?? 'No Name',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              _buildInfoTile(
                icon: Icons.location_on,
                title: 'Alamat',
                value: hospital.address ?? 'No Address',
              ),
              _buildInfoTile(
                icon: Icons.location_city,
                title: 'Kota',
                value: hospital.region ?? 'No Region',
              ),
              _buildInfoTile(
                icon: Icons.map_outlined,
                title: 'Provinsi',
                value: hospital.province ?? 'No Province',
              ),
              _buildInfoTile(
                icon: Icons.phone,
                title: 'Phone',
                value: hospital.phone ?? 'No Phone',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Implement the contact functionality here
          },
          child: const Text(
            'Contact Hospital',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            backgroundColor: Colors.green[800], // Warna tombol hijau gelap
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.green[800], size: 30),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.green,
          ),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}

