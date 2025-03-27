enum MissionStatus { ongoing, completed }

enum ThreatLevel { low, medium, high, worldEnding }

class Mission {
  final String name;
  final ThreatLevel threatLevel;
  MissionStatus status;
  final String superheroId;

  Mission({
    required this.name,
    required this.threatLevel,
    this.status = MissionStatus.ongoing,
    required this.superheroId,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "threatLevel": threatLevel.index,
      "status": status.index,
      "superheroId": superheroId,
    };
  }

  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
      name: json["name"],
      threatLevel: ThreatLevel.values[json["threatLevel"]],
      status: MissionStatus.values[json["status"]],
      superheroId: json["superheroId"],
    );
  }
}
