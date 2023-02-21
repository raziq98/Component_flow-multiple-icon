// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

const double buttonSize = 80;

class LinearFlowWidget extends StatefulWidget {
  const LinearFlowWidget({super.key});

  @override
  State<LinearFlowWidget> createState() => _LinearFlowWidgetState();
}

class _LinearFlowWidgetState extends State<LinearFlowWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: FlowMenuDelegate(
        controller: controller,
      ),
      children: <IconData>[
        Icons.menu,
        Icons.mail,
        Icons.call,
        Icons.notifications,
      ].map<Widget>(buildItem).toList(),
    );
  }

  Widget buildItem(IconData icondata) => SizedBox(
        height: buttonSize,
        width: buttonSize,
        child: FloatingActionButton(
            elevation: 0,
            splashColor: Colors.black,
            child: Icon(
              icondata,
              color: Colors.white,
              size: 45,
            ),
            onPressed: () {
              if (controller.status == AnimationStatus.completed) {
                controller.reverse();
              } else {
                controller.forward();
              }
            }),
      );
}

class FlowMenuDelegate extends FlowDelegate {
  final Animation<double> controller;
  FlowMenuDelegate({
    required this.controller,
  }) : super(repaint: controller);

  @override
  void paintChildren(FlowPaintingContext context) {
    final size = context.size;
    final xStart = size.width - buttonSize;
    final yStart = size.height - buttonSize;

    // TODO: implement paintChildren
    for (int i = context.childCount - 1; i >= 0; i--) {
      const margin = 8;
      final childSize = context.getChildSize(i)!.width;
      final dx = (childSize + margin) * i;
      //for vertical icon display (on y axis)
      final x = xStart;
      final y =
          yStart - dx * controller.value; //controller value is between 0 to 1

      /* fpr horizontal icon display (on x axis)
      final x = xStart - dx;
      final y = yStart;
      */

      context.paintChild(
        i, //index
        transform:
            Matrix4.translationValues(x, y, 0), //translationValues(x,y,0)
      );
    }

    /* alternative for 1 by 1
    context.paintChild(
      0, //index  of icon
      transform: Matrix4.translationValues(50,100,0), //translationValues(x,y,0)
    )
    context.paintChild(
      1, //index of icon
      transform: Matrix4.translationValues(150,200,0), //translationValues(x,y,0)
    )
    context.paintChild(
      2, //index
      transform: Matrix4.translationValues(50,300,0), //translationValues(x,y,0)
    )
    */
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}
