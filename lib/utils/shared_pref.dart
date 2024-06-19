import '../base/src_utils.dart';

const String keyUserId = "userId";

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

Future<void> sharedPrefClear() async {
  await SpUtil.clear();
}

/// User Id
void setUserId(String userId) => SpUtil.putString(keyUserId, userId);

String getUserId() => SpUtil.getString(keyUserId);

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
