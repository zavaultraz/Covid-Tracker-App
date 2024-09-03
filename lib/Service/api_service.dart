import 'dart:convert';

import '../config/config.dart';
import '../model/Hoax.dart';
import 'package:http/http.dart' as http;

import '../model/Hospital.dart';
import '../model/News.dart';
import '../model/Stats.dart';

class ApiService{
  Future<List<Hoax>?> getHoaxes() async {
    var url = Uri.parse('${baseurl}hoaxes');
    print(url);

    var response = await http.get(url);
    print(response.body);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((hoax) => Hoax.fromJson(hoax)).toList();
    } else {
      print('Request gagal dengan status ${response.statusCode}');
      return null;
    }
  }
  Future<List<Hospital>?> getHospitals() async {
    var url = Uri.parse('${baseurl}hospitals'); // Ubah endpoint sesuai dengan API Anda
    print(url);

    var response = await http.get(url);
    print(response.body);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((hospital) => Hospital.fromJson(hospital)).toList();
    } else {
      print('Request gagal dengan status ${response.statusCode}');
      return null;
    }
  }
  Future<List<News>?> getNews() async {
    var url = Uri.parse('${baseurl}news'); // Ubah endpoint sesuai dengan API Anda
    print(url);

    var response = await http.get(url);
    print(response.body);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((newsItem) => News.fromJson(newsItem)).toList();
    } else {
      print('Request gagal dengan status ${response.statusCode}');
      return null;
    }
  }

  Future<Stats?> getStats() async {
    var url = Uri.parse(
        '${baseurl}stats'); // Ubah endpoint sesuai dengan API Anda
    print(url);

    var response = await http.get(url);
    print(response.body);

    if (response.statusCode == 200) {
      // Decode JSON response dan buat objek Stats dari JSON
      return Stats.fromJson(jsonDecode(response.body));
    } else {
      print('Request gagal dengan status ${response.statusCode}');
      return null;
    }
  }
}