import 'package:flutter/material.dart';
import 'package:marvel_super_hero_app/models/missions.dart';
import 'package:marvel_super_hero_app/viewmodels/mission_viewmodel.dart';
import 'package:provider/provider.dart';

void addMissionDialog(BuildContext context, String superheroId) {
  final missionViewModel =
      Provider.of<MissionViewModel>(context, listen: false);
  final TextEditingController controller = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Add Mission"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: controller,
                decoration: const InputDecoration(labelText: "Mission Name")),
            Consumer<MissionViewModel>(
              builder: (context, viewModel, child) {
                return DropdownButton<ThreatLevel>(
                  value: viewModel.selectedThreatLevel,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      missionViewModel.setSelectedThreatLevel(newValue);
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
              if (controller.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Mission name cannot be empty")),
                );
                return;
              }

              final mission = Mission(
                name: controller.text,
                threatLevel: missionViewModel.selectedThreatLevel,
                superheroId: superheroId,
              );
              missionViewModel.addMission(superheroId, mission);
              Navigator.pop(context);
            },
            child: const Text("Add Mission"),
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
