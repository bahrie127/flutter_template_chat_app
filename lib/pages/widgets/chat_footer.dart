import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatFooter extends StatelessWidget {
  const ChatFooter({
    Key? key,
    required this.textController,
    required this.onSendMessage,
    this.padding,
  }) : super(key: key);

  final TextEditingController textController;
  final Function() onSendMessage;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 4),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                minLines: 1,
                maxLines: 3,
                controller: textController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  isDense: true,
                  fillColor: Colors.black12,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  hintText: 'Aa',
                ),
              ),
            ),
          ),
          CupertinoButton(
            child: const Icon(
              Icons.send_rounded,
              size: 32,
            ),
            padding: EdgeInsets.zero,
            onPressed: onSendMessage,
          )
        ],
      ),
    );
  }
}
