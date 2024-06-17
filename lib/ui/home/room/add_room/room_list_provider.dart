import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final sharedPreferencesFutureProvider =
    FutureProvider<SharedPreferences>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs;
});

final roomListProvider =
    StateNotifierProvider<RoomListNotifier, Map<String, String>>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return RoomListNotifier(prefs);
});

class RoomListNotifier extends StateNotifier<Map<String, String>> {
  RoomListNotifier(this.prefs) : super({}) {
    loadRooms();
  }

  final SharedPreferences prefs;

  void loadRooms() {
    final roomNames = prefs.getStringList('roomNames') ?? [];
    final roomImages = prefs.getStringList('roomImages') ?? [];
    if (roomNames.length == roomImages.length) {
      state = Map.fromIterables(roomNames, roomImages);
    }
  }

  void addRoom(String roomName, String roomImage) {
    state = {...state, roomName: roomImage};
    prefs.setStringList('roomNames', state.keys.toList());
    prefs.setStringList('roomImages', state.values.toList());
  }

  void removeRoom(String roomName) {
    final updatedState = {...state}..remove(roomName);
    state = updatedState;
    prefs.setStringList('roomNames', state.keys.toList());
    prefs.setStringList('roomImages', state.values.toList());
  }
}
