class Prediction {
  Prediction({
    this.description,
    this.placeId,
    this.reference,
  });
  Prediction.fromJson(Map<String, dynamic> json) {
    description = json['description']?.toString();
    placeId = json['place_id']?.toString();
    reference = json['reference']?.toString();
  }
  String? description;
  String? placeId;
  String? reference;
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['description'] = description;
    data['place_id'] = placeId;
    data['reference'] = reference;
    return data;
  }
}
