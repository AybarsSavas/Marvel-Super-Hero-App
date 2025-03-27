import 'package:flutter/foundation.dart';
import 'package:marvel_super_hero_app/models/missions.dart';
import 'package:marvel_super_hero_app/services/mission_service.dart';

class MissionViewModel extends ChangeNotifier {
  final Map<String, List<Mission>> _missionsBySuperhero = {};
  final Map<String, int> _energyLevels = {};

  ThreatLevel selectedThreatLevel = ThreatLevel.low;

  MissionViewModel() {
    _loadData();
  }

  List<Mission> getMissions(String superheroId) {
    return _missionsBySuperhero[superheroId] ?? [];
  }

  int getEnergyLevel(String superheroId) {
    return _energyLevels[superheroId] ?? 100;
  }

  int getIncompleteMissionsCount(String superheroId) {
    final missions = _missionsBySuperhero[superheroId] ?? [];
    return missions
        .where((mission) => mission.status != MissionStatus.completed)
        .length;
  }

  void addMission(String superheroId, Mission mission) {
    if (!_missionsBySuperhero.containsKey(superheroId)) {
      _missionsBySuperhero[superheroId] = [];
      _energyLevels[superheroId] = 100;
    }

    _missionsBySuperhero[superheroId]!.add(mission);
    _decreaseEnergy(superheroId);
    _saveData();
  }

  void setSelectedThreatLevel(ThreatLevel level) {
    selectedThreatLevel = level;
    notifyListeners();
  }

  void completeMission(String superheroId, int index) {
    if (_missionsBySuperhero.containsKey(superheroId) &&
        index < _missionsBySuperhero[superheroId]!.length) {
      if (_missionsBySuperhero[superheroId]![index].status ==
          MissionStatus.completed) {
        return;
      }
      _missionsBySuperhero[superheroId]![index].status =
          MissionStatus.completed;
      _increaseEnergy(superheroId);
      _saveData();
    }
  }

  void deleteMission(String superheroId, int index) {
    if (_missionsBySuperhero.containsKey(superheroId) &&
        index < _missionsBySuperhero[superheroId]!.length) {
      _missionsBySuperhero[superheroId]!.removeAt(index);
      _saveData();
    }
  }

  void updateMission(String superheroId, int index, Mission updatedMission) {
    if (_missionsBySuperhero.containsKey(superheroId) &&
        index < _missionsBySuperhero[superheroId]!.length) {
      _missionsBySuperhero[superheroId]![index] = updatedMission;
      _saveData();
    }
  }

  void _decreaseEnergy(String superheroId) {
    _energyLevels[superheroId] =
        (_energyLevels[superheroId]! - 10).clamp(0, 100);
    _saveData();
  }

  void _increaseEnergy(String superheroId) {
    _energyLevels[superheroId] =
        (_energyLevels[superheroId]! + 10).clamp(0, 100);
    _saveData();
  }

  Future<void> _saveData() async {
    await MissionService.saveMissions(_missionsBySuperhero);
    await MissionService.saveEnergyLevels(_energyLevels);
    notifyListeners();
  }

  Future<void> _loadData() async {
    _missionsBySuperhero.addAll(await MissionService.loadMissions());
    _energyLevels.addAll(await MissionService.loadEnergyLevels());
    notifyListeners();
  }

  bool shouldShowNickFuryCall(String superheroId) {
    return (_missionsBySuperhero[superheroId]?.length ?? 0) >= 5;
  }
}
