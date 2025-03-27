import 'package:flutter/material.dart';
import 'package:marvel_super_hero_app/dialogs/add_mission_dialog.dart';
import 'package:marvel_super_hero_app/dialogs/edit_mission_dialog.dart';
import 'package:marvel_super_hero_app/models/missions.dart';
import 'package:marvel_super_hero_app/viewmodels/auth_viewmodel.dart';
import 'package:marvel_super_hero_app/viewmodels/mission_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final missionViewModel = Provider.of<MissionViewModel>(context);

    final superhero = authViewModel.selectedSuperhero;
    if (superhero == null) {
      return const Scaffold(body: Center(child: Text("No superhero selected")));
    }

    final missions = missionViewModel.getMissions(superhero.id);
    final energyLevel = missionViewModel.getEnergyLevel(superhero.id);
    final isNickFuryCalling =
        missionViewModel.shouldShowNickFuryCall(superhero.id);

    return Scaffold(
      appBar: AppBar(title: Text("${superhero.name} Missions")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Energy: $energyLevel%",
                style: const TextStyle(fontSize: 18)),
          ),
          Image.asset(
            authViewModel.selectedSuperhero!.imageUrl,
            height: 400,
            width: 400,
            fit: BoxFit.fill,
          ),
          LinearProgressIndicator(value: energyLevel / 100),
          if (isNickFuryCalling)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "⚠️ Nick Fury is calling! Too many missions pending!",
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: missions.length,
                itemBuilder: (context, index) {
                  final mission = missions[index];
                  return ListTile(
                    title: Text(mission.name),
                    subtitle: Text(
                      "${mission.status == MissionStatus.ongoing ? "Ongoing" : "Completed"} - ${mission.threatLevel.name}",
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.check),
                          onPressed: () {
                            missionViewModel.completeMission(
                                superhero.id, index);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            editMissionDialog(
                              context,
                              superhero.id,
                              index,
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            missionViewModel.deleteMission(superhero.id, index);
                          },
                        ),
                      ],
                    ),
                    /*onLongPress: () {
                      missionViewModel.deleteMission(superhero.id, index);
                    },*/
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addMissionDialog(context, superhero.id),
        child: const Icon(Icons.add),
      ),
    );
  }
}
