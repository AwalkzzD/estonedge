import 'package:estonedge/base/screens/base_widget.dart';
import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/base/utils/widgets/custom_textfield.dart';
import 'package:estonedge/base/widgets/drop_down_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileDetailsScreen extends BaseWidget {
  const ProfileDetailsScreen({super.key});

  @override
  BaseWidgetState<BaseWidget> getState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends BaseWidgetState<ProfileDetailsScreen> {
  final TextEditingController dateController = TextEditingController();

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Profile details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hintText: 'Name',
                icon: null,
                obscureText: false,
              ),
              const SizedBox(height: 16),
              GenericDropdown(
                items: ['Male', 'Female', 'Non-Binary', 'Prefer not to answer'],
                hint: 'Gender',
                onChanged: (String? value) {
                  // Handle the selected value
                  print('Selected gender: $value');
                },
              ),
              SizedBox(height: 16),
              CustomTextField(
                hintText: 'Date',
                icon: Icons.calendar_today,
                obscureText: false,
                controller: dateController,
                onIconPressed: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
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
              SizedBox(height: 16),
              CustomTextField(
                hintText: 'New Password',
                icon: Icons.lock,
                obscureText: true,
              ),
              SizedBox(height: 16),
              CustomTextField(
                hintText: 'Confirm Password',
                icon: Icons.lock,
                obscureText: true,
              ),
              SizedBox(height: 40),
              Center(
                child: CustomButton(
                    btnText: 'Update',
                    width: 145.0,
                    color: Colors.blue,
                    onPressed: () {}),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData? icon;
  final bool obscureText;
  final TextEditingController? controller;
  final VoidCallback? onIconPressed;

  CustomTextField({
    required this.hintText,
    this.icon,
    required this.obscureText,
    this.controller,
    this.onIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
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
