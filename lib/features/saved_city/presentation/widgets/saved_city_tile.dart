import 'package:flutter/material.dart';

import 'package:weatherly/features/saved_city/domain/saved_city_model.dart';

class SavedCityTile extends StatelessWidget {
  const SavedCityTile({
    super.key,
    required this.model,
    this.onDelete,
    this.onTap,
  });

  final SavedCityModel model;
  final Function()? onDelete;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor: Theme.of(context).cardColor,
      leading: Icon(Icons.location_city, color: Colors.black),
      title: Text(
        model.name ?? "",
        maxLines: 1,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: onDelete,
      ),
      subtitle: Text(
        model.lat != null && model.long != null
            ? "${model.lat}, ${model.long}"
            : "",
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
    );
  }
}
