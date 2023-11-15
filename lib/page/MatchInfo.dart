class MatchInfo {
  DateTime utcDate;
  String typeName;
  String homeTeamName;
  String homeTeamCrest;
  String awayTeamName;
  String awayTeamCrest;
  int homeScore;
  int awayScore;

  MatchInfo({
    required this.typeName,
    required this.utcDate,
    required this.homeTeamName,
    required this.homeTeamCrest,
    required this.awayTeamName,
    required this.awayTeamCrest,
    required this.homeScore,
    required this.awayScore,
  });
}
