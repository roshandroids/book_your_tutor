import 'dart:async';

import 'package:flutter/material.dart';

class PositionedDirectionalExample extends StatefulWidget {
  const PositionedDirectionalExample({
    Key? key,
  }) : super(key: key);

  @override
  _PositionedDirectionalExampleState createState() =>
      _PositionedDirectionalExampleState();
}

class _PositionedDirectionalExampleState
    extends State<PositionedDirectionalExample> {
  bool _showFirst = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // starts animating just after the first frame
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => setState(() => _showFirst = !_showFirst),
    );
    _timer = Timer.periodic(
      const Duration(seconds: 2),
      (_) => setState(() => _showFirst = !_showFirst),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
            AnimatedPositionedDirectional(
              duration: const Duration(seconds: 1),
              // top: _showFirst ? 150 : 0,
              start: _showFirst ? 0 : 100,
              bottom: _showFirst ? 100 : 10,
              end: 0,
              child: const Card(
                color: Colors.yellowAccent,
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: Icon(
                    Icons.star,
                    size: 50,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
