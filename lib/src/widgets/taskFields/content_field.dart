import 'package:flutter/material.dart';

class ContentField extends StatefulWidget {
  const ContentField({
    super.key,
    required this.contentController,
    required this.errorContentText,
  });

  final TextEditingController contentController;
  final String? errorContentText;

  @override
  State<ContentField> createState() => _ContentFieldState();
}

class _ContentFieldState extends State<ContentField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              textAlignVertical: TextAlignVertical.top,
              keyboardType: TextInputType.multiline,
              maxLines: 10,
              style: const TextStyle(
                color: Color.fromARGB(255, 8, 60, 82),
              ),
              controller: widget.contentController,
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
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                labelText: "Conteúdo",
                alignLabelWithHint: true,
                hintText: "Ex: Estudar piano às 14:00",
                errorText: widget.errorContentText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
