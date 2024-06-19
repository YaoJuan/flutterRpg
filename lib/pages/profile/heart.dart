import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';

class Heart extends StatefulWidget {
  const Heart({required this.character, super.key});

  final Character character;

  @override
  State<Heart> createState() => _HeartState();
}

class _HeartState extends State<Heart> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _sizeAnimation;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    // 创造一个动画 可以让这个控件 先放大 再缩小
    _sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 30, end: 50), weight: 50),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 50, end: 30), weight: 50),
    ]).animate(_controller);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return IconButton(
            icon: Icon(Icons.heart_broken,
                color: widget.character.isFavorite ? Colors.red : Colors.grey, size: _sizeAnimation.value),
            onPressed: () {
              setState(() {
                _controller.reset();
                _controller.forward();
                widget.character.toggleFavorite();
              });
            },
          );
        });
  }
}
