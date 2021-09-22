import 'customize_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CustomizeRepository {
  const CustomizeRepository();

  Future<CustomizeModel> getCustomizeInfo() async {
    try {
      final response = await http.get(
        Uri.parse('https://dev.api.slai.tech/user/customize'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer: slai_the_best',
        },
      );

      return CustomizeModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw e;
    }
  }

  Future putCustomizeInfo(CustomizeModel customizeInfo) async {
    try {
      final utfBody = utf8.encode(customizeInfo.toJson());

      await http.put(
        Uri.parse('https://dev.api.slai.tech/user/customize'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer: slai_the_best',
        },
        body: utfBody,
      );
    } catch (e) {
      throw e;
    }
  }
}
