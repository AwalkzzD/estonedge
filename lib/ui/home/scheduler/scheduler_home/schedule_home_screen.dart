import 'package:estonedge/base/src_bloc.dart';
import 'package:estonedge/base/src_constants.dart';
import 'package:estonedge/base/src_widgets.dart';
import 'package:estonedge/ui/home/scheduler/scheduler_detaiils/schedule_details_screen.dart';
import 'package:estonedge/ui/home/scheduler/scheduler_home/schedule_home_screen_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../base/utils/widgets/custom_appbar.dart';

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
  void onReady() {
    _loadSchedules();
    super.onReady();
  }

  @override
  bool isRefreshEnable() {
    return true;
  }

  @override
  Future<void> onRefresh() async {
    return _loadSchedules();
  }

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
        titleStyle: fs24BlackBold,
        appBarTrailingImage: AppImages.appBarPlusIcon,
        trailingIconAction: () async {
          final scheduleAddedResult =
              await Navigator.push(context, ScheduleDetailsScreen.route());

          if (scheduleAddedResult != null) {
            showRefreshIndicator();
            onRefresh();
          }
        },
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
        //SizedBox(height: 100),
        Padding(
          padding: EdgeInsets.only(
              left: 100.0, right: 100.0, top: 200, bottom: 30.0),
          child: Image(image: AssetImage(AppImages.noRoomFoundImage)),
        ),
        Text(
          'No Schedules available',
          style: fs22BlackMedium,
        ),
        Text(
          'add your schedule by clicking plus(+) icon',
          style: fs16BlackRegular,
        )
      ],
    );
  }

  Widget buildScheduleList() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView.builder(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.schedule),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Schedule ${index + 1}',
                                  style: fs24BlackBold),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('OFF: ${schedule['offTime']}',
                                      style: fs14BlackRegular)
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              Text(schedule['onTime'], style: fs16BlackRegular),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                      child: Expanded(
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: days.length,
                          itemExtent: 40,
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
                                child: Text(days[index],
                                    style: days.contains(schedule['days'])
                                        ? fs14WhiteMedium.copyWith(
                                            fontWeight: semiBold)
                                        : fs14BlackSemibold),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
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
          title: Text('Delete Schedule', style: fs16BlackSemibold),
          content: const Text('Are you sure you want to delete this schedule?',
              style: fs14BlackRegular),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: fs14GrayRegular),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _deleteSchedule(index);
              },
              child: Text('Delete', style: fs14BlueRegular),
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
