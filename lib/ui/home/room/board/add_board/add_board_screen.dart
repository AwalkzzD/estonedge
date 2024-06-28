import 'package:estonedge/base/src_bloc.dart';
import 'package:estonedge/base/src_components.dart';
import 'package:estonedge/base/src_widgets.dart';
import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/base/utils/widgets/custom_dropdown.dart';
import 'package:estonedge/data/remote/model/board_types/board_types_response.dart';
import 'package:estonedge/ui/home/room/board/add_board/add_board_screen_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../base/src_constants.dart';

class AddBoardScreen extends BasePage {
  final String roomId;

  const AddBoardScreen({super.key, required this.roomId});

  static Route<dynamic> route(String roomId) {
    return CustomPageRoute(
        builder: (context) => AddBoardScreen(roomId: roomId));
  }

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() =>
      _AddBoardScreenState();
}

class _AddBoardScreenState
    extends BasePageState<AddBoardScreen, AddBoardScreenBloc> {
  final AddBoardScreenBloc _bloc = AddBoardScreenBloc();

  List<String> switchTypes = [];
  List<String> boardTypes = [];

  @override
  void onReady() {
    getBloc().saveRoomId(widget.roomId);
    getBloc().getBoardTypes((errorMsg) {
      showMessageBarFloating('Please ensure you are connected to internet');
    });
    super.onReady();
  }

  @override
  Widget? getAppBar() {
    return AppBar(
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
      centerTitle: true,
      backgroundColor: Colors.white,
      title: const Text(
        'Add Board',
        style: fs24BlackSemibold,
      ),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: StreamBuilder<List<BoardTypesResponse>>(
          stream: getBloc().boardTypesStream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              if (snapshot.data!.isEmpty) {
                return buildNoInternetConnection();
              } else {
                boardTypes =
                    snapshot.data!.map((board) => board.boardType).toList();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Text(
                      'Board',
                      style: fs14BlackSemibold,
                    ),
                    const SizedBox(height: 10),
                    CustomDropdown(
                        initialValue: null,
                        hint: 'Select Board Type',
                        items: boardTypes,
                        onClick: (value) {
                          getBloc().saveBoard(value!);
                          getBloc().getSwitchTypes(value);
                        }),
                    const SizedBox(height: 30),
                    Text(
                      'Switch',
                      style: fs14BlackSemibold,
                    ),
                    const SizedBox(height: 10),
                    StreamBuilder<List<SwitchType>>(
                        stream: getBloc().switchTypesStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData &&
                              snapshot.data != null &&
                              snapshot.data!.isNotEmpty) {
                            return CustomDropdown(
                                hint: 'Select Switch Type',
                                items: snapshot.data!
                                    .map((switchType) => switchType.type)
                                    .toList(),
                                onClick: (value) {
                                  getBloc().saveSwitch(value!);
                                });
                          } else {
                            return const Text('No switches for selected board',
                                style: fs14BlackRegular);
                          }
                        }),
                    const SizedBox(height: 80),
                    Center(
                      child: CustomButton(
                          btnText: 'Submit',
                          color: Colors.blue,
                          onPressed: () async {
                            getBloc().addBoard((response) {
                              showDialog<String>(
                                barrierDismissible: false,
                                context: globalContext,
                                builder: (BuildContext context) => AlertDialog(
                                  content: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const ImageView(
                                          image: AppImages.icRoomAdded,
                                          imageType: ImageType.asset),
                                      SizedBox(height: 30.h),
                                      Text('Board#${response.boardId} Added',
                                          overflow: TextOverflow.ellipsis,
                                          style: fs16BlackSemibold),
                                      SizedBox(height: 5.h),
                                      Text(
                                          'Please feel free to customize your board name...',
                                          overflow: TextOverflow.ellipsis,
                                          style: fs12BlackRegular)
                                    ],
                                  ),
                                  actions: <Widget>[
                                    CustomButton(
                                        btnText: 'Continue',
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: Colors.blueAccent,
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop<String>(
                                              context, "boardAdded");
                                          /*Navigator.pushAndRemoveUntil(
                                              context,
                                              RoomDetailsScreen.route(null),
                                              (route) => false);*/
                                        })
                                  ],
                                ),
                              );
                            }, (errorMsg) {
                              showMessageBar(errorMsg);
                            });
                          }),
                    )
                  ],
                );
              }
            } else {
              return const SizedBox();
            }
          }),
    );
  }

  @override
  AddBoardScreenBloc getBloc() => _bloc;

  Widget buildNoInternetConnection() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AppImages.noInternet),
          const Text(
            'Whoops!',
            style: fs24BlackSemibold,
          ),
          Text(
            ' Something went wrong. Check your ',
            style: fs16BlackRegular,
          ),
          Text(
            'connection or try again.',
            style: fs16BlackRegular,
          )
        ],
      ),
    );
  }
}
