import 'package:estonedge/base/base_bloc.dart';
import 'package:estonedge/base/base_page.dart';
import 'package:estonedge/base/constants/app_images.dart';
import 'package:estonedge/base/constants/app_styles.dart';
import 'package:estonedge/base/src_widgets.dart';
import 'package:estonedge/ui/home/scheduler/schedule_details_screen.dart';
import 'package:estonedge/ui/home/scheduler/schedule_home_screen_bloc.dart';
import 'package:flutter/material.dart';

class ScheduleHomeScreen extends BasePage {
  const ScheduleHomeScreen({super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() =>
      _ScheduleHomeScreenState();

  static Route<dynamic> route() {
    return CustomPageRoute(builder: (context) => const ScheduleHomeScreen());
  }
}

class _ScheduleHomeScreenState
    extends BasePageState<ScheduleHomeScreen, ScheduleHomeScreenBloc> {
  List<Map<String, dynamic>> schedules = [];
  List<String> days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  Set<int> selectedIndices = Set<int>();

  ScheduleHomeScreenBloc _bloc = ScheduleHomeScreenBloc();

  Offset _longPressPosition = Offset.zero;

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
      backgroundColor: Colors.white,
      title: Center(
          child: Text(
        'Scheduler',
        style: fs24BlackSemibold,
      )),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(context, ScheduleDetailsScreen.route());
            },
            icon: Image.asset(AppImages.appBarPlusIcon))
      ],
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    if (schedules.isEmpty) {
      return NoScheduleFound();
    } else {
      return ScheduleList();
    }
  }

  Widget NoScheduleFound() {
    return const Column(
      children: [
        SizedBox(height: 100),
        Image(image: AssetImage(AppImages.noRoomFoundImage)),
        SizedBox(height: 30),
        Text(
          'No Schedules available',
          style: TextStyle(
              fontSize: 22, fontFamily: 'Lexend', fontWeight: FontWeight.w500),
        ),
        Text(
          'add your schedule by clicking plus(+) icon',
          style: TextStyle(fontSize: 15, fontFamily: 'Lexend'),
        )
      ],
    );
  }

  Widget ScheduleList() {
    return ListView.builder(
      itemCount: schedules.length,
      itemBuilder: (context, index) {
        final schedule = schedules[index];
        print('SCHEDULE : $schedule');
        return SafeArea(
          child: GestureDetector(
            onLongPressStart: (details) {
              _longPressPosition = details.globalPosition;
            },
            onLongPress: () => _showPopupMenu(context, index),
            child: Card(
              elevation: 4,
              margin: EdgeInsets.fromLTRB(20, 40, 20, 0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const SizedBox(width: 5),
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
              ),
            ),
          ),
        );
      },
    );
  }

  void _showPopupMenu(BuildContext context, int index) async {
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        _longPressPosition.dx,
        _longPressPosition.dy,
        _longPressPosition.dx,
        _longPressPosition.dy,
      ),
      items: [
        const PopupMenuItem(
          value: 'Edit',
          child: ListTile(
            leading: Icon(Icons.edit),
            title: Text('Edit'),
          ),
        ),
        const PopupMenuItem(
          value: 'Delete',
          child: ListTile(
            leading: Icon(Icons.delete),
            title: Text('Delete'),
          ),
        ),
      ],
    ).then((value) {
      if (value == 'Delete') {
        _showDeleteConfirmationDialog(context, index);
      }
    });
  }

  void _showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Schedule'),
          content: Text('Are you sure you want to delete this schedule?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _deleteSchedule(index);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteSchedule(int index) async {
    await _bloc.deleteSchedule(index);
    _loadSchedules();
  }
}
