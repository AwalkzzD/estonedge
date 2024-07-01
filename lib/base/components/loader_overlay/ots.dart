import 'package:estonedge/base/components/screen_utils/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/widgets/progress_view.dart';

BuildContext? getOTSContext() {
  return _tKey.currentContext;
}

bool isOTSLoading() {
  return _loaderShown;
}

final GlobalKey _tKey = GlobalKey(debugLabel: 'overlay_parent');
final _modalBarrierDefaultColor = Colors.black.withOpacity(0.35);

OverlayEntry? _loaderEntry;

bool isDarkTheme = false;

bool _loaderShown = false;

class OTS extends StatelessWidget {
  final Widget? child;
  final bool darkTheme;

  const OTS({super.key, this.child, this.darkTheme = false});

  @override
  Widget build(BuildContext context) {
    isDarkTheme = darkTheme;
    return SizedBox(
      key: _tKey,
      child: child,
    );
  }
}

OverlayState? get _overlayState {
  final context = _tKey.currentContext;
  if (context == null) return null;

  NavigatorState? navigator;
  void visitor(Element element) {
    if (navigator != null) return;

    if (element.widget is Navigator) {
      navigator = (element as StatefulElement).state as NavigatorState?;
    } else {
      element.visitChildElements(visitor);
    }
  }

  context.visitChildElements(visitor);

  assert(navigator != null,
      '''Cannot find OTS above the widget tree, unable to show overlay''');
  return navigator!.overlay;
}

Future<void> showLoader(
    {bool isModal = false,
    Color? modalColor,
    String loadingText = "",
    bool modalDismissible = true}) async {
  if(isOTSLoading()){
    return;
  }else{
    try {
      String progressText = "";
      if(loadingText.isEmpty){
        progressText = 'Loading...';
      }
      final child = Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(12.w)
          ),
          padding: EdgeInsetsDirectional.all(24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ProgressView(),
              Container(
                margin: EdgeInsetsDirectional.only(top: 20.h),
                child: Text(
                  progressText,
                ),
              )
            ],
          ),
        ),
      );
      await _showOverlay(
        child: isModal
            ? Stack(
          children: <Widget>[
            ModalBarrier(
              color: modalColor ?? _modalBarrierDefaultColor,
              dismissible: modalDismissible,
            ),
            child
          ],
        )
            : child,
        type: _OverlayType.Loader,
      );
    } catch (err) {
      rethrow;
    }
  }
}

Future<void> hideLoader() async {
  try {
    await _hideOverlay(_OverlayType.Loader);
  } catch (err) {
    rethrow;
  }
}

/// These methods deal with showing and hiding the overlay
Future<void> _showOverlay({required Widget child, _OverlayType? type}) async {
  try {
    final overlay = _overlayState;

    if (type!.isShowing()) {
      return Future.value(false);
    }
    Widget mainChild = AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: child
    );
    final overlayEntry = OverlayEntry(
      builder: (context) => mainChild,
    );

    overlay!.insert(overlayEntry);
    type.setOverlayEntry(overlayEntry);
    type.setShowing();
  } catch (err) {
    rethrow;
  }
}

Future<void> _hideOverlay(_OverlayType type) async {
  try {
    if (type.isShowing()) {
      type.getOverlayEntry()?.remove();
      type.hide();
    } else {}
  } catch (err) {
    rethrow;
  }
}

enum _OverlayType {
  Loader,
}

extension OverlayTypeExtension on _OverlayType {
  String name() {
    return "Loader";
  }

  bool isShowing() {
    return _loaderShown;
  }

  void setShowing() {
    _loaderShown = true;
  }

  void hide() {
    _loaderShown = false;
  }

  OverlayEntry? getOverlayEntry() {
    return _loaderEntry;
  }

  void setOverlayEntry(OverlayEntry entry) {
    _loaderEntry = entry;
  }
}
