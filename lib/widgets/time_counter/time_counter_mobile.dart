part of time_counter_widget;

class _TimeCounterMobile extends StatefulWidget {
  const _TimeCounterMobile({
    Key key,
    int secondsRemaining,
    this.countDownTimerStyle,
    this.whenTimeExpires,
    this.countDownFormatter,
  })  : secondsRemaining = secondsRemaining,
        super(key: key);

  final int secondsRemaining;
  final Function whenTimeExpires;
  final Function countDownFormatter;
  final TextStyle countDownTimerStyle;

  State createState() => new _CountDownTimerState();
}

class _CountDownTimerState extends State<_TimeCounterMobile>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Duration duration;
  List<String> formatDDHHMMSS(int seconds) {
    int days = (seconds / (3600*24)).truncate();
    int hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();

    String daysStr = (days).toString().padLeft(2, '0');
    String hoursStr = (hours).toString().padLeft(2, '0');
    String minutesStr = (minutes).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    if (hours == 0) {
      return ["00", minutesStr, secondsStr];
    }

    return [daysStr, hoursStr, minutesStr, secondsStr];
  }

  List<String> get timerDisplayString {
    Duration duration = _controller.duration * _controller.value;
    return widget.countDownFormatter != null
        ? widget.countDownFormatter(duration.inSeconds)
        : formatDDHHMMSS(duration.inSeconds);
    // In case user doesn't provide formatter use the default one
    // for that create a method which will be called formatHHMMSS or whatever you like
  }

  @override
  void initState() {
    super.initState();
    duration = new Duration(seconds: widget.secondsRemaining);
    _controller = new AnimationController(
      vsync: this,
      duration: duration,
    );
    _controller.reverse(from: widget.secondsRemaining.toDouble());
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        widget.whenTimeExpires();
      }
    });
  }

  @mustCallSuper
  void didUpdateWidget(_TimeCounterMobile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.secondsRemaining != oldWidget.secondsRemaining) {
      setState(() {
        duration = new Duration(seconds: widget.secondsRemaining);
        _controller.dispose();
        _controller = new AnimationController(
          vsync: this,
          duration: duration,
        );
        _controller.reverse(from: widget.secondsRemaining.toDouble());
        _controller.addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            widget.whenTimeExpires();
          } else if (status == AnimationStatus.dismissed) {
            print("Animation Complete");
          }
        });
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: AnimatedBuilder(
            animation: _controller,
            builder: (_, Widget child) {
              return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(children: <Widget>[
                      Text(
                        timerDisplayString[0],
                        style: Theme.of(context).textTheme.headline,
                      ),
                      Text(
                        "Days",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ]),
                    Column(children: <Widget>[
                      Text(
                        timerDisplayString[1],
                        style: Theme.of(context).textTheme.headline,
                      ),
                      Text(
                        "Hours",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ]),
                    Column(children: <Widget>[
                      Text(
                        ":",
                        style: Theme.of(context).textTheme.headline,
                      ),
                      Text(
                        "",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ]),
                    Column(children: <Widget>[
                      Text(
                        timerDisplayString[2],
                        style: Theme.of(context).textTheme.headline,
                      ),
                      Text(
                        "Minutes",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ]),
                    Column(children: <Widget>[
                      Text(
                        ":",
                        style: Theme.of(context).textTheme.headline,
                      ),
                      Text(
                        "",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ]),
                    Column(children: <Widget>[
                      Text(
                        timerDisplayString[3],
                        style: Theme.of(context).textTheme.headline,
                      ),
                      Text(
                        "Seconds",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ])
                  ]);
            }));
  }
}
