import 'package:shared_preferences/shared_preferences.dart';

class FavoriteCityStorage {
  static const _key = 'favorite_cities';

  static Future<void> addFavorite(String cityId) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteCities = prefs.getStringList(_key) ?? [];
    if (!favoriteCities.contains(cityId)) {
      favoriteCities.add(cityId);
      await prefs.setStringList(_key, favoriteCities);
    }
  }

  // Remove a city ID from favorites
  static Future<void> removeFavorite(String cityId) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteCities = prefs.getStringList(_key) ?? [];
    favoriteCities.remove(cityId);
    await prefs.setStringList(_key, favoriteCities);
  }

  // Check if a city ID is in favorites
  static Future<bool> isFavorite(String cityId) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteCities = prefs.getStringList(_key) ?? [];
    return favoriteCities.contains(cityId);
  }

  // Get all favorite city IDs
  static Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }
}
