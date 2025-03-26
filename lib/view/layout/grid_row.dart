import 'dart:math';

import 'package:flutter/material.dart';
import 'package:in_classe/constant/measures.dart';

class GridRow extends StatelessWidget {
  final double crossAxisSpacing, mainAxisSpacing;
  final int columnsCount;
  final List<Widget> children;
  final bool fill;

  /// Aligns the [children] in a grid having [columnsCount] columns.
  ///
  /// The elements of each row are vertically aligned.
  /// If [fill], any remaining cell is filled with blank space, otherwise the last elements are stretched.
  const GridRow(
      {super.key,
      this.crossAxisSpacing = Measures.vMarginThin,
      this.mainAxisSpacing = Measures.vMarginThin,
      this.fill = false,
      required this.columnsCount,
      required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(children.length ~/ columnsCount + 1, (i) {
        List<Widget> elements = [];
        final int rowSize = fill ? columnsCount : min(columnsCount, children.length - columnsCount * i);
        for (var j = 0; j < rowSize; j++) {
          elements.add(Flexible(
              child: (i * columnsCount + j < children.length)
                  ? children[i * columnsCount + j]
                  : Container()));
          if (j < rowSize - 1) {
            elements.add(SizedBox(width: crossAxisSpacing));
          }
        }
        return Padding(
          padding: EdgeInsets.only(bottom: i <= children.length ~/ columnsCount ? mainAxisSpacing : 0),
          child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: elements),
        );
      }),
    );
  }
}
