import 'package:jify_image_search/model/image_model.dart';
import 'package:jify_image_search/service/api_helper.dart';

class MyHomeViewModel {
  Future<List<Hit>> imageHits;
  void setUpApiWithSearchItem({String item = 'flower'}) {
    imageHits = ApiHelper().getImages(searchItem: item);
  }
}
