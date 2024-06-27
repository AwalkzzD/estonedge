import 'package:estonedge/base/src_bloc.dart';
import 'package:estonedge/base/widgets/custom_page_route.dart';
import 'package:estonedge/ui/home/room/add_room/room_name/add_room_screen_bloc.dart';
import 'package:estonedge/ui/home/room/add_room/room_image/room_image_screen.dart';
import 'package:flutter/material.dart';

import '../../../../../base/src_constants.dart';
import '../../../../../base/utils/widgets/custom_button.dart';
import '../../../../../base/utils/widgets/custom_textfield.dart';
import '../../../../../utils/validators.dart';

class AddRoomScreen extends BasePage {
  const AddRoomScreen({super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() =>
      _AddRoomScreenState();

  static Route<dynamic> route() {
    return CustomPageRoute(builder: (context) => const AddRoomScreen());
  }
}

class _AddRoomScreenState
    extends BasePageState<AddRoomScreen, AddRoomScreenBloc> {
  final AddRoomScreenBloc _bloc = AddRoomScreenBloc();

  var roomNameController = TextEditingController();
  String? nameError;

  @override
  void dispose() {
    roomNameController.dispose();
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 40, 15, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Room Name', style: fs24BlackSemibold),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            controller: roomNameController,
            hintText: 'Room Name',
            icon: const Icon(Icons.house),
            isPassword: false,
            errorText: nameError,
            onChanged: (text) {
              setState(() {
                nameError = validateName(text);
              });
            },
          ),
          const SizedBox(height: 50),
          CustomButton(
            btnText: 'Continue',
            color: Colors.blueAccent,
            onPressed: () {
              setState(() {
                nameError = validateName(roomNameController.text);
              });

              if (nameError == null) {
                Navigator.of(context)
                    .push(RoomImageScreen.route(roomNameController.text));
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  AddRoomScreenBloc getBloc() => _bloc;

  @override
  Widget? getAppBar() {
    return AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Image.asset(AppImages.appBarBackIcon),
              onPressed: () {
                Navigator.of(globalContext).pop();
              },
            );
          },
        ),
        title: const Text('Add Room', style: fs24BlackBold));
  }
}
