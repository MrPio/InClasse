import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_classe/constant/measures.dart';

class RecyclerView extends StatelessWidget {
  final Widget? header;
  final List<Widget> children;
  final EdgeInsets padding;

  /// Displays a recycler view with an optional [header].
  const RecyclerView(
      {required this.children,
      this.header,
      this.padding = const EdgeInsets.only(bottom: Measures.vMarginBig * 2),
      super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: padding,
        itemCount: children.length + (header == null ? 0 : 1),
        itemBuilder: (_, i) {
          return (i == 0 && header != null) ? header : children[i - (header == null ? 0 : 1)];
        });
  }
}
