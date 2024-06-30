import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final ids = Set();
    var list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}

typedef OnItemTap<T> = void Function(BuildContext context, T? data, int? index);

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}

Future<String> networkImageToBase64(String imageUrl) async {
  http.Response response = await http.get(Uri.parse(imageUrl));
  final bytes = response.bodyBytes;
  return (base64Encode(bytes));
}

Future<Uint8List> getUint8List(String path) async {
  final ByteData data = await rootBundle.load(path);
  return data.buffer.asUint8List();
}

String getBase64FromUint8List(Uint8List bytes) {
  return base64Encode(bytes);
}

Future<String> getBase64File(String path) async {
  Uint8List bytes = await getUint8List(path);
  return getBase64FromUint8List(bytes);
}

extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}

Future<void> openURL(String? url) async {
  if (!await launchUrl(Uri.parse(url ?? ""))) {
    throw 'Could not launch $url';
  }
}

Future<void> closeApp() async {
  if (Platform.isIOS) {
    try {
      SystemNavigator.pop(animated: true);
    } catch (e) {
      exit(0);
    }
  } else {
    try {
      SystemNavigator.pop();
    } catch (e) {
      exit(0);
    }
  }
}

String generateUniqueKey() {
  return const Uuid().v4();
}

String selectedDaysString(List<bool> selectedDaysList) {
  String result = '';
  for (bool day in selectedDaysList) {
    result += day ? '1' : '0';
  }
  return result;
}

List<bool> selectedDaysList(String selectedDaysString) {
  List<bool> result = [];
  for (int i = 0; i < selectedDaysString.length; i++) {
    result.add(selectedDaysString[i] == '1');
  }
  return result;
}

String removeIdFromString(String input) {
  final regex = RegExp(r' - #[a-fA-F0-9-]+$');
  return input.replaceAll(regex, '');
}