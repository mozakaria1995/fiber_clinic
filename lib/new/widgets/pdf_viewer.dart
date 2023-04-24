import 'dart:async';

import 'package:auth_manager/new/utils/resoures/color_manager.dart';
import 'package:auth_manager/new/utils/resoures/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PDFViewerFromAsset extends StatelessWidget {
  PDFViewerFromAsset({required this.pdfAssetPath, required this.fromURL});

  final String pdfAssetPath;
  final Completer<PDFViewController> _pdfViewController =
      Completer<PDFViewController>();
  final _pageCountController = StreamController<String>();
  final bool fromURL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorManager.scaffoldBackGround,
        shadowColor: Colors.transparent,
        title: Text("",
            style: TextStyle(
                color: ColorManager.primary,
                fontFamily: FontManager.fontFamily,
                fontWeight: FontWeightManager.semiBold,
                fontSize: FontSizeManager.s16)),
      ),
      body: fromURL
          ? PDF(
              enableSwipe: true,
              swipeHorizontal: true,
              autoSpacing: false,
              pageFling: false,
              onPageChanged: (current, total) =>
                  _pageCountController.add('${current! + 1} - $total'),
              onViewCreated: _pdfViewController.complete,
            ).cachedFromUrl(pdfAssetPath)
          : PDF(
              enableSwipe: true,
              swipeHorizontal: true,
              autoSpacing: false,
              pageFling: false,
              onPageChanged: (current, total) =>
                  _pageCountController.add('${current! + 1} - $total'),
              onViewCreated: _pdfViewController.complete,
            ).fromAsset(pdfAssetPath),
      floatingActionButton: FutureBuilder<PDFViewController>(
        future: _pdfViewController.future,
        builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
          if (snapshot.hasData) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: "-",
                  child: Text("-"),
                  onPressed: () async {
                    final pdfController = snapshot.data!;
                    final currentPage =
                        (await pdfController.getCurrentPage())! - 1;
                    if (currentPage >= 0)
                      await snapshot.data!.setPage(currentPage);
                  },
                ),
                FloatingActionButton(
                  heroTag: "+",
                  child: Text("+"),
                  onPressed: () async {
                    final pdfController = snapshot.data!;
                    final currentPage =
                        (await pdfController.getCurrentPage())! + 1;
                    final numberOfPages =
                        await (pdfController.getPageCount() as FutureOr<int>);
                    if (numberOfPages > currentPage)
                      await snapshot.data!.setPage(currentPage);
                  },
                ),
              ],
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
