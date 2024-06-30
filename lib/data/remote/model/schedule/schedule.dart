import 'dart:convert';

Schedule scheduleFromJson(String str) => Schedule.fromJson(json.decode(str));

String scheduleToJson(Schedule data) => json.encode(data.toJson());

class Schedule {
  String? scheduleId;
  String? scheduleName;
  String? scheduleOnTime;
  String? scheduleOffTime;
  String? scheduleSelectedDays;
  String? macAddress;
  String? roomId;
  String? boardId;
  String? switchId;

  Schedule({
    this.scheduleId,
    this.scheduleName,
    this.scheduleOnTime,
    this.scheduleOffTime,
    this.scheduleSelectedDays,
    this.macAddress,
    this.roomId,
    this.boardId,
    this.switchId,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        scheduleId: json["schedule_id"],
        scheduleName: json["schedule_name"],
        scheduleOnTime: json["schedule_on_time"],
        scheduleOffTime: json["schedule_off_time"],
        scheduleSelectedDays: json["schedule_selected_days"],
        macAddress: json["mac_address"],
        roomId: json["room_id"],
        boardId: json["board_id"],
        switchId: json["switch_id"],
      );

  Map<String, dynamic> toJson() => {
        "schedule_id": scheduleId,
        "schedule_name": scheduleName,
        "schedule_on_time": scheduleOnTime,
        "schedule_off_time": scheduleOffTime,
        "schedule_selected_days": scheduleSelectedDays,
        "mac_address": macAddress,
        "room_id": roomId,
        "board_id": boardId,
        "switch_id": switchId,
      };
}
