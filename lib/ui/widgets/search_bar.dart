import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final ValueNotifier<String> searchNotifier;

  const SearchBar({
    Key? key,
    required this.searchNotifier,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = widget.searchNotifier.value;
    _controller.addListener(() {
      widget.searchNotifier.value = _controller.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8.0,
            spreadRadius: 2.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.grey.shade400),
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear, color: Colors.redAccent),
              onPressed: () {
                _controller.clear();
                widget.searchNotifier.value = '';
              },
            ),
          ),
          cursorColor: Colors.teal,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
