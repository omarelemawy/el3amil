import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/rendering.dart';

typedef OnSecondaryButtonClick = Function(int);

class CustomExpandedFab extends StatefulWidget {
  final Icon mainButtonIcon;
  final Icon mainButtonExpandedIcon;
  final Color mainButtonBackgroundColor;
  final double mainButtonSize;
  final double mainButtonElevation;
  final List<SecondaryExpandedButton> secondaryButtons;
  final OnSecondaryButtonClick onSecondaryButtonClick;
  const CustomExpandedFab(
      {Key key,
      this.mainButtonIcon,
      this.mainButtonBackgroundColor,
      this.mainButtonSize,
      this.mainButtonElevation,
      this.onSecondaryButtonClick,
      this.mainButtonExpandedIcon,
      this.secondaryButtons})
      : super(key: key);
  @override
  _CustomExpandedFabState createState() => _CustomExpandedFabState();
}

class _CustomExpandedFabState extends State<CustomExpandedFab>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  bool _start = false;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    _checkWidgetValidation();
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        widget.secondaryButtons != null
            ? FadeTransition(
                child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: widget.secondaryButtons
                        .map((button) => AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              margin: EdgeInsets.only(
                                  bottom: _start
                                      ? (widget.secondaryButtons
                                                  .indexOf(button) +
                                              1) *
                                          60.0
                                      : 0.0),
                              child: FloatingActionButton(
                                onPressed: widget.onSecondaryButtonClick != null
                                    ? () =>
                                        widget.onSecondaryButtonClick(button.id)
                                    : null,
                                child: button.icon,
                                backgroundColor: button.backgroundColor ??
                                    themeData.accentColor,
                              ),
                            ))
                        .toList()),
                opacity:
                    Tween(begin: 0.0, end: 1.0).animate(_animationController),
              )
            : SizedBox(),
        RotationTransition(
          turns: Tween(begin: -1.0, end: -0.5).animate(_animationController),
          child: _MainButton(
            mainButtonSize: widget.mainButtonSize,
            mainButtonIcon: widget.mainButtonIcon,
            mainButtonExpandedIcon: widget.mainButtonExpandedIcon,
            mainButtonBackgroundColor: widget.mainButtonBackgroundColor,
            animation: _animation,
            animationController: _animationController,
            mainButtonElevation: widget.mainButtonElevation,
            onPress: () {
              setState(() {
                _start = !_start;
              });
            },
          ),
        ),
      ],
    );
  }

  void _checkWidgetValidation() {
    List<SecondaryExpandedButton> buttons = widget.secondaryButtons;
    if (buttons != null) {
      for (int i = 0; i < buttons.length; i++) {
        for (int j = i + 1; j < buttons.length; j++) {
          if (buttons[i].id == buttons[j].id) {
            print("Same ${buttons[i].id}");
            throw ("(Expanded FAB) \nSorry You cannot use the same id for multi buttons.\nthe id (${buttons[i].id}) is duplicated");
            break;
          }
        }
      }
    }
  }
}

class _MainButton extends StatelessWidget {
  final Icon mainButtonIcon;
  final Icon mainButtonExpandedIcon;
  final Color mainButtonBackgroundColor;
  final double mainButtonSize;
  final double mainButtonElevation;
  final AnimationController animationController;
  final Animation animation;
  final VoidCallback onPress;
  const _MainButton(
      {Key key,
      this.mainButtonIcon,
      this.mainButtonBackgroundColor,
      this.mainButtonSize,
      this.mainButtonElevation,
      this.mainButtonExpandedIcon,
      this.animation,
      this.onPress,
      this.animationController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FloatingActionButton(
        backgroundColor: mainButtonBackgroundColor,
        child: animation.value <= 0.5
            ? Icon(
                mainButtonExpandedIcon != null
                    ? mainButtonExpandedIcon
                    : Icons.close,
                size: mainButtonIcon.size,
                color: mainButtonIcon.color,
              )
            : mainButtonIcon,
        elevation: mainButtonElevation,
        onPressed: () {
          onPress();
          if (animationController.view.value == 1.0)
            animationController.reverse();
          else
            animationController.forward();
        },
      ),
      width: mainButtonSize,
      height: mainButtonSize,
    );
  }
}

class SecondaryExpandedButton extends StatelessWidget {
  final Color backgroundColor;
  final double size;
  final Icon icon;
  final int id;
  final VoidCallback onPressed;
  const SecondaryExpandedButton(
      {Key key,
      this.backgroundColor,
      this.size,
      this.icon,
      @required this.id,
      this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: backgroundColor,
      child: icon,
      onPressed: onPressed,
    );
  }
}
