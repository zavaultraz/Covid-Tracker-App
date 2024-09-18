import 'package:flutter/material.dart';
import '../UI/Hospital_screen.dart';
import '../UI/Hoxes_screen.dart';
import '../UI/News_screen.dart';
import '../UI/Stats_screen.dart';

class SidebarMenu extends StatelessWidget {
  const SidebarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green[800],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/jon.png'),
                ),
                Flexible(
                  child: Text(
                    'Username',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    'email@example.com',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.warning),
            title: Text('Hoaxes'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HoaxesScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.local_hospital),
            title: Text('Hospitals'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HospitalScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.article),
            title: Text('News'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewsScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.bar_chart),
            title: Text('Stats'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const StatisticsScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
