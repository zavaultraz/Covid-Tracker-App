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
        title: Text(
          hospital.name ?? 'Hospital Details',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green[800],
        centerTitle: true, // Center title
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Icon(
                  FontAwesomeIcons.hospital,
                  size: 150,
                  color: Colors.green[800],
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  hospital.name ?? 'No Name',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
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
                icon: Icons.map,
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
          child: Text(
            'Contact Hospital',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[800], // Background color
            padding: const EdgeInsets.symmetric(vertical: 16.0),
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
    return ListTile(
      leading: Icon(icon, color: Colors.green[800]),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      subtitle: Text(value, style: TextStyle(fontWeight: FontWeight.w700)),
    );
  }
}
