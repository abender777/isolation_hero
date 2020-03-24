part of home_page_delay_animation_widget;

class _HomePageDelayAnimationMobile extends StatefulWidget {
  final Widget childWidget;
  final int delayInMillis;

  _HomePageDelayAnimationMobile(
      {@required this.childWidget, this.delayInMillis});

  @override
  _HomePageDelayAnimationState createState() => _HomePageDelayAnimationState();
}

class _HomePageDelayAnimationState extends State<_HomePageDelayAnimationMobile>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    final curve =
        CurvedAnimation(curve: Curves.decelerate, parent: _controller);
    _animOffset =
        Tween<Offset>(begin: const Offset(0.0, 0.35), end: Offset.zero)
            .animate(curve);

    if (widget.delayInMillis == null) {
      _controller.forward();
    } else {
      Timer(Duration(milliseconds: widget.delayInMillis), () {
        _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: SlideTransition(
        position: _animOffset,
        child: widget.childWidget,
      ),
      opacity: _controller,
    );
  }
}
