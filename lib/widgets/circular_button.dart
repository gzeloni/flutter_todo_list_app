import 'package:flutter/material.dart';
import 'package:todo_list/widgets/todo.dart';

class CircularButton extends StatefulWidget {
  CircularButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  State<CircularButton> createState() => _CircularButtonState();
}

class _CircularButtonState extends State<CircularButton> {
  IconData circleButton = Icons.circle_outlined;
  bool didChangedIcon = false;

  void updateIcon() {
    if (didChangedIcon == false) {
      setState(() {
        circleButton = Icons.circle_outlined;
      });
    } else {
      setState(() {
        circleButton = Icons.circle_rounded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        widget.onPressed.call();
        didChangedIcon = !didChangedIcon;
        setState(() {
          updateIcon();
        });
      },
      child: Icon(
        circleButton,
        color: const Color.fromARGB(255, 8, 60, 82),
      ),
    );
  }
}
