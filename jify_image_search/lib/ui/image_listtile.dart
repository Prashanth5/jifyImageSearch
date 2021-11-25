import 'package:flutter/material.dart';
import 'package:jify_image_search/model/image_model.dart';
import 'package:jify_image_search/ui/image_detail.dart';

class ImageListTile extends StatefulWidget {
  final Hit imageHit;
  ImageListTile(this.imageHit);

  @override
  _ImageListTileState createState() => _ImageListTileState();
}

class _ImageListTileState extends State<ImageListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          print(widget.imageHit.previewUrl);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ImageDetail(imageHit: widget.imageHit),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
              ),
              constraints: BoxConstraints.tightFor(width: 100.0),
              child: _imageTile(widget.imageHit.previewUrl),
            ),
            Column(
              children: [
                _titleTile(
                  widget.imageHit.type.toUpperCase(),
                  TextStyle(fontSize: 18),
                ),
                _titleTile(
                  widget.imageHit.tags,
                  TextStyle(fontSize: 15),
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                  height: 1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageTile(String url) {
    return Container(
        constraints: BoxConstraints.tightFor(width: 100.0),
        child: Image.network(
          url,
          fit: BoxFit.fitHeight,
        ));
  }

  Widget _titleTile(String text, TextStyle style) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
