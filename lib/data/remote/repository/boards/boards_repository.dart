import 'package:dio/dio.dart';
import 'package:estonedge/base/constants/app_constants.dart';
import 'package:estonedge/data/remote/model/board_types/board_types_response.dart';
import 'package:estonedge/data/remote/utils/dio_manager.dart';

void apiGetBoardTypes(Function(List<BoardTypesResponse>) onSuccess,
    Function(String) onError) async {
  try {
    final response = boardTypesResponseFromJson(
        (await (await DioManager.getInstance())!.get(boardTypes,
                options: Options(responseType: ResponseType.plain)))
            .data);

    onSuccess(response);
  } on DioException catch (ex) {
    onError(ex.message ?? "Something went wrong");
  }
}
