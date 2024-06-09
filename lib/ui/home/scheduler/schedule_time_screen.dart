import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';

///this screen opens from ScheduleDetailsScreen's Select button.

class ScheduleTimeScreen extends StatefulWidget {
  const ScheduleTimeScreen({super.key});

  @override
  _ScheduleTimeScreenState createState() => _ScheduleTimeScreenState();
}

class _ScheduleTimeScreenState extends State<ScheduleTimeScreen> {
  TimeOfDay _onTime = const TimeOfDay(hour: 12, minute: 0);
  TimeOfDay _offTime = const TimeOfDay(hour: 12, minute: 0);

  List<String> days = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];
  List<bool> selectedDays = List.generate(7, (index) => false);

  Future<void> _selectTime(BuildContext context, bool isOnTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isOnTime ? _onTime : _offTime,
    );
    if (picked != null && picked != (isOnTime ? _onTime : _offTime)) {
      setState(() {
        if (isOnTime) {
          _onTime = picked;
        } else {
          _offTime = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            buildTimePicker("ON TIME :", _onTime, true),
            const SizedBox(height: 16.0),
            buildTimePicker("OFF TIME :", _offTime, false),
            const SizedBox(height: 40.0),
            buildDaysSelector(),
            const SizedBox(
              height: 50,
            ),
            //Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                    btnText: 'Create',
                    width: 145.0,
                    color: Colors.blueAccent,
                    onPressed: () {}),
                CustomButton(
                    btnText: 'Cancel',
                    width: 145.0,
                    color: Colors.grey,
                    onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTimePicker(String label, TimeOfDay time, bool isOnTime) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: () => _selectTime(context, isOnTime),
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              children: [
                Text(
                  time.format(context),
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8.0),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDaysSelector() {
    return Column(
      children: [
        Wrap(
          spacing: 12.0,
          runSpacing: 8.0,
          alignment: WrapAlignment.center,
          children: List.generate(7, (index) {
            return ChoiceChip(
              label: Text(days[index]),
              selected: selectedDays[index],
              onSelected: (selected) {
                setState(() {
                  selectedDays[index] = selected;
                });
              },
              selectedColor: Colors.blueAccent,
              backgroundColor: Colors.grey[300],
              labelStyle: TextStyle(
                color: selectedDays[index] ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            );
          }),
        ),
      ],
    );
  }
}
