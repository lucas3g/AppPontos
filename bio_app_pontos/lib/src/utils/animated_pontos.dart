import 'package:bio_app_pontos/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AnimatedPontos extends ImplicitlyAnimatedWidget {
  AnimatedPontos({
    Key? key,
    required this.count,
    Duration duration = const Duration(milliseconds: 600),
    Curve curve = Curves.fastOutSlowIn,
  }) : super(duration: duration, curve: curve, key: key);

  final num count;

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() {
    return _AnimatedPontosState();
  }
}

class _AnimatedPontosState extends AnimatedWidgetBaseState<AnimatedPontos> {
  late IntTween _intCount = IntTween(begin: 0, end: 1);
  late Tween<double> _doubleCount = Tween<double>();

  @override
  Widget build(BuildContext context) {
    return widget.count is int
        ? Text(
            _intCount.evaluate(animation).toString(),
            style: AppTheme.textStyles.titlePontos,
          )
        : Text(
            _doubleCount.evaluate(animation).toStringAsFixed(1),
            style: AppTheme.textStyles.titlePontos,
          );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    if (widget.count is int) {
      _intCount = visitor(
        _intCount,
        widget.count,
        (dynamic value) => IntTween(begin: value),
      ) as IntTween;
    } else {
      _doubleCount = visitor(
        _doubleCount,
        widget.count,
        (dynamic value) => Tween<double>(begin: value),
      ) as Tween<double>;
    }
  }
}
