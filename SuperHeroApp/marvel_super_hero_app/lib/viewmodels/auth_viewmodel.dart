import 'package:flutter/foundation.dart';
import 'package:marvel_super_hero_app/models/superhero.dart';

class AuthViewModel extends ChangeNotifier {
  Superhero? _selectedSuperhero;

  Superhero? get selectedSuperhero => _selectedSuperhero;

  void setSelectedSuperhero(Superhero superhero) {
    _selectedSuperhero = superhero;
    notifyListeners();
  }
}
