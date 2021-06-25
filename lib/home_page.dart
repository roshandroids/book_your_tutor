import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:book_your_tutor/hooks/scroll_controller_for_animation.dart';

// class HomePage extends HookWidget {
//   @override
//   Widget build(BuildContext context) {
//     final hideFabAnimController = useAnimationController(
//         duration: kThemeAnimationDuration, initialValue: 1);
//     final scrollController =
//         useScrollControllerForAnimation(hideFabAnimController);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Let's Scroll"),
//       ),
//       floatingActionButton: FadeTransition(
//         opacity: hideFabAnimController,
//         child: ScaleTransition(
//           scale: hideFabAnimController,
//           child: FloatingActionButton.extended(
//             label: const Text('Useless Floating Action Button'),
//             onPressed: () {},
//           ),
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       body: ListView(
//         controller: scrollController,
//         children: <Widget>[
//           for (int i = 0; i < 5; i++)
//             Card(child: FittedBox(child: FlutterLogo())),
//         ],
//       ),
//     );
//   }
// }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _hideFabAnimation;
  late AnimationController _showFabAnimation;

  @override
  initState() {
    super.initState();
    _hideFabAnimation = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _showFabAnimation = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _hideFabAnimation.dispose();
    _showFabAnimation.dispose();
    super.dispose();
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            if (userScroll.metrics.maxScrollExtent !=
                userScroll.metrics.minScrollExtent) {
              _hideFabAnimation.forward();
              _showFabAnimation.reverse();
            }
            break;
          case ScrollDirection.reverse:
            if (userScroll.metrics.maxScrollExtent !=
                userScroll.metrics.minScrollExtent) {
              _hideFabAnimation.reverse();
              _showFabAnimation.forward();
            }
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Fabulous FAB Animation',
          ),
        ),
        body: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, item) {
            return ListTile(
              title: Text("$item item"),
            );
          },
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FadeTransition(
                  opacity: _hideFabAnimation,
                  child: ScaleTransition(
                    alignment: Alignment.center,
                    scale: _hideFabAnimation,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.qr_code_2_outlined,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Scan to pay"),
                        ],
                      ),
                    ),
                  ),
                ),
                FadeTransition(
                  opacity: _showFabAnimation,
                  child: ScaleTransition(
                    alignment: Alignment.center,
                    scale: _showFabAnimation,
                    child: FloatingActionButton(
                      backgroundColor: Colors.red,
                      child: Icon(
                        Icons.qr_code_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
