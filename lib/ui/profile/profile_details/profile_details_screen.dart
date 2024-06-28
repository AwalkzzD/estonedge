import 'package:estonedge/base/components/screen_utils/flutter_screenutil.dart';
import 'package:estonedge/base/constants/app_constants.dart';
import 'package:estonedge/base/utils/date_util.dart';
import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/base/utils/widgets/custom_dropdown.dart';
import 'package:estonedge/data/remote/model/user/user_response.dart';
import 'package:estonedge/ui/profile/profile_details/profile_details_screen_bloc.dart';
import 'package:flutter/material.dart';

import '../../../base/src_bloc.dart';
import '../../../base/src_constants.dart';
import '../../../base/src_widgets.dart';

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

  final TextEditingController contactNoController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  String? genderController;

  @override
  void dispose() {
    dobController.dispose();
    super.dispose();
  }

  @override
  void onReady() {
    getBloc().loadData();
    super.onReady();
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
          style: fs24BlackBold),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: StreamBuilder<AdditionalInfo?>(
            stream: getBloc().profileDetailsStream,
            builder: (context, snapshot) {
              contactNoController.text = snapshot.data?.contactNo ?? '';
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Profile details',
                    style: fs20BlackSemibold,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    inputType: TextInputType.phone,
                    controller: contactNoController,
                    hintText: 'Contact No',
                    icon: null,
                  ),
                  const SizedBox(height: 16),
                  StreamBuilder<String?>(
                      stream: getBloc().gender.stream,
                      builder: (context, snapshot) {
                        genderController = snapshot.data;
                        return CustomDropdown(
                            initialValue: genderController,
                            hint: 'Gender',
                            items: gendersList,
                            onClick: (value) {
                              getBloc().saveGender(value!);
                            });
                      }),
                  const SizedBox(height: 16),
                  StreamBuilder<String?>(
                      stream: getBloc().dob.stream,
                      builder: (context, snapshot) {
                        dobController.text = snapshot.data ?? '';
                        return CustomTextField(
                          readOnly: true,
                          hintText: 'Date of Birth',
                          icon: Icons.calendar_today,
                          controller: dobController,
                          onIconPressed: () async {
                            DateTime? selectedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now()
                                  .subtract(const Duration(days: 4383)),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now()
                                  .subtract(const Duration(days: 4383)),
                            );
                            if (selectedDate != null) {
                              getBloc().saveDob(SPDateUtils.format(selectedDate,
                                      SPDateUtils.FORMAT_DD_MMMM_YYYY) ??
                                  '');
                            }
                          },
                        );
                      }),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: oldPasswordController,
                    hintText: 'Old Password',
                    icon: Icons.lock,
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: newPasswordController,
                    hintText: 'New Password',
                    icon: Icons.lock,
                    obscureText: true,
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: CustomButton(
                        btnText: 'Update',
                        color: Colors.blue,
                        onPressed: () {
                          if (oldPasswordController.text.isNotEmpty) {
                            if (newPasswordController.text.isNotEmpty) {
                              getBloc().updateUserPassword(
                                  oldPasswordController.text,
                                  newPasswordController.text, (response) {
                                showMessageBar(
                                    'Password changed successfully!');
                              }, (errorMsg) async {
                                await Future.delayed(const Duration(seconds: 1),
                                    () {
                                  showMessageBar(errorMsg);
                                });
                              });
                            }
                          }
                          if (contactNoController.text.length == 10) {
                            getBloc().addAdditionalInfo(
                                contactNoController.text, (response) {
                              showMessageBar('Profile details updated');
                            }, (errorMsg) {
                              showMessageBar(errorMsg);
                            });
                          } else {
                            showMessageBar(
                                'Contact number should be 10 digits');
                          }
                        }),
                  )
                ],
              );
            }),
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
  final TextInputType inputType;
  final TextEditingController? controller;
  final VoidCallback? onIconPressed;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.icon,
    this.obscureText = false,
    this.inputType = TextInputType.text,
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
      keyboardType: inputType,
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
