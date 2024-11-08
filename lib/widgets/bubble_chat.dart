import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../other/global_variables.dart';
import '../themes/poke_theme.dart';

class BubbleChat extends StatefulWidget {
  final String text;
  final bool isQuestion;
  final String imagePath;

  const BubbleChat({
    super.key,
    required this.text,
    required this.isQuestion,
    required this.imagePath
  });

  @override
  State<BubbleChat> createState() => _BubbleChatState();
}

class _BubbleChatState extends State<BubbleChat> {

  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 400),
      child: Row(
        children: [
          widget.isQuestion ? const SizedBox(
            width: 100,
          ) : Container(),
          Container(
            margin: widget.isQuestion ? const EdgeInsets.fromLTRB(0, 0, 16, 16) : const EdgeInsets.fromLTRB(16, 0, 0, 16),
            decoration: BoxDecoration(
                color: widget.isQuestion ? PokeTheme.green.withAlpha(60) : PokeTheme.electric.withAlpha(140),
                borderRadius: BorderRadius.circular(12)
            ),
            width: screenWidth - 116,
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                widget.imagePath != ''
                  ? Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: Image.file(File(widget.imagePath), scale: 3.5),
                  )
                  : Container(),
                MarkdownBody(data: widget.text),
              ],
            ),
          ),
          !widget.isQuestion ? const SizedBox(
            width: 100,
          ) : Container(),
        ],
      ),
    );
  }
}
