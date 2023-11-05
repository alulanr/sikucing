import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  Set<String> _favoriteCats = {};

  Set<String> getFavoriteCats() {
    return _favoriteCats;
  }

  void toggleFavorite(String catId) {
    if (_favoriteCats.contains(catId)) {
      _favoriteCats.remove(catId);
    } else {
      _favoriteCats.add(catId);
    }
    notifyListeners();
  }
}
