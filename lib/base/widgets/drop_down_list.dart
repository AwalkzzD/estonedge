import 'package:flutter/material.dart';

class GenericDropdown<T> extends StatefulWidget {
  final List<T> items;
  final String hint;
  final ValueChanged<T?> onChanged;

  const GenericDropdown({
    super.key,
    required this.items,
    required this.hint,
    required this.onChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _GenericDropdownState<T> createState() => _GenericDropdownState<T>();
}

class _GenericDropdownState<T> extends State<GenericDropdown<T>> {
  T? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
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
      ),
      value: selectedValue,
      hint: Text(widget.hint),
      icon: const Icon(Icons.arrow_drop_down),
      items: widget.items.map<DropdownMenuItem<T>>((T value) {
        return DropdownMenuItem<T>(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
      onChanged: (T? newValue) {
        setState(() {
          selectedValue = newValue;
        });
        widget.onChanged(newValue);
      },
    );
  }
}
