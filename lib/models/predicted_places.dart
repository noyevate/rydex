// ignore_for_file: unused_label

class PredictedPlaces {
  String? place_id;
  String? main_text;
  String? secondary_text;

  PredictedPlaces({this.place_id, this.main_text, this.secondary_text});

  // Corrected fromJson factory constructor
  factory PredictedPlaces.fromJson(Map<String, dynamic> jsonData) {
    return PredictedPlaces(
      place_id: jsonData['place_id'] as String?,
      main_text: jsonData['structured_formatting'] != null
          ? jsonData['structured_formatting']['main_text'] as String?
          : null,
      secondary_text: jsonData['structured_formatting'] != null
          ? jsonData['structured_formatting']['secondary_text'] as String?
          : null,
    );
  }
}