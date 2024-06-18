import 'package:estonedge/base/constants/app_images.dart';
import 'package:estonedge/base/screens/base_widget.dart';
import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/ui/home/room/add_room/add_room_provider.dart';
import 'package:estonedge/ui/home/room/add_room/room_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class SelectRoomImageScreen extends BaseWidget {
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
            Text(
              'Select Room Image',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Flexible(
              child: GridView.builder(
                itemCount: 6, // Total number of containers
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 containers per row
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 0,
                  childAspectRatio: 1.3, // Adjust the aspect ratio if needed
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedImageIndex =
                            index; // Set the selected image index
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: selectedImageIndex == index
                                ? Colors.black.withOpacity(0.5)
                                : Colors.black.withOpacity(0),
                            spreadRadius: 0.8,
                            blurRadius: 8.0,
                          ),
                        ],
                      ),
                      child: Container(
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Image(
                            image: AssetImage(roomImages[index]),
                            fit: BoxFit.fill, // use this
                          ),
                        ),
                      ), 
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
                          title: Icon(Icons.add_task),
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
                                child: Text('OK'),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please select an image')),
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
}
