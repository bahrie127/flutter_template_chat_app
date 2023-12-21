import 'package:flutter/material.dart';

import 'avatar.dart';

enum BubbleType {
  top,
  middle,
  bottom,
  alone,
}

enum Direction {
  left,
  right,
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    required this.direction,
    required this.message,
    required this.type,
    this.photoUrl,
  }) : super(key: key);
  final Direction direction;
  final String message;
  final String? photoUrl;
  final BubbleType type;

  @override
  Widget build(BuildContext context) {
    final isOnLeft = direction == Direction.left;
    return Row(
      mainAxisAlignment:
          isOnLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (isOnLeft) _buildLeading(type),
        SizedBox(width: isOnLeft ? 4 : 0),
        Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: _borderRadius(direction, type),
            color: isOnLeft ? Colors.grey[200] : Theme.of(context).primaryColor,
          ),
          child: Text(
            message,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: isOnLeft ? Colors.black : Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLeading(BubbleType type) {
    if (type == BubbleType.alone || type == BubbleType.bottom) {
      return const Avatar(
        radius: 12,
      );
    }
    return const SizedBox(width: 24);
  }

  BorderRadius _borderRadius(Direction dir, BubbleType type) {
    const radius1 = Radius.circular(15);
    const radius2 = Radius.circular(5);
    switch (type) {
      case BubbleType.top:
        return dir == Direction.left
            ? const BorderRadius.only(
                topLeft: radius1,
                topRight: radius1,
                bottomLeft: radius2,
                bottomRight: radius1,
              )
            : const BorderRadius.only(
                topLeft: radius1,
                topRight: radius1,
                bottomLeft: radius1,
                bottomRight: radius2,
              );

      case BubbleType.middle:
        return dir == Direction.left
            ? const BorderRadius.only(
                topLeft: radius2,
                topRight: radius1,
                bottomLeft: radius2,
                bottomRight: radius1,
              )
            : const BorderRadius.only(
                topLeft: radius1,
                topRight: radius2,
                bottomLeft: radius1,
                bottomRight: radius2,
              );
      case BubbleType.bottom:
        return dir == Direction.left
            ? const BorderRadius.only(
                topLeft: radius2,
                topRight: radius1,
                bottomLeft: radius1,
                bottomRight: radius1,
              )
            : const BorderRadius.only(
                topLeft: radius1,
                topRight: radius2,
                bottomLeft: radius1,
                bottomRight: radius1,
              );
      case BubbleType.alone:
        return BorderRadius.circular(15);
    }
  }
}
