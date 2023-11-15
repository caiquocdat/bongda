import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String typeName;
  final String homeTeamName;
  final String homeTeamCrest;
  final String awayTeamName;
  final String awayTeamCrest;
  final int homeScore;
  final int awayScore;

  DetailScreen({
    required this.typeName,
    required this.homeTeamName,
    required this.homeTeamCrest,
    required this.awayTeamName,
    required this.awayTeamCrest,
    required this.homeScore,
    required this.awayScore,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          typeName,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ), // Add style if needed
        ),
        centerTitle: true, // Centers the title text in the AppBar
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF4B79A1),
              Color(0xFF283E51)
            ], // Adjust gradient colors to match your design
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Image.network(
                      homeTeamCrest,
                      width: 50,
                      height: 50,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        // Return a placeholder widget if the image fails to load
                        return Icon(Icons
                            .error); // You can also use an AssetImage as a fallback
                      },
                    ),
                    SizedBox(height: 10),
                    Text(
                      homeTeamName,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
                Text(
                  '$homeScore : $awayScore',
                  style: TextStyle(color: Colors.white, fontSize: 36),
                ),
                Column(
                  children: <Widget>[
                    Image.network(
                      awayTeamCrest,
                      width: 50,
                      height: 50,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        // Return a placeholder widget if the image fails to load
                        return Icon(Icons
                            .error); // You can also use an AssetImage as a fallback
                      },
                    ),
                    SizedBox(height: 10),
                    Text(
                      awayTeamName,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
