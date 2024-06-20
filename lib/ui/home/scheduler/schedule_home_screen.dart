import 'package:estonedge/base/base_bloc.dart';
import 'package:estonedge/base/base_page.dart';
import 'package:estonedge/base/constants/app_styles.dart';
import 'package:estonedge/base/src_widgets.dart';
import 'package:estonedge/ui/home/scheduler/schedule_home_screen_bloc.dart';
import 'package:flutter/material.dart';

class ScheduleHomeScreen extends BasePage {
  const ScheduleHomeScreen({super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() =>
      _ScheduleHomeScreenState();

  static Route<dynamic> route() {
    print('IN SchduleScreen');
    return CustomPageRoute(builder: (context) => const ScheduleHomeScreen());
  }
}

class _ScheduleHomeScreenState
    extends BasePageState<ScheduleHomeScreen, ScheduleHomeScreenBloc> {
  List<Map<String, dynamic>> schedules = [];
  List<String> days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  Set<int> selectedIndices = Set<int>();

  ScheduleHomeScreenBloc _bloc = ScheduleHomeScreenBloc();

  @override
  ScheduleHomeScreenBloc getBloc() => _bloc;

  @override
  void initState() {
    super.initState();
    _loadSchedules();
  }

  Future<void> _loadSchedules() async {
    schedules = await _bloc.getSchedules();
    setState(() {});
  }

  @override
  Widget? getAppBar() {
    return AppBar(
      title: Text('Schedule'),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/scheduleDetails');
            },
            icon: Icon(Icons.add))
      ],
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    return ListView.builder(
      itemCount: schedules.length,
      itemBuilder: (context, index) {
        final schedule = schedules[index];
        print('SCHEDULE : $schedule');
        // List<String> selectedDays = schedule['days'];
        return SafeArea(
          child: Card(
              elevation: 4,
              margin: EdgeInsets.fromLTRB(20, 40, 20, 0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Icon(Icons.lightbulb),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Schedule ${index + 1}',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(width: 100),
                      Text(
                        schedule['onTime'],
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 40,
                      ),
                      Text(
                        'OFF: ${schedule['offTime']}',
                        style: fs14BlackSemibold,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 35),
                    height: 50,
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: days.length,
                      itemExtent: 40, // Adjust the size of each item
                      itemBuilder: (context, index) {
                        return IconButton(
                          onPressed: () {
                            setState(() {
                              if (selectedIndices.contains(index)) {
                                selectedIndices.remove(index);
                              } else {
                                selectedIndices.add(index);
                              }
                            });
                          },
                          icon: CircleAvatar(
                            backgroundColor: days.contains(schedule['days'])
                                ? Colors.blue
                                : Colors.grey.shade400,
                            child: Text(days[index]),
                          ),
                        );
                      },
                    ),
                  )
                ],
              )),
        );
      },
    );
  }
}
