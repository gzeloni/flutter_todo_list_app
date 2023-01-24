import 'package:flutter/material.dart';

class TitleField extends StatefulWidget {
  const TitleField({
    super.key,
    required this.titleController,
    required this.errorTitleText,
  });

  final TextEditingController titleController;
  final String? errorTitleText;

  @override
  State<TitleField> createState() => _TitleFieldState();
}

class _TitleFieldState extends State<TitleField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              showCursor: true,
              cursorHeight: 12,
              cursorWidth: 2,
              cursorColor: const Color.fromARGB(255, 8, 60, 82),
              maxLength: 25,
              textCapitalization: TextCapitalization.sentences,
              autofocus: false,
              style: const TextStyle(
                color: Color.fromARGB(255, 8, 60, 82),
              ),
              controller: widget.titleController,
              decoration: InputDecoration(
                labelStyle: const TextStyle(
                  color: Color.fromARGB(255, 8, 60, 82),
                ),
                hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 8, 60, 82),
                ),
                filled: true,
                fillColor: const Color(0xffedebea),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 2,
                    color: Color.fromARGB(255, 8, 60, 82),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 2,
                    color: Color.fromARGB(255, 15, 158, 63),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 2,
                    color: Color.fromARGB(255, 15, 158, 63),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                floatingLabelStyle: const TextStyle(
                  color: Color.fromARGB(255, 8, 60, 82),
                ),
                labelText: "Dê um título a tarefa",
                hintText: "Ex: Estudar piano",
                errorText: widget.errorTitleText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
