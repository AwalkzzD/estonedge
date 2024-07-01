import 'package:estonedge/base/src_bloc.dart';
import 'package:estonedge/base/src_components.dart';
import 'package:estonedge/base/src_utils.dart';
import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/base/utils/widgets/custom_dropdown.dart';
import 'package:estonedge/base/widgets/custom_page_route.dart';
import 'package:estonedge/data/remote/model/rooms/get_rooms/rooms_response.dart';
import 'package:estonedge/data/remote/model/user/user_response.dart'
    as user_response;
import 'package:estonedge/ui/home/scheduler/scheduler_detaiils/schedule_details_screen_bloc.dart';
import 'package:estonedge/ui/home/scheduler/scheduler_time/schedule_time_screen.dart';
import 'package:flutter/material.dart';

import '../../../../base/src_constants.dart';

class ScheduleDetailsScreen extends BasePage {
  const ScheduleDetailsScreen({super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() =>
      _ScheduleDetailsScreenState();

  static Route<dynamic> route() {
    return CustomPageRoute(builder: (context) => const ScheduleDetailsScreen());
  }
}

class _ScheduleDetailsScreenState
    extends BasePageState<ScheduleDetailsScreen, ScheduleDetailsScreenBloc> {
  final ScheduleDetailsScreenBloc _bloc = ScheduleDetailsScreenBloc();

  @override
  ScheduleDetailsScreenBloc getBloc() => _bloc;

  @override
  void onReady() {
    getBloc().getRooms();
    super.onReady();
  }

  @override
  Widget? getAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: white,
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
      title: const Text(
        overflow: TextOverflow.ellipsis,
        'Scheduler',
        style: fs24BlackBold,
      ),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
      child: Column(
        children: [
          SingleChildScrollView(
            child: StreamBuilder<List<RoomsResponse>>(
              stream: getBloc().roomListStream,
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.data != null &&
                    snapshot.data!.isNotEmpty) {
                  if(snapshot.data!.isNotEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text('Your Room*', style: fs18BlackMedium),
                        CustomDropdown(
                            maxLines: 1,
                            hint: 'Room',
                            items: snapshot.data!
                                .map((room) =>
                            '${room.roomName} - #${room.roomId}')
                                .toList(),
                            onClick: (newValue) {
                              print(newValue);
                              getBloc().selectedRoom.value = newValue;
                              getBloc().boardList.add(snapshot.data!
                                  .singleWhere((room) =>
                              '${room.roomName} - #${room.roomId}' ==
                                  newValue)
                                  .boards);
                            }),
                        SizedBox(height: 20.h),
                        const Text('Your Board*', style: fs18BlackMedium),
                        StreamBuilder<List<user_response.Board>>(
                          stream: getBloc().boardListStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData &&
                                snapshot.data != null &&
                                snapshot.data!.isNotEmpty) {
                              return CustomDropdown(
                                  maxLines: 1,
                                  hint: 'Board',
                                  items: snapshot.data!
                                      .map((board) =>
                                  '${board.boardName} - #${board.boardId}')
                                      .toList(),
                                  onClick: (newValue) {
                                    print(newValue);
                                    getBloc().selectedBoard.value = newValue;
                                    getBloc().switchList.add(snapshot.data!
                                        .singleWhere((board) =>
                                    '${board.boardName} - #${board.boardId}' ==
                                        newValue)
                                        .switches);
                                  });
                            } else {
                              return const Text('No boards selected yet',
                                  style: fs12BlackRegular);
                            }
                          },
                        ),
                        SizedBox(height: 20.h),
                        const Text('Your Switch*', style: fs18BlackMedium),
                        StreamBuilder<List<user_response.Switch>>(
                          stream: getBloc().switchListStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData &&
                                snapshot.data != null &&
                                snapshot.data!.isNotEmpty) {
                              return CustomDropdown(
                                maxLines: 1,
                                hint: 'Switch',
                                items: snapshot.data!
                                    .map((switchX) =>
                                '${switchX.switchName} - #${switchX.switchId}')
                                    .toList(),
                                onClick: (newValue) {
                                  getBloc().selectedSwitch.value = newValue;
                                },
                              );
                            } else {
                              return const Text('No switches selected yet',
                                  style: fs12BlackRegular);
                            }
                          },
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: Text('Please add room before continuing...',
                          style: fs16BlackRegular),
                    );
                  }
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
          const Spacer(),
          CustomButton(
            btnText: 'Select',
            color: Colors.blue,
            onPressed: () {
              getBloc().checkSchedule((roomId, boardId, switchId, macAddress) {
                Navigator.push(
                    context,
                    ScheduleTimeScreen.route(
                        roomId, boardId, switchId, macAddress));
                showMessageBar(
                    'Creating schedule for ${removeIdFromString(switchId)} of ${removeIdFromString(boardId)} in ${removeIdFromString(roomId)}\n');
              }, (errorMsg) {
                showMessageBar(errorMsg);
              });
            },
          ),
          CustomButton(
            btnText: 'Cancel',
            color: Colors.grey,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
