import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:estonedge/data/remote/model/user/user_additional_info_response.dart';
import 'package:estonedge/data/remote/model/user/user_response.dart';
import 'package:estonedge/data/remote/repository/auth/auth_repository.dart';
import 'package:estonedge/data/remote/repository/user/user_repository.dart';
import 'package:estonedge/data/remote/requests/user/add_additional_info_request.dart';
import 'package:rxdart/rxdart.dart';

import '../../../base/src_bloc.dart';

class ProfileDetailsScreenBloc extends BasePageBloc {
  late BehaviorSubject<AdditionalInfo?> profileDetails;

  get profileDetailsStream => profileDetails.stream;

  late BehaviorSubject<String?> gender;

  get genderStream => gender.stream;

  late BehaviorSubject<String?> dob;

  ProfileDetailsScreenBloc() {
    profileDetails = BehaviorSubject.seeded(null);
    gender = BehaviorSubject.seeded(null);
    dob = BehaviorSubject.seeded(null);
  }

  void loadData() {
    showLoading();
    apiGetUserData((response) {
      hideLoading();
      profileDetails.add(response.additionalInfo);
      saveGender(response.additionalInfo.gender);
      saveDob(response.additionalInfo.dob ?? '');
    }, (errorMsg) {
      hideLoading();      
    });
  }

  void addAdditionalInfo(String contactNo,
      Function(AdditionalInfoResponse) onSuccess, Function(String) onError) {
    showLoading();
    final addAdditionalInfoRequestParameters = AddAdditionalInfoRequest(
            contactNo: contactNo, gender: gender.value, dob: dob.value)
        .toRequestParams();

    apiPutAdditionalInfo(addAdditionalInfoRequestParameters, (response) {
      hideLoading();
      onSuccess(response);
      profileDetails.add(response.additionalInfo);
    }, (errorMsg) {
      hideLoading();
      onError(errorMsg);
    });
  }

  void updateUserPassword(String oldPassword, String newPassword,
      Function(UpdatePasswordResult) onSuccess, Function(String) onError) {
    showLoading();
    apiUpdatePassword(oldPassword, newPassword, (response) {
      hideLoading();
      onSuccess(response);
    }, (errorMsg) {
      hideLoading();
      onError(errorMsg);
    });
  }

  /// utils methods
  void saveGender(String? gender1) {
    gender.add(gender1);
  }

  void saveDob(String dateOfBirth) {
    dob.add(dateOfBirth);
  }
}
