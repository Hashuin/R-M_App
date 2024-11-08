import 'package:flutter/material.dart';

class PaginationWidget extends StatelessWidget {
  final int totalPages;
  final int currentPage;
  final Function(int) onPageChanged;

  const PaginationWidget({
    Key? key,
    required this.totalPages,
    required this.currentPage,
    required this.onPageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (currentPage > 1)
              _buildIconButton(
                icon: Icons.arrow_left,
                onPressed: () => onPageChanged(currentPage - 1),
              ),
            ...List.generate(totalPages, (index) {
              if (index + 1 >= currentPage - 1 && index + 1 <= currentPage + 1) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: _buildPageButton(index + 1),
                );
              }
              return const SizedBox();
            }),
            if (currentPage < totalPages)
              _buildIconButton(
                icon: Icons.arrow_right,
                onPressed: () => onPageChanged(currentPage + 1),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton({required IconData icon, required VoidCallback onPressed}) {
    return IconButton(
      icon: Icon(icon, size: 24.0, color: Colors.black),
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(maxWidth: 40, maxHeight: 40),
      tooltip: 'Ir ${icon == Icons.arrow_left ? 'a la página anterior' : 'a la siguiente página'}',
    );
  }

  Widget _buildPageButton(int pageNumber) {
    bool isActive = currentPage == pageNumber;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: isActive ? Colors.white : Colors.black,
        backgroundColor: isActive ? Colors.teal : Colors.grey[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        elevation: isActive ? 4 : 0,
      ),
      child: Text(
        '$pageNumber',
        style: TextStyle(
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onPressed: () => onPageChanged(pageNumber),
    );
  }
}