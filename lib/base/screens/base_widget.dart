import 'package:estonedge/base/utils/widgets/custom_progress_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseWidget extends ConsumerStatefulWidget {
  const BaseWidget({super.key});

  @override
  // ignore: no_logic_in_create_state
  BaseWidgetState createState() => getState();

  BaseWidgetState getState();
}

abstract class BaseWidgetState<T extends BaseWidget> extends ConsumerState<T> {
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
        Text("Something went wrong")
      ],
    );
  }
}
