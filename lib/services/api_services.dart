import 'dart:convert';

import 'package:ecommerce_app/model/clothes_model.dart';
import 'package:ecommerce_app/services/utils/const.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<List<ClothesModel>> getApi() async {
    try {
      List<ClothesModel> mensclothes = [];
      Uri url = Uri.parse(apimen);
      final res = await http.get(url);
      List data = jsonDecode(res.body);
      for (Map<String, dynamic> i in data) {
        mensclothes.add(ClothesModel.fromJson(i));
      }
      // print(mensclothes[0].id);
      return mensclothes;
    } catch (e) {
      throw Exception('Error :- $e');
    }
  }

  Future<List<ClothesModel>> getApi1() async {
    try {
      List<ClothesModel> womensclothes = [];
      Uri url = Uri.parse(apiwomen);
      final res = await http.get(url);
      List data = jsonDecode(res.body);
      // print(data[0]);
      for (Map<String, dynamic> i in data) {
        womensclothes.add(ClothesModel.fromJson(i));
      }
      return womensclothes;
    } catch (e) {
      throw Exception('Error :- $e');
    }
  }
}
