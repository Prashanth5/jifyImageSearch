import 'package:flutter/material.dart';
import 'package:jify_image_search/model/image_model.dart';

class ImageDetail extends StatelessWidget {
  final Hit imageHit;
  const ImageDetail({this.imageHit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Details'),
      ),
      // body: SingleChildScrollView(
      //   child: Container(
      //     padding: EdgeInsets.all(8.0),
      //     child: Image.network(imageHit.largeImageUrl),
      //   ),
      // ),
      body: Center(
        child: InteractiveViewer(
          panEnabled: true,
          boundaryMargin: EdgeInsets.all(80),
          maxScale: 5,
          minScale: 0.5,
          child: Image.network(imageHit.largeImageUrl),
        ),
      ),
    );
  }
}
