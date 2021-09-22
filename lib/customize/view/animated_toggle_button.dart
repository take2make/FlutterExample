import 'package:flutter/material.dart';
import '../assets/resources.dart';

class AnimatedToggle extends StatefulWidget {
  final List<String> values;
  final ValueChanged onToggleCallback;
  final Color backgroundColor;
  final Color buttonColor;
  final Color textColor;
  final List<BoxShadow> shadows;
  bool initialPosition;

  AnimatedToggle({
    required this.values,
    required this.onToggleCallback,
    required this.initialPosition,
    this.backgroundColor = const Color(0xFFe7e7e8),
    this.buttonColor = const Color(0xFFFFFFFF),
    this.textColor = const Color(0xFF000000),
    this.shadows = const [
      BoxShadow(
        color: const Color(0xFFd8d7da),
        spreadRadius: 5,
        blurRadius: 10,
        offset: Offset(0, 5),
      ),
    ],
  });
  @override
  _AnimatedToggleState createState() => _AnimatedToggleState();
}

class _AnimatedToggleState extends State<AnimatedToggle> {
  //bool initialPosition = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 12.0, bottom: 12, left: 8, right: 8),
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                widget.initialPosition = !widget.initialPosition;
                var index = 0;
                if (!widget.initialPosition) {
                  index = 1;
                }
                widget.onToggleCallback(index);
                setState(() {});
              },
              child: Container(
                height: width * 0.13,
                decoration: ShapeDecoration(
                  color: widget.backgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Vectors.threeArrowsLeft,
                      Vectors.threeArrowsRight
                    ],
                  ),
                ),
              ),
            ),
            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              curve: Curves.decelerate,
              alignment: widget.initialPosition
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Container(
                width: width * 0.5,
                height: width * 0.13,
                decoration: ShapeDecoration(
                  color: widget.buttonColor,
                  shadows: widget.shadows,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Text(
                  widget.initialPosition ? widget.values[0] : widget.values[1],
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                alignment: Alignment.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
