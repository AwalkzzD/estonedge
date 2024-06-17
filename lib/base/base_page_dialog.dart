import 'package:estonedge/base/src_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../app_bloc.dart';
import 'constants/app_colors.dart';
import 'constants/app_widgets.dart';
import 'src_bloc.dart';
import 'src_components.dart';
import 'theme/app_theme.dart';

abstract class BasePageDialog<T extends BasePageBloc?> extends StatefulWidget {
  const BasePageDialog({Key? key, this.bloc}) : super(key: key);

  final BasePageBloc? bloc;

  @override
  BasePageDialogState createState() => getDialogState();

  BasePageDialogState getDialogState();
}

abstract class BasePageDialogState<T extends BasePageDialog,
    B extends BasePageBloc> extends State<T> with WidgetsBindingObserver {
  final bool _isPaused = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  ThemeData? themeData;

  State get state => this;

  Widget buildWidget(BuildContext context);

  B getBloc();

  AppBloc? appBloc;

  AppBloc? getAppBloc({BuildContext? context}) {
    appBloc ??= BlocProvider.of<AppBloc>(context ?? globalContext);
    return appBloc;
  }

  void showRefreshIndicator() {
    _refreshKey.currentState?.show();
  }

  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    _scaffoldKey.currentState?.closeDrawer();
  }

  @override
  void initState() {
    super.initState();
    getBloc();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onReady();
    });

    var keyboardVisibilityController = KeyboardVisibilityController();

    keyboardVisibilityController.onChange.listen((bool visible) {
      if (!getBloc().isKeyboardVisible.isClosed) {
        getBloc().isKeyboardVisible.add(visible);
      }
    });
  }

  ThemeData? getThemeData() {
    return themeData;
  }

  /// Implement your code here
  void onResume() {
    // Implement your code here
  }

  /// Implement your code here
  void onReady() {
    // Implement your code here
  }

  /// Implement your code here
  void onPause() {
    // Implement your code here
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      if (!_isPaused) {
        onPause();
      }
    } else if (state == AppLifecycleState.resumed) {
      if (!_isPaused) {
        onResume();
      }
    }
  }

  bool canPop() => false;

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return BlocProvider<B>(initBloc: getBloc(), child: getCustomScaffold());
  }

  SystemUiOverlayStyle getSystemUIOverlayStyle() {
    return themeOf().uiOverlayStyleDialog();
  }

  Widget getCustomScaffold() {
    if (isRemoveScaffold()) {
      return AnnotatedRegion<SystemUiOverlayStyle>(
          value: getSystemUIOverlayStyle(),
          sized: false,
          child: buildWidget(context));
    } else {
      return AnnotatedRegion<SystemUiOverlayStyle>(
          value: getSystemUIOverlayStyle(), sized: false, child: getScaffold());
    }
  }

  Scaffold getScaffold() {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: scaffoldColor(),
      key: _scaffoldKey,
      appBar: getAppBar() as PreferredSizeWidget?,
      body: getBaseView(context),
      drawer: getDrawer(),
      floatingActionButton: buildFloatingActionButton(),
      bottomNavigationBar: getBottomNavigationBar(),
      bottomSheet: getBottomSheet(),
    );
  }

  Color scaffoldColor() {
    return themeOf().scaffoldColor;
  }

  Color progressColor() {
    return themeOf().accentColor;
  }

  Color errorTextColor() {
    return black;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  bool isRemoveScaffold() => false;

  Future<void> onRefresh() {
    return Future.value(null);
  }

  bool isRefreshEnable() => false;

  Widget getBaseStackView() {
    return StreamBuilder<int>(
        stream: getBloc().placeHolderStatusStream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            if (snapshot.data == 0) {
              return buildWidget(context);
            } else if (snapshot.data == 1) {
              return getBaseLoadingWidget();
            } else if (snapshot.data == 2) {
              return getBaseEmptyWidget();
            } else if (snapshot.data == 3) {
              return getBaseErrorWidget();
            } else {
              return buildWidget(context);
            }
          } else {
            return Container();
          }
        });
  }

  Widget getBaseView(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: isRefreshEnable()
          ? RefreshIndicator(
              key: _refreshKey,
              onRefresh: onRefresh,
              child: getBaseStackView(),
            )
          : getBaseStackView(),
    );
  }

  Widget getBaseErrorWidget() {
    return QuickView.error(
      title: getBloc().errorView.title,
      onRetry: getBloc().errorView.onRetry,
      textColor: errorTextColor(),
    );
  }

  Widget getBaseLoadingWidget() {
    return const Center(child: ProgressView());
  }

  Widget getBaseEmptyWidget() {
    return QuickView.empty(
      title: getBloc().emptyView.title,
      textColor: errorTextColor(),
    );
  }

  Widget? getBottomNavigationBar() {
    return null;
  }

  Widget? getBottomSheet() {
    return null;
  }

  Widget? getDrawer() {
    return null;
  }

  Widget? buildFloatingActionButton() {
    return null;
  }

  Widget? getAppBar() {
    return null;
  }

  void hideSoftInput() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void onBackPressed(bool didPop, BuildContext context) {
    if (didPop) {
      return;
    }
    final navigator = Navigator.of(context);
    bool value = isOTSLoading();
    if (!value) {
      navigator.pop();
    }
  }
}
