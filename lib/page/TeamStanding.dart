class TeamStanding {
  int position;
  String name;
  String crestUrl;
  int playedGames;
  int won;
  int draw;
  int lost;
  int goalsFor;
  int points;

  TeamStanding({
    required this.position,
    required this.name,
    required this.crestUrl,
    required this.playedGames,
    required this.won,
    required this.draw,
    required this.lost,
    required this.goalsFor,
    required this.points,
  });

  factory TeamStanding.fromJson(Map<String, dynamic> json) {
    return TeamStanding(
      position: json['position'],
      name: json['team']['name'],
      crestUrl: json['team']['crest'],
      playedGames: json['playedGames'],
      won: json['won'],
      draw: json['draw'],
      lost: json['lost'],
      goalsFor: json['goalsFor'],
      points: json['points'],
    );
  }
}
