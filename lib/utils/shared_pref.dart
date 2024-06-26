import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:rxdart/rxdart.dart';

import '../base/src_utils.dart';
import '../data/remote/model/rooms/get_rooms/rooms_response.dart';

const String keyUserId = "userId";
const String keyUserName = "userName";
const String keyUserEmail = "userEmail";
const String keyRoomsList = "roomsList";

const String keyScaleFactor = "scaleFactor";
const String keyThemeMode = "theme";
const String keyTerminologies = "terminologies";
const String keyLangCode = "language";

const String keyLogin = "login";
const String keyAccessToken = "accessToken";
const String keyRefreshToken = "refreshToken";
const String keyExpiration = "expiration";

const String keyRequestProperties = "requestProperties";
const String keyMenu = "menu";
const String keyMobileMenu = "mobile_menu";
const String keyUser = "user";
const String keyInstitute = "institute";
const String keyAcademicPeriod = "academicPeriod";
const String keyAcademicPeriodList = "academicPeriodList";
const String keyStudentList = "studentList";
const String keyStudent = "student";
const String keyAuthenticationRequired = "authenticationRequired";
const String keyCalendarViewType = "calendarViewType";

const String onTime = "on_time";
const String offTime = "off_time";

// late BehaviorSubject<Time?> onTime;
// late BehaviorSubject<Time?> offTime;

Future<void> sharedPrefClear() async {
  await SpUtil.clear();
}

/// User Id
void saveUserId(String userId) => SpUtil.putString(keyUserId, userId);

String getUserId() => SpUtil.getString(keyUserId);

/// User Name
void saveUserName(String userName) => SpUtil.putString(keyUserName, userName);

String getUserName() => SpUtil.getString(keyUserName);

/// User Email
void saveUserEmail(String userEmail) =>
    SpUtil.putString(keyUserEmail, userEmail);

String getUserEmail() => SpUtil.getString(keyUserEmail);

/// Rooms
void saveRoomsList(List<RoomsResponse> roomsList) =>
    SpUtil.putObjectList(keyRoomsList, roomsList);

List<RoomsResponse> getRoomsList() => SpUtil.getObjList(keyRoomsList,
    (value) => RoomsResponse.fromJson(value as Map<String, dynamic>));

/// Scale Factor
void setScaleFactor(double value) {
  SpUtil.putDouble(keyScaleFactor, value);
}

double getScaleFactor() {
  return SpUtil.getDouble(keyScaleFactor, defValue: 1.0);
}

double getScaleFactorHeight() {
  var scale = SpUtil.getDouble(keyScaleFactor, defValue: 1.0);
  return (scale < 1.0) ? 1.0 : scale;
}

/// Theme
void setThemeMode(bool isDark) {
  SpUtil.putBool(keyThemeMode, isDark);
}

bool getThemeMode() {
  return SpUtil.getBool(keyThemeMode, defValue: false);
}

/// authenticationRequired
void setAuthenticationRequired(bool value) {
  SpUtil.putBool(keyAuthenticationRequired, value);
}

bool getAuthenticationRequired() {
  return SpUtil.getBool(keyAuthenticationRequired, defValue: false);
}

/// Login
void setLogin(bool flag) {
  SpUtil.putBool(keyLogin, flag);
}

bool isLogin() {
  return SpUtil.getBool(keyLogin);
}

/// Access Token
void saveAccessToken(String? token) {
  SpUtil.putString(keyAccessToken, token);
}

String getAccessToken() {
  return SpUtil.getString(keyAccessToken);
}

/// Refresh Token
void saveRefreshToken(String? token) {
  SpUtil.putString(keyRefreshToken, token);
}

String getRefreshToken() {
  return SpUtil.getString(keyRefreshToken);
}

/// ExpiryToken Time
void saveExpiryTokenTime(DateTime? dateTime) {
  if (dateTime != null) {
    SpUtil.putString(keyExpiration, dateTime.toString());
  } else {
    SpUtil.putString(keyExpiration, "");
  }
}

DateTime getExpiryTokenTime() {
  return DateTime.parse(SpUtil.getString(keyExpiration));
}

/// Language
void saveLanguage(String? code) {
  SpUtil.putString(keyLangCode, code);
}

String getLanguage() {
  return SpUtil.getString(keyLangCode);
}

//Time
void setOnTime(Time time) {
  SpUtil.putObject(onTime, time);
}

void setOffTime(Time time) {
  SpUtil.putObject(offTime, time);
}