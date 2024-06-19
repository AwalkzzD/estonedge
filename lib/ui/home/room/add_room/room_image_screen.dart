import 'package:estonedge/base/base_bloc.dart';
import 'package:estonedge/base/base_page.dart';
import 'package:estonedge/ui/home/room/add_room/room_image_screen_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../base/constants/app_images.dart';
import '../../../../base/utils/widgets/custom_button.dart';

/*class SelectRoomImageScreen extends BaseWidget {
  const SelectRoomImageScreen({super.key});

  @override
  BaseWidgetState<BaseWidget> getState() => _SelectRoomImageScreenState();
}

class _SelectRoomImageScreenState
    extends BaseWidgetState<SelectRoomImageScreen> {
  final List<String> roomImages = [
    AppImages.room1,
    AppImages.room2,
    AppImages.room3,
    AppImages.room4,
    AppImages.room5,
    AppImages.room6,
  ];
  int? selectedImageIndex; // Index of the selected image

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Add Room',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
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
                        selectedImageIndex = index;
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
                        if (selectedImageIndex == index)
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
            Consumer(
              builder: (context, ref, _) {
                final roomName = ref.watch(roomNameProvider);

                return CustomButton(
                  btnText: 'Continue',
                  width: double.infinity,
                  color: Colors.blueAccent,
                  onPressed: () {
                    if (selectedImageIndex != null) {
                      final selectedImage = roomImages[selectedImageIndex!];
                      ref
                          .read(roomListProvider.notifier)
                          .addRoom(roomName, selectedImage);
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Icon(Icons.add_task),
                          content: Text('$roomName Added Successfully'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: TextButton(
                                onPressed: () {
                                  // Navigator.pushNamed(context, '/home');
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, "/home", (route) => false);
                                },
                                child: const Text('OK'),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select an image')),
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}*/

class RoomImageScreen extends BasePage {
  const RoomImageScreen({super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() =>
      _RoomImageScreenState();
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
            onPressed: () {
              if (_selectedImageIndex != null) {
                final selectedImage = roomImages[_selectedImageIndex!];
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Icon(Icons.add_task),
                    content: Text('Bedroom Added Successfully'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: TextButton(
                          onPressed: () {
                            // Navigator.pushNamed(context, '/home');
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/home", (route) => false);
                          },
                          child: const Text('OK'),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please select an image')),
                );
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