import 'package:estonedge/base/components/screen_utils/flutter_screenutil.dart';
import 'package:estonedge/base/src_bloc.dart';
import 'package:estonedge/base/src_constants.dart';
import 'package:estonedge/base/src_widgets.dart';
import 'package:estonedge/base/theme/app_theme.dart';
import 'package:estonedge/base/utils/common_utils.dart';
import 'package:estonedge/data/remote/model/schedule/schedule.dart';
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
  List<String> days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  final ScheduleHomeScreenBloc _bloc = ScheduleHomeScreenBloc();

  @override
  ScheduleHomeScreenBloc getBloc() => _bloc;

  @override
  void onReady() {
    getBloc().loadSchedules();
    super.onReady();
  }

  @override
  bool isRefreshEnable() {
    return true;
  }

  @override
  Future<void> onRefresh() async {
    getBloc().loadSchedules();
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
    return StreamBuilder<List<Schedule>>(
      stream: getBloc().scheduleStream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          if (snapshot.data!.isNotEmpty) {
            return buildScheduleList(snapshot.data!);
          } else {
            return buildNoScheduleFound();
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget buildNoScheduleFound() {
    return const Column(
      children: [
        //SizedBox(height: 100),
        Padding(
          padding: EdgeInsets.only(
              left: 100.0, right: 100.0, top: 200, bottom: 30.0),
          child: ImageView(
              image: AppImages.noRoomFoundImage,
              imageType: ImageType
                  .asset) /* Image(image: AssetImage(AppImages.noRoomFoundImage))*/,
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

  Widget buildScheduleList(List<Schedule> schedules) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView.separated(
        itemCount: schedules.length,
        itemBuilder: (context, index) {
          return SafeArea(
            child: GestureDetector(
              onLongPress: () =>
                  _showDeleteConfirmationDialog(context, schedules[index]),
              child: Card(
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: themeOf().primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(10)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                                Text(schedules[index].scheduleName!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: fs24BlackSemibold.copyWith(
                                        fontWeight: medium)),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'ON: ${schedules[index].scheduleOnTime}',
                                        style: fs16BlackRegular),
                                  ],
                                ),
                                Text('OFF: ${schedules[index].scheduleOffTime}',
                                    style: fs16BlackRegular)
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      SizedBox(
                        height: 50,
                        child: Expanded(
                          child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                schedules[index].scheduleSelectedDays!.length,
                            itemBuilder: (context, childIndex) {
                              return CircleAvatar(
                                backgroundColor: selectedDaysList(
                                        schedules[index]
                                            .scheduleSelectedDays!)[childIndex]
                                    ? Colors.blue
                                    : Colors.grey.shade400,
                                child: Text(days[childIndex],
                                    style: selectedDaysList(schedules[index]
                                            .scheduleSelectedDays!)[childIndex]
                                        ? fs14WhiteMedium.copyWith(
                                            fontWeight: semiBold)
                                        : fs14BlackSemibold),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(width: 5.w);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 15.h);
        },
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, Schedule schedule) {
    showCustomDialog(
      context: context,
      children: [
        ImageView(
            color: themeOf().redAccent,
            width: 80,
            height: 80,
            image: AppImages.icDelete,
            imageType: ImageType.asset),
        const SizedBox(height: 30),
        Text(
            textAlign: TextAlign.center,
            maxLines: 2,
            'Are you sure you want to delete ${schedule.scheduleName} ?',
            overflow: TextOverflow.ellipsis,
            style: fs14BlackRegular)
      ],
      buttonText: 'Delete',
      onButtonPress: () {
        getBloc().deleteSchedule(schedule, () {
          showRefreshIndicator();
          onRefresh();
          showMessageBar('${schedule.scheduleName} deleted successfully');
        }, (errorMsg) {
          showMessageBar(errorMsg);
        });
      },
    );
  }
}
