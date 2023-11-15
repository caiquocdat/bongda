import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'DetailScreen.dart';
import 'MatchInfo.dart';
import 'dart:math';

class TrucTiepScreen extends StatefulWidget {
  @override
  _TrucTiepScreenState createState() => _TrucTiepScreenState();
}

class _TrucTiepScreenState extends State<TrucTiepScreen> {
  List<MatchInfo> matches = [];

  @override
  void initState() {
    super.initState();
    // Call the API for a specific competition, replace 'COMPETITION_ID' with actual ID
    // gọi lấy giá trị random từ
    List<String> leagueCodes = ['PL', 'PD', 'FL1', 'SA', 'DED', 'PPL', 'ELC','ELC'];
    Random random = new Random();
    String randomLeagueCode = leagueCodes[random.nextInt(leagueCodes.length)]; // Pick a random league code
    getMatchesForCompetition(randomLeagueCode);
  }

  void getMatchesForCompetition(String competitionId) async {
    String dateTo = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String dateFrom = DateFormat('yyyy-MM-dd')
        .format(DateTime.now().subtract(Duration(days: 7)));
    var url = Uri.parse(
        'http://api.football-data.org/v4/competitions/$competitionId/matches?dateFrom=$dateFrom&dateTo=$dateTo');

    var response = await http.get(
      url,
      headers: {
        'X-Auth-Token': '1043564ceb1a4609b185596b907280df',
      },
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<MatchInfo> tempList = [];
      for (var match in data['matches']) {
        tempList.add(MatchInfo(
          typeName: match['competition']['name'],
          utcDate: DateTime.parse(match['utcDate']),
          homeTeamName: match['homeTeam']['tla'],
          homeTeamCrest: match['homeTeam']['crest'],
          awayTeamName: match['awayTeam']['tla'],
          awayTeamCrest: match['awayTeam']['crest'],
          homeScore: match['score']['fullTime']['home'],
          awayScore: match['score']['fullTime']['away'],
        ));
      }
      setState(() {
        matches = tempList;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF181928),
      // Assuming a dark theme like in the image
      body: matches.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: matches.length,
              itemBuilder: (context, index) {
                final match = matches[index];
                return InkWell(
                  onTap: () {
                    // Navigate to the new screen and pass the typeName
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(typeName: match.typeName,homeTeamName: match.homeTeamName,
                          homeTeamCrest: match.homeTeamCrest,awayTeamName: match.awayTeamName,awayTeamCrest: match.awayTeamCrest,
                        homeScore: match.homeScore,awayScore: match.awayScore),
                      ),
                    );
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Image.network(
                              match.homeTeamCrest,
                              width: 30,
                              height: 30,
                              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                // Return a placeholder widget if the image fails to load
                                return Icon(Icons.error); // You can also use an AssetImage as a fallback
                              },
                            ),
                            SizedBox(height: 10),
                            Text(
                              match.homeTeamName,
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              DateFormat('HH:mm')
                                  .format(match.utcDate), // Match time
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '${match.homeScore} - ${match.awayScore}', // Score
                              style: TextStyle(color: Colors.white, fontSize: 24),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(height: 10), // To align with the time
                            Image.network(
                              match.awayTeamCrest,
                              width: 30,
                              height: 30,
                              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                // Return a placeholder widget if the image fails to load
                                return Icon(Icons.error); // You can also use an AssetImage as a fallback
                              },
                            ),
                            SizedBox(height: 10),
                            Text(
                              match.awayTeamName,
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[800]!)),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
