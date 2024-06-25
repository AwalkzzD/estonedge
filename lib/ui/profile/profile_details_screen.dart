import 'package:estonedge/base/base_bloc.dart';
import 'package:estonedge/base/base_page.dart';
import 'package:estonedge/base/components/screen_utils/flutter_screenutil.dart';
import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/base/utils/widgets/custom_dropdown.dart';
import 'package:estonedge/ui/profile/profile_details_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../base/src_constants.dart';
import '../../base/src_widgets.dart';

class ProfileDetailsScreen extends BasePage {
  const ProfileDetailsScreen({super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() =>
      _ProfileDetailsScreenState();

  static Route<dynamic> route() {
    return CustomCupertinoPageRoute(
        builder: (context) => const ProfileDetailsScreen());
  }
}

class _ProfileDetailsScreenState
    extends BasePageState<ProfileDetailsScreen, ProfileDetailsScreenBloc> {
  final ProfileDetailsScreenBloc _bloc = ProfileDetailsScreenBloc();

  final TextEditingController dateController = TextEditingController();

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

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
      title: const Text(
        overflow: TextOverflow.ellipsis,
        'Personal Details',
        style: fs24BlackBold,
      ),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Profile details',
              style: fs20BlackSemibold,
            ),
            const SizedBox(height: 16),
            const CustomTextField(
              hintText: 'Name',
              icon: null,
            ),
            const SizedBox(height: 16),
            CustomDropdown(
                hint: 'Gender',
                items: const [
                  'Male',
                  'Female',
                  'Non-Binary',
                  'Prefer not to answer'
                ],
                onClick: (value) {}),
            const SizedBox(height: 16),
            CustomTextField(
              readOnly: true,
              hintText: 'Date of Birth',
              icon: Icons.calendar_today,
              controller: dateController,
              onIconPressed: () async {
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate:
                      DateTime.now().subtract(const Duration(days: 4383)),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now().subtract(const Duration(days: 4383)),
                );
                if (selectedDate != null) {
                  String formattedDate =
                      DateFormat('dd MMMM, yyyy').format(selectedDate);
                  setState(() {
                    dateController.text = formattedDate;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            const CustomTextField(
              hintText: 'New Password',
              icon: Icons.lock,
              obscureText: true,
            ),
            const SizedBox(height: 16),
            const CustomTextField(
              hintText: 'Confirm Password',
              icon: Icons.lock,
              obscureText: true,
            ),
            const SizedBox(height: 40),
            Center(
              child: CustomButton(
                  btnText: 'Update', color: Colors.blue, onPressed: () {}),
            )
          ],
        ),
      ),
    );
  }

  @override
  ProfileDetailsScreenBloc getBloc() => _bloc;
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData? icon;
  final bool obscureText;
  final bool readOnly;
  final TextEditingController? controller;
  final VoidCallback? onIconPressed;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.icon,
    this.obscureText = false,
    this.controller,
    this.onIconPressed,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscuringCharacter: '*',
      readOnly: readOnly,
      controller: controller,
      obscureText: obscureText,
      style: fs14BlackRegular,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
        hintText: hintText,
        hintStyle: fs14GrayRegular,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(10.0),
        ),
        suffixIcon: icon != null
            ? IconButton(
                icon: Icon(icon),
                onPressed: onIconPressed,
              )
            : null,
      ),
    );
  }
}
