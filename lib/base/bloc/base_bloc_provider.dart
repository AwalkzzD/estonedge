
// ignore_for_file: library_private_types_in_public_api, overridden_fields

import 'package:flutter/material.dart';

import '../src_bloc.dart';

/// Function used to customize the update policy
typedef UpdateShouldNotify<T> = bool Function(T bloc, _BlocProvider oldWidget);

/// The `BlocProvider` class depends on `InheritedWidget`.
/// It accepts a bloc and a widget.
class BlocProvider<T extends BasePageBloc> extends StatefulWidget {
  /// The  BLoC this provider will be hosting
  final T initBloc;

  /// The widget that the [BlocProvider] will wrap
  final Widget child;

  /// Allows you to override the default update policy
  ///
  /// Default implementation:
  ///
  /// ```dart
  ///    @override
  ///    bool updateShouldNotify(_BlocProvider oldWidget) =>
  ///       updateShouldNotifyOverride != null
  ///           ? updateShouldNotifyOverride(bloc, oldWidget)
  ///           : oldWidget.bloc != bloc;
  /// ```
  final UpdateShouldNotify<T>? updateShouldNotifyOverride;

  /// Builds a [BlocProvider].
  ///
  /// [child] is the widget that the [BlocProvider] will wrap.
  /// [_bloc] is the BLoC this provider will be hosting.
  /// [updateShouldNotifiyOverride] is an optional parameter that will allow you
  /// to override the default behaviour.
  /// This is the default implementation of the `updateShouldNotify` method:
  ///
  /// ```dart
  ///    @override
  ///    bool updateShouldNotify(_BlocProvider oldWidget) =>
  ///       updateShouldNotifyOverride != null
  ///           ? updateShouldNotifyOverride(bloc, oldWidget)
  ///           : oldWidget.bloc != bloc;
  /// ```
  const BlocProvider({
    super.key,
    required this.child,
    required this.initBloc,
    this.updateShouldNotifyOverride,
  });

  /// Whenever you want to get your `BloC`, you can decide wether to attach the context of your widget to the `InheritedWidget` or not.
  /// In order to control this behavior, the static method `of` has an optional boolean argument (which is true by default) which determines wether your context will be attached or not.
  /// Basically, if you don't provide it or you just set it to `true`, [dependOnInheritedWidgetOfExactType](https://api.flutter.dev/flutter/widgets/BuildContext/dependOnInheritedWidgetOfExactType.html) will be used.
  /// If you set
  static T of<T extends BasePageBloc>(BuildContext context,
      [bool attachContext = true]) =>
      _BlocProvider.of(context, attachContext);

  /// Creates the state
  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();
}

class _BlocProviderState<T extends BasePageBloc> extends State<BlocProvider<T>> {
  @override
  Widget build(BuildContext context) {
    return _BlocProvider(
      bloc: widget.initBloc,
      updateShouldNotifyOverride: widget.updateShouldNotifyOverride,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    widget.initBloc.dispose();
    super.dispose();
  }
}

class _BlocProvider<T extends BasePageBloc> extends InheritedWidget {
  final T bloc;
  @override
  final Widget child;
  final UpdateShouldNotify<T>? updateShouldNotifyOverride;

  const _BlocProvider({
    required this.bloc,
    required this.child,
    this.updateShouldNotifyOverride,
  }) : super(child: child);

  static T of<T extends BasePageBloc>(BuildContext context, bool attachContext) {
    final type = _typeOf<_BlocProvider<T>>();

    _BlocProvider<T>? blocProvider;

    if (attachContext) {
      blocProvider =
          context.dependOnInheritedWidgetOfExactType<_BlocProvider<T>>();
    } else {
      var element =
      context.getElementForInheritedWidgetOfExactType<_BlocProvider<T>>();
      if (element != null) {
        blocProvider = element.widget as _BlocProvider<T>;
      }
    }

    if (blocProvider == null) {
      throw FlutterError('Unable to find BLoC of type $type.\n'
          'Context provided: $context');
    }
    return blocProvider.bloc;
  }

  static Type _typeOf<T>() => T;

  @override
  bool updateShouldNotify(_BlocProvider oldWidget) =>
      updateShouldNotifyOverride != null
          ? updateShouldNotifyOverride!(bloc, oldWidget)
          : oldWidget.bloc != bloc;
}