import 'dart:convert';
import 'package:marvel_super_hero_app/models/missions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MissionService {
  static const String _missionsKey = "missions";
  static const String _energyKey = "energyLevels";

  static Future<void> saveMissions(
      Map<String, List<Mission>> missionsBySuperhero) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, String> encodedData = {};

    missionsBySuperhero.forEach((superheroId, missions) {
      encodedData[superheroId] =
          jsonEncode(missions.map((m) => m.toJson()).toList());
    });

    await prefs.setString(_missionsKey, jsonEncode(encodedData));
  }

  static Future<Map<String, List<Mission>>> loadMissions() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_missionsKey);

    if (data == null) return {};

    Map<String, dynamic> decodedData = jsonDecode(data);
    Map<String, List<Mission>> missionsBySuperhero = {};

    decodedData.forEach((superheroId, missionList) {
      List<dynamic> missionsJson = jsonDecode(missionList);
      missionsBySuperhero[superheroId] =
          missionsJson.map((m) => Mission.fromJson(m)).toList();
    });

    return missionsBySuperhero;
  }

  static Future<void> saveEnergyLevels(Map<String, int> energyLevels) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_energyKey, jsonEncode(energyLevels));
  }

  static Future<Map<String, int>> loadEnergyLevels() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_energyKey);

    if (data == null) return {};

    return Map<String, int>.from(jsonDecode(data));
  }
}
