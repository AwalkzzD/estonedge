import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:estonedge/base/src_components.dart';
import 'package:estonedge/base/src_constants.dart';
import 'package:estonedge/base/utils/widgets/divider_widget.dart';
import 'package:flutter/material.dart';

import '../../src_widgets.dart';

class CustomDropdown<T> extends StatefulWidget {
  final String hint;
  final List<T> items;
  final T? initialValue;
  final InputDecoration? decoration;
  final Function(T?) onClick;
  final bool isDisable;
  final bool isExpanded;
  final bool isDense;
  final ButtonStyleData? buttonStyleData;
  final DropdownStyleData? dropdownStyleData;
  final MenuItemStyleData? menuItemStyleData;
  final IconStyleData? iconStyleData;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? dropDownTextStyle;
  final bool showDivider;
  final bool showUnderline;
  final int maxLines;

  const CustomDropdown(
      {super.key,
      required this.hint,
      required this.items,
      this.decoration,
      this.isDisable = false,
      this.isExpanded = true,
      this.isDense = false,
      this.buttonStyleData,
      this.dropdownStyleData,
      this.menuItemStyleData,
      this.iconStyleData,
      this.textStyle,
      this.hintStyle,
      this.dropDownTextStyle,
      required this.onClick,
      this.initialValue,
      this.showDivider = false,
      this.showUnderline = false,
      this.maxLines = 2});

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  final valueListenable = ValueNotifier<T?>(null);
  double menuHeight = 48.0;

  void calculateMenuHeight() {
    var list = widget.items.map((item) {
      return item.toString();
    }).toList();
    var maxLine = maxNumberOfLines(list, 20);
    menuHeight = maxLine > 1 ? 60.0 : 48.0;
  }

  int maxNumberOfLines(List<String> strings, int charsPerLine) {
    int maxLines = 0;

    for (String text in strings) {
      int numberOfLines = (text.length / charsPerLine).ceil();
      if (numberOfLines > maxLines) {
        maxLines = numberOfLines;
      }
    }

    return maxLines;
  }

  @override
  void initState() {
    calculateMenuHeight();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.showUnderline) {
      return buildDropDown();
    } else {
      return DropdownButtonHideUnderline(
        child: buildDropDown(),
      );
    }
  }

  Widget buildDropDown() {
    return DropdownButtonFormField2<T>(
      isExpanded: widget.isExpanded,
      key: UniqueKey(),
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(0),
        border: InputBorder.none,
      ),
      isDense: widget.isDense,
      value: widget.initialValue,
      style: widget.textStyle,
      alignment: AlignmentDirectional.centerStart,
      hint: Text(widget.hint, style: widget.hintStyle ?? fs14GrayRegular),
      items: widget.items.map((item) {
        return DropdownMenuItem<T>(
          key: UniqueKey(),
          value: item,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item.toString(),
                maxLines: widget.maxLines,
                overflow: TextOverflow.ellipsis,
                style: widget.dropDownTextStyle ?? fs14BlackRegular,
              ),
              if (widget.showDivider) ...[
                SizedBox(
                  height: 6.h,
                ),
                const DividerWidget(
                  verticalMargin: 0,
                )
              ]
            ],
          ),
        );
      }).toList(),
      onChanged: widget.isDisable
          ? null
          : (value) {
              widget.onClick.call(value);
            },
      buttonStyleData: widget.buttonStyleData ??
          ButtonStyleData(
            padding: EdgeInsetsDirectional.only(end: 12.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.w),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
          ),
      iconStyleData: widget.iconStyleData ??
          const IconStyleData(
            icon: ImageView(
              image: AppImages.icDropDown,
              imageType: ImageType.asset,
            ),
          ),
      dropdownStyleData: widget.dropdownStyleData ??
          DropdownStyleData(
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10.w)),
          ),
      menuItemStyleData: widget.menuItemStyleData ??
          MenuItemStyleData(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
            height: menuHeight,
          ),
    );
  }
}
