import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StepProgressView extends StatelessWidget {
  final double _width;

  final List<String> _titles;
  final int? _curStep;
  final Color? _activeColor;
  final Color? _inactiveColor = Color(0xffE6EEF3);
  final double? lineWidth = 3.0;

  StepProgressView({
    required int curStep,
    required List<String> titles,
    required double width,
    required Color color,
  })  : _titles = titles,
        _curStep = curStep,
        _width = width,
        _activeColor = color,
        assert(width > 0);

  Widget build(BuildContext context) {
    return Container(
        width: this._width,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: _iconViews(),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _titleViews(),
            ),
          ],
        ));
  }

  List<Widget> _iconViews() {
    var list = <Widget>[];
    _titles.asMap().forEach((i, icon) {
      var circleColor = (2 - _curStep! <= i) ? _activeColor : _inactiveColor;
      var lineColor = (2 - _curStep! <= i) ? _activeColor : _inactiveColor;
      var iconColor = (2 - _curStep <= i) ? _activeColor : _inactiveColor;

      list.add(
        Container(
          width: 30.0,
          height: 30.0,
          padding: EdgeInsets.all(0),
          decoration: new BoxDecoration(
            /* color: circleColor,*/
            borderRadius: new BorderRadius.all(new Radius.circular(22.0)),
            border: Border.all(
              color: circleColor!,
              width: 2.0,
            ),
          ),
          child: Icon(
            Icons.circle,
            color: iconColor,
            size: 18.0,
          ),
        ),
      );

      //line between icons
      if (i != _titles.length - 1) {
        list.add(Expanded(
            child: Container(
          height: lineWidth,
          color: lineColor,
        )));
      }
    });

    return list;
  }

  List<Widget> _titleViews() {
    var list = <Widget>[];
    _titles.asMap().forEach((i, text) {
      list.add(Text(
        text,
        style: TextStyle(
          color: Color(0xff000000),
          fontSize: 16,
        ),
      ));
    });
    return list;
  }
}
