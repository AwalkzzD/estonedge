import 'dart:convert';

import 'package:day_night_time_picker/day_night_time_picker.dart';

Schedule scheduleFromJson(String str) => Schedule.fromJson(json.decode(str));

String scheduleToJson(Schedule data) => json.encode(data.toJson());

class Schedule {
  String? scheduleName;
  Time? scheduleOnTime;
  Time? scheduleOffTime;
  String? scheduleSelectedDays;

  Schedule({
    this.scheduleName,
    this.scheduleOnTime,
    this.scheduleOffTime,
    this.scheduleSelectedDays,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        scheduleName: json["schedule_name"],
        scheduleOnTime: json["schedule_on_time"],
        scheduleOffTime: json["schedule_off_time"],
        scheduleSelectedDays: json["schedule_selected_days"],
      );

  Map<String, dynamic> toJson() => {
        "schedule_name": scheduleName,
        "schedule_on_time": scheduleOnTime,
        "schedule_off_time": scheduleOffTime,
        "schedule_selected_days": scheduleSelectedDays,
      };

/*String toJson() => json.encode(
      {"schedule_name": roomId, "room_name": roomName, "room_image": roomImage});*/
}
