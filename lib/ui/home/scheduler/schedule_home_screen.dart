import 'package:estonedge/base/base_bloc.dart';
import 'package:estonedge/base/base_page.dart';
import 'package:estonedge/base/constants/app_images.dart';
import 'package:estonedge/base/constants/app_styles.dart';
import 'package:estonedge/base/src_widgets.dart';
import 'package:estonedge/ui/home/scheduler/schedule_details_screen.dart';
import 'package:estonedge/ui/home/scheduler/schedule_home_screen_bloc.dart';
import 'package:flutter/material.dart';

import '../../../base/utils/widgets/custom_appbar.dart';

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

  Set<int> selectedIndices = <int>{};

  final ScheduleHomeScreenBloc _bloc = ScheduleHomeScreenBloc();

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
      centerTitle: true,
      backgroundColor: Colors.white,
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: Image.asset(AppImages.appBarBackIcon),
            onPressed: () {
              Navigator.of(context).pop();
            },
          );
        },
      ),
      title: CustomAppbar(
        context,
        title: 'Scheduler',
        centerTitle: true,
        titleStyle: fs24BlackSemibold,
        appBarImage: AppImages.appBarPlusIcon,
        trailingIconAction: () =>
            Navigator.push(context, ScheduleDetailsScreen.route()),
      ),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    if (schedules.isEmpty) {
      return buildNoScheduleFound();
    } else {
      return buildScheduleList();
    }
  }

  Widget buildNoScheduleFound() {
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

  Widget buildScheduleList() {
    return ListView.builder(
      itemCount: schedules.length,
      itemBuilder: (context, index) {
        final schedule = schedules[index];
        return SafeArea(
          child: GestureDetector(
            onLongPressStart: (details) {
              _longPressPosition = details.globalPosition;
            },
            onLongPress: () => _showPopupMenu(context, index),
            child: Card(
              elevation: 4,
              margin: const EdgeInsets.fromLTRB(20, 40, 20, 0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const SizedBox(width: 5),
                      const Icon(Icons.lightbulb),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Schedule ${index + 1}', style: fs24BlackBold),
                        ],
                      ),
                      const SizedBox(width: 80),
                      Text(schedule['onTime'], style: fs20BlackRegular),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 40),
                      Text(
                        'OFF: ${schedule['offTime']}',
                        style: fs14BlackRegular,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 35),
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
          title: const Text('Delete Schedule'),
          content: const Text('Are you sure you want to delete this schedule?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _deleteSchedule(index);
              },
              child: const Text('Delete'),
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
