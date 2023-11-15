import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

import 'Standing.dart';
import 'TeamStanding.dart';

class GiaiDauScreen extends StatefulWidget {
  @override
  _GiaiDauScreenState createState() => _GiaiDauScreenState();
}

class _GiaiDauScreenState extends State<GiaiDauScreen> {
  int _selectedIndex = 0; // Initial value for no selection
  List<TeamStanding> standings = [];
  @override
  void initState() {
    super.initState();
    getLeagueStandings('PL');
  }
  void getLeagueStandings(String leagueCode) async {
    setState(() {
      // Indicate loading is in progress
      standings = []; // Clear old data
    });
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var url = Uri.parse('http://api.football-data.org/v4/competitions/$leagueCode/standings?date=$currentDate');
    var response = await http.get(
      url,
      headers: {
        'X-Auth-Token': '1043564ceb1a4609b185596b907280df',
      },
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        // Update the UI with the data when it's ready
        standings = (data['standings'][0]['table'] as List)
            .map((item) => TeamStanding.fromJson(item))
            .toList();
      });
    } else {
      // Handle the error
      print('Request failed with status: ${response.statusCode}.');
      // Optionally, set an error state and display an error message
    }
  }


  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> leagues = [
      {'name': 'PL', 'logo': 'assets/premier_league.png'},
      {'name': 'PD', 'logo': 'assets/laliga.png'},
      {'name': 'FL1', 'logo': 'assets/ligue1.png'},
      {'name': 'SA', 'logo': 'assets/serie_a.png'},
      {'name': 'DED', 'logo': 'assets/eredivisie.png'},
      {'name': 'CL', 'logo': 'assets/championleague.png'},
      {'name': 'ELC', 'logo': 'assets/europared.png'},
      {'name': 'WC', 'logo': 'assets/europagreen.png'},
    ];

    return Scaffold(
      backgroundColor: Color(0xFF181928),
      body: Padding(
        padding: EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Giải đấu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: leagues.asMap().entries.map((entry) {
                  int idx = entry.key;
                  Map<String, dynamic> league = entry.value;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = idx; // Set new selected index
                        getLeagueStandings(leagues[idx]['name']);
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 1.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _selectedIndex == idx ? Colors.white : Color(0xFF54588B),
                          width: 3, // Define the width of the border
                        ),
                      ),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(league['logo']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

            ),
            SizedBox(height: 26),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Bảng xếp hạng',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Expanded(
              child: standings.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: standings.length,
                itemBuilder: (context, index) {
                  final team = standings[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(team.crestUrl),
                    ),
                    title: Text(
                      team.name,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      'M: ${team.playedGames}  W: ${team.won}  D: ${team.draw}  L: ${team.lost}  G: ${team.goalsFor}  PTS: ${team.points}',
                      style: TextStyle(color: Colors.white70),
                    ),
                    trailing: Text(
                      '#${team.position}',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
