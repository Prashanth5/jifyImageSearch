class ImageModel {
  ImageModel({
    this.total,
    this.totalHits,
    this.hits,
  });

  int total;
  int totalHits;
  List<Hit> hits;

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        total: json["total"],
        totalHits: json["totalHits"],
        hits: List<Hit>.from(json["hits"].map((x) => Hit.fromJson(x))),
      );
}

class Hit {
  Hit({
    this.id,
    this.type,
    this.tags,
    this.previewUrl,
    this.previewWidth,
    this.previewHeight,
    this.largeImageUrl,
  });

  int id;
  String type;
  String tags;
  String previewUrl;
  int previewWidth;
  int previewHeight;
  String largeImageUrl;

  factory Hit.fromJson(Map<String, dynamic> json) => Hit(
        id: json["id"],
        type: json["type"],
        tags: json["tags"],
        previewUrl: json["previewURL"],
        previewWidth: json["previewWidth"],
        previewHeight: json["previewHeight"],
        largeImageUrl: json["largeImageURL"],
      );
}
