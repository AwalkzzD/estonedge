import 'package:estonedge/base/utils/widgets/custom_progress_view.dart';
import 'package:flutter/material.dart';

abstract class BaseWidget extends StatefulWidget {
  const BaseWidget({super.key});

  @override
  BaseWidgetState createState() => getState();

  BaseWidgetState getState();
}

abstract class BaseWidgetState<T extends BaseWidget> extends State<T> {
  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void hideSoftInput() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Widget getLoadingView() {
    return const CustomProgressView(progressType: ProgressType.loading);
  }

  Widget getDataEmptyView() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomProgressView(progressType: ProgressType.noData),
        Text("No Data Found"),
      ],
    );
  }

  Widget getErrorView() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomProgressView(progressType: ProgressType.error),
        Text("something went wrong")
      ],
    );
  }
}
