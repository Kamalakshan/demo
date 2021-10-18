class SettingsModel {
  bool settingsGetreadyEnabled = true;
  bool settingsTimerEnabled = true;
  int settingsTimerDuration = 10;
  int editorTabSize = 0;
  late List<Course> course;
  String workbenchColorTheme = 'Some';

  SettingsModel(
      {required this.settingsGetreadyEnabled,
      required this.settingsTimerEnabled,
      required this.settingsTimerDuration,
      required this.editorTabSize,
      required this.course,
      required this.workbenchColorTheme});

  SettingsModel.fromJson(Map<String, dynamic> json) {
    settingsGetreadyEnabled = json['settings.getready.enabled'];
    settingsTimerEnabled = json['settings.timer.enabled'];
    settingsTimerDuration = json['settings.timer.duration'];
    editorTabSize = json['editor.tabSize'];
    if (json['Course'] != null) {
      course = <Course>[];
      json['Course'].forEach((v) {
        course.add(Course.fromJson(v));
      });
    }
    workbenchColorTheme = json['workbench.colorTheme'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['settings.getready.enabled'] = settingsGetreadyEnabled;
    data['settings.timer.enabled'] = settingsTimerEnabled;
    data['settings.timer.duration'] = settingsTimerDuration;
    data['editor.tabSize'] = editorTabSize;
    data['Course'] = course.map((v) => v.toJson()).toList();
    data['workbench.colorTheme'] = workbenchColorTheme;
    return data;
  }
}

class Course {
  String title = '';
  String url = '';
  String subtitle = '';

  Course({required this.title, required this.url, required this.subtitle});

  Course.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    url = json['url'];
    subtitle = json['subtitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = title;
    data['url'] = url;
    data['subtitle'] = subtitle;
    return data;
  }
}
