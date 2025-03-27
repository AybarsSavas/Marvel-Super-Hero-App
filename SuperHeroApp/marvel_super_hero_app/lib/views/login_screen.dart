import 'package:flutter/material.dart';
import 'package:marvel_super_hero_app/models/superhero.dart';
import 'package:marvel_super_hero_app/viewmodels/auth_viewmodel.dart';

import 'package:provider/provider.dart';

import '../views/home_screen.dart';

class SuperheroSelectionScreen extends StatelessWidget {
  const SuperheroSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Your Superhero to Log in"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: superheroes.length,
        itemBuilder: (context, index) {
          final superhero = superheroes[index];

          return GestureDetector(
            onTap: () {
              // Hata burada olabilir. Doğru parametreyi gönderdiğimize emin olalım
              authViewModel.setSelectedSuperhero(superhero);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      superhero.imageUrl,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    superhero.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
