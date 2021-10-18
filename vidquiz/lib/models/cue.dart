class Cue {
  double progressMarker = 0.0;
  String notes = "";
  Cue(double progress, String text);
  double progress = 0.1;
  // Cue({required this.progress, required this.notes});

  Cue.fromJson(Map<dynamic, dynamic> json) {
    progress = json['progress'];
    notes = json['notes'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['progress'] = progress;
    data['notes'] = notes;
    return data;
  }
}
