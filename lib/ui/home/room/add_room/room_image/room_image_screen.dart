import 'package:estonedge/base/constants/app_constants.dart';
import 'package:estonedge/base/src_bloc.dart';
import 'package:estonedge/base/src_constants.dart';
import 'package:estonedge/ui/home/home_screen.dart';
import 'package:estonedge/ui/home/room/add_room/room_image/room_image_screen_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../base/src_widgets.dart';
import '../../../../../base/utils/widgets/custom_button.dart';
import '../../../../../base/utils/widgets/custom_room_network_image.dart';

class RoomImageScreen extends BasePage<RoomImageScreenBloc> {
  const RoomImageScreen({this.roomName, super.key});

  final String? roomName;

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() =>
      _RoomImageScreenState();

  static Route<dynamic> route(String roomName) {
    return CustomPageRoute(
        builder: (context) => RoomImageScreen(roomName: roomName));
  }
}

class _RoomImageScreenState
    extends BasePageState<RoomImageScreen, RoomImageScreenBloc> {
  final RoomImageScreenBloc _bloc = RoomImageScreenBloc();

  int? _selectedImageIndex;

  @override
  void onReady() {
    showMessageBarFloating('Loading images! Please wait...');
    super.onReady();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Room Image',
            textAlign: TextAlign.center,
            style: fs20BlackSemibold,
          ),
          const SizedBox(
            height: 20,
          ),
          Flexible(
            child: GridView.builder(
              itemCount: roomImages.length, // Total number of containers
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 containers per row
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 1,
                childAspectRatio: 1.7, // Adjust the aspect ratio if needed
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedImageIndex = index;
                    });
                  },
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: buildCustomNetworkImage(
                              imageUrl: roomImages[index]),
                        ),
                      ),
                      if (_selectedImageIndex == index)
                        const Positioned(
                          top: 8,
                          right: 8,
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.blueAccent,
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          CustomButton(
            btnText: 'Continue',
            color: Colors.blueAccent,
            onPressed: () async {
              if (_selectedImageIndex != null) {
                getBloc().addRoom(
                    widget.roomName ?? "null", roomImages[_selectedImageIndex!],
                    (response) {
                  if (response.roomId != null) {
                    showDialog<String>(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const ImageView(
                                image: AppImages.icRoomAdded,
                                imageType: ImageType.asset),
                            const SizedBox(height: 30),
                            Text('${widget.roomName} added successfully.',
                                overflow: TextOverflow.ellipsis,
                                style: fs16BlackRegular)
                          ],
                        ),
                        actions: <Widget>[
                          CustomButton(
                              btnText: 'Continue',
                              width: MediaQuery.of(context).size.width,
                              color: Colors.blueAccent,
                              onPressed: () {
                                /*Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop<String>(
                                    context, "${widget.roomName}");*/
                                Navigator.pushAndRemoveUntil(context,
                                    HomeScreen.route(), (route) => false);
                              })
                        ],
                      ),
                    );
                  } else {
                    showDialog<String>(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const ImageView(
                                image: AppImages.icRoomAddFailed,
                                imageType: ImageType.asset),
                            const SizedBox(height: 30),
                            const Text('Unexpected Error',
                                overflow: TextOverflow.ellipsis,
                                style: fs16BlackRegular),
                            Text('${widget.roomName} was not added.',
                                overflow: TextOverflow.ellipsis,
                                style: fs14BlackRegular)
                          ],
                        ),
                        actions: <Widget>[
                          CustomButton(
                              btnText: 'Continue',
                              width: MediaQuery.of(context).size.width,
                              color: Colors.blueAccent,
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(context,
                                    HomeScreen.route(), (route) => false);
                              })
                        ],
                      ),
                    );
                  }
                }, (errorMsg) {
                  showMessageBar('Something went wrong!');
                });
              } else {
                showMessageBar('Select an image to continue');
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  RoomImageScreenBloc getBloc() => _bloc;

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
      title: const Text(
        'Add Room',
        style: fs24BlackBold,
      ),
    );
  }
}
