import 'dart:convert';
import 'package:jify_image_search/model/image_model.dart';
import 'package:http/http.dart' as http;
import 'package:jify_image_search/utils/constants.dart';

class ApiHelper {
  Future<List<Hit>> getImages({String searchItem, int page}) async {
    final queryString =
        "&q=" + searchItem + "&image_type=photo&pretty=true&page=$page";
    var url = Constants.baseuri + Constants.apikey + queryString;
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      List<Hit> hits = body["hits"]
          .map<Hit>(
            (json) => Hit.fromJson(json),
          )
          .toList();
      return hits;
    } else {
      throw Error();
    }
  }
}
