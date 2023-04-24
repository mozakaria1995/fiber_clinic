import 'package:auth_manager/config/constant.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  var _title;
  var _imageUrl;
  var _description;

  BlogCard(this._title, this._imageUrl, this._description);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            this._imageUrl != null
                ? Image.network(
                    _imageUrl,
                    fit: BoxFit.fitWidth,
                  )
                : Container(),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Text(
                _title,
                style: TextStyle(color: kTitleTextColor, fontSize: 25),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              _description,
            ),
          ],
        ),
      ),
    );
  }
}
