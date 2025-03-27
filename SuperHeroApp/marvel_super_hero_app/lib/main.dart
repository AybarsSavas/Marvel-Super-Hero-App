import 'package:flutter/material.dart';
import 'package:marvel_super_hero_app/viewmodels/auth_viewmodel.dart';

import 'package:provider/provider.dart';

import 'viewmodels/mission_viewmodel.dart';
import 'views/login_screen.dart';

void main() {
  runApp(const ShieldMissionsApp());
}

class ShieldMissionsApp extends StatelessWidget {
  const ShieldMissionsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => MissionViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'S.H.I.E.L.D. Missions',
        theme: ThemeData.dark(),
        home: const SuperheroSelectionScreen(),
      ),
    );
  }
}
