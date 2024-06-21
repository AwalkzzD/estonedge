import 'package:estonedge/base/base_bloc.dart';
import 'package:estonedge/base/base_page.dart';
import 'package:estonedge/base/widgets/custom_page_route.dart';
import 'package:estonedge/base/src_constants.dart';
import 'package:estonedge/base/src_utils.dart';
import 'package:estonedge/ui/home/home_screen.dart';
import 'package:estonedge/ui/home/room/add_room/room_image_screen_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../base/src_widgets.dart';
import '../../../../base/utils/widgets/custom_button.dart';

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

  final List<String> roomImages = [
    AppImages.room1,
    AppImages.room2,
    AppImages.room3,
    AppImages.room4,
    AppImages.room5,
    AppImages.room6,
  ];
  int? _selectedImageIndex;

  @override
  Widget buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Room Image',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.bold),
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
                          child: Image(
                            image: AssetImage(roomImages[index]),
                            fit: BoxFit.fill, // use this
                          ),
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
          CustomButton(
            btnText: 'Continue',
            width: double.infinity,
            color: Colors.blueAccent,
            onPressed: () async {
              if (_selectedImageIndex != null) {
                final selectedImage = roomImages[_selectedImageIndex!];

                final imageBase64 = await getBase64File(selectedImage);

                getBloc().addRoom(widget.roomName ?? "null", 'https://tinyurl.com/mr35ddz5',
                    (response) {
                  if (response.roomId != null) {
                    showDialog<String>(
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
                            Text('${widget.roomName} Added',
                                overflow: TextOverflow.ellipsis,
                                style: fs16BlackSemibold)
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
                  } else {
                    showDialog<String>(
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
                            Text('${widget.roomName} Not Added',
                                overflow: TextOverflow.ellipsis,
                                style: fs16BlackSemibold)
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
                  print('Error ---------> $errorMsg');
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
        style: TextStyle(
            fontSize: 24, fontFamily: 'Lexend', fontWeight: FontWeight.bold),
      ),
    );
  }
}

