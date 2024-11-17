import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherly/features/dashboard/presentation/search_controller.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  CustomSearchDelegate();

  // final dashboradController =

  final List<String> data = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Elderberry',
    'Fig',
    'Grape',
  ];

  // Define the search field style
  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      scaffoldBackgroundColor: const Color(0xff060720),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          // Text style of the search query
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      primaryColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xff060720),
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white),
        helperStyle: TextStyle(color: Colors.white),
        labelStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  // Show suggestions when the user types
  @override
  Widget buildSuggestions(BuildContext context) {
    // debugPrint('buildSuggestions: $query');

    return Consumer(builder: (context, ref, child) {
      final searchController =
          ref.watch(searchControllerProvider(query: query));
      return searchController.when(
        data: (suggestions) {
          return suggestions.isEmpty
              ? const Center(
                  child: Text(
                    'No Results found',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : ListView.builder(
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    final suggestion = suggestions[index];
                    return ListTile(
                      title: Text(
                        suggestion.description ?? '',
                        style: const TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        close(context, suggestion.description ?? '');
                        // showResults(context); // Show the result when an item is tapped
                      },
                    );
                  },
                );
        },
        error: (e, st) => Center(child: Text(e.toString())),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }

  // Show search results
  @override
  Widget buildResults(BuildContext context) {
    debugPrint('buildResults: $query');
    final results = data
        .where((item) => item.toLowerCase() == query.toLowerCase())
        .toList();

    return results.isNotEmpty
        ? ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('results: ${results[index]}'),
              );
            },
          )
        : const Center(
            child: Text('No results found'),
          );
  }

  // Show actions in the search bar (e.g., clear query)
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // Clear the query
        },
      ),
    ];
  }

  // Handle the back button
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, ''); // Close the search bar
      },
    );
  }
}
