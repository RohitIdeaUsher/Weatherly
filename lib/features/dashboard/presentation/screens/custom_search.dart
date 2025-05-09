import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherly/features/dashboard/presentation/provider/search_controller.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  CustomSearchDelegate();

  @override
  Widget buildSuggestions(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final searchController = ref.watch(
          searchControllerProvider(query: query),
        );
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
                      leading: const Icon(Icons.location_city),
                      title: Text(
                        suggestion.description ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onTap: () {
                        close(context, suggestion.description ?? '');
                      },
                    );
                  },
                );
          },
          error: (e, st) => Center(child: Text(e.toString())),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }
}
