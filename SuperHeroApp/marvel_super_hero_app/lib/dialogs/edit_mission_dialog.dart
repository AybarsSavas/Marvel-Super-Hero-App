import 'package:flutter/material.dart';
import 'package:marvel_super_hero_app/models/missions.dart';
import 'package:marvel_super_hero_app/viewmodels/mission_viewmodel.dart';
import 'package:provider/provider.dart';

void editMissionDialog(
    BuildContext context, String superheroId, int missionIndex) {
  final missionViewModel =
      Provider.of<MissionViewModel>(context, listen: false);
  final TextEditingController controller = TextEditingController();

  final mission = missionViewModel.getMissions(superheroId)[missionIndex];
  controller.text = mission.name;
  ThreatLevel selectedThreatLevel = mission.threatLevel;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Edit Mission"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: "Mission Name"),
            ),
            // Consumer ile ThreatLevel'ı dinliyoruz
            Consumer<MissionViewModel>(
              builder: (context, missionViewModel, child) {
                return DropdownButton<ThreatLevel>(
                  value: selectedThreatLevel,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      selectedThreatLevel = newValue;

                      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                      missionViewModel.notifyListeners();
                    }
                  },
                  items: ThreatLevel.values.map((level) {
                    return DropdownMenuItem(
                      value: level,
                      child: Text(level.toString().split('.').last),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Eğer görev adı boş ise, snackbar gösterelim
              if (controller.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Mission cannot be empty!')),
                );
                return;
              }

              // Güncellenmiş görevi oluşturuyoruz
              final updatedMission = Mission(
                name: controller.text,
                threatLevel: selectedThreatLevel,
                superheroId: superheroId,
              );
              missionViewModel.updateMission(
                  superheroId, missionIndex, updatedMission);
              Navigator.pop(context);
            },
            child: const Text("Save Changes"),
          ),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"))
        ],
      );
    },
  );
}
