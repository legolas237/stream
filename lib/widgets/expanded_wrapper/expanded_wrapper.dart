import 'package:flutter/material.dart';

class ExpandedWrapperWidget extends StatefulWidget {
  ExpandedWrapperWidget({
    this.expand = false,
    required this.child,
  });

  final Widget child;
  final bool expand;

  @override
  State<StatefulWidget> createState() => _ExpandedWrapperWidgetState();
}

class _ExpandedWrapperWidgetState extends State<ExpandedWrapperWidget> with SingleTickerProviderStateMixin {
  late AnimationController _expandController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _prepareAnimations();
    _runExpandCheck();
  }

  @override
  void didUpdateWidget(ExpandedWrapperWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    _expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axisAlignment: 1.0,
      sizeFactor: _animation,
      child: widget.child,
    );
  }

  // Callback

  void _runExpandCheck() {
    if (widget.expand) {
      _expandController.forward();
    } else {
      _expandController.reverse();
    }
  }

  // Init animations

  void _prepareAnimations() {
    _expandController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    _animation = CurvedAnimation(
      parent: _expandController,
      curve: Curves.fastOutSlowIn,
    );
  }
}
