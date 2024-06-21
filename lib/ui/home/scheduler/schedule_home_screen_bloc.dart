import 'package:estonedge/base/base_bloc.dart';
import 'package:estonedge/base/utils/sp_util.dart';
import 'package:estonedge/utils/shared_pref.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ScheduleHomeScreenBloc extends BasePageBloc {
  static const String keySchedules = "schedules";

  Future<void> addSchedule(Map<String, dynamic> schedule) async {
    List<Map<String, dynamic>> schedules = await getSchedules();
    schedules.add(schedule);
    await SpUtil.putString(keySchedules, jsonEncode(schedules));
  }

  Future<List<Map<String, dynamic>>> getSchedules() async {
    String? schedulesString = SpUtil.getString(keySchedules);
    if (schedulesString != null && schedulesString.isNotEmpty) {
      List<dynamic> schedulesJson = jsonDecode(schedulesString);
      return List<Map<String, dynamic>>.from(schedulesJson);
    }
    return [];
  }

  Future<void> deleteSchedule(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final schedulesString = prefs.getString('schedules') ?? '[]';
    final schedules = List<Map<String, dynamic>>.from(json.decode(schedulesString));
    schedules.removeAt(index);
    await prefs.setString('schedules', json.encode(schedules));
  }
}
