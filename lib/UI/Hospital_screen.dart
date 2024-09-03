import 'package:flutter/material.dart';
import '../Service/api_service.dart';
import '../model/Hospital.dart';
import 'Hospital_detail.dart';

class HospitalScreen extends StatefulWidget {
  const HospitalScreen({super.key});

  @override
  State<HospitalScreen> createState() => _HospitalScreenState();
}

class _HospitalScreenState extends State<HospitalScreen> {
  late Future<List<Hospital>?> hospitalFuture;
  List<Hospital>? hospitals;
  List<Hospital>? filteredHospitals;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    hospitalFuture = ApiService().getHospitals();
    hospitalFuture.then((hospitalsList) {
      setState(() {
        hospitals = hospitalsList;
        filteredHospitals = hospitalsList;
      });
    });
    _searchController.addListener(_filterHospitals);
  }

  void _filterHospitals() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (hospitals != null) {
        filteredHospitals = hospitals?.where((hospital) {
          return hospital.name!.toLowerCase().contains(query) ||
              hospital.address!.toLowerCase().contains(query) ||
              hospital.region!.toLowerCase().contains(query) ||
              hospital.province!.toLowerCase().contains(query) ||
              hospital.phone!.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterHospitals);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hospital Data', style: TextStyle(color: Colors.white, fontSize: 30)),
        backgroundColor: Colors.green[800],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search hospitals...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Hospital>?>(
              future: hospitalFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || filteredHospitals == null || filteredHospitals!.isEmpty) {
                  return const Center(child: Text('No hospitals found.'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: filteredHospitals!.length,
                  itemBuilder: (context, index) {
                    final hospital = filteredHospitals![index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16.0),
                        leading: Icon(
                          Icons.local_hospital,
                          color: Colors.green[700],
                          size: 30,
                        ),
                        title: Text(
                          hospital.name.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(
                              hospital.address.toString(),
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${hospital.region}, ${hospital.province}',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Phone: ${hospital.phone}',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HospitalDetailScreen(hospital: hospital),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
