import 'package:flutter/material.dart';
import '../../domain/models/character_model.dart';

class DetailCard extends StatelessWidget {
  final Character character;
  final VoidCallback onClose;
  final AnimationController animationController;

  const DetailCard({
    Key? key,
    required this.character,
    required this.onClose,
    required this.animationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onClose,
        child: ScaleTransition(
          scale: animationController,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.blueGrey, width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 10.0),
                  child: Hero(
                    tag: character.id,
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: NetworkImage(character.image),
                    ),
                  ),
                ),
                Text(
                  character.name,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'ComicSans',
                  ),
                ),
                const SizedBox(height: 10),
                _buildDetailText('Status: ${character.status}', Colors.blueGrey),
                _buildDetailText('Species: ${character.species}', Colors.blueGrey),
                _buildDetailText('Type: ${character.type}', Colors.blueGrey),
                _buildDetailText('Gender: ${character.gender}', Colors.blueGrey),
                _buildDetailText('Origin: ${character.origin?.name}', Colors.blueGrey),
                _buildDetailText('Location: ${character.location?.name}', Colors.blueGrey),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: onClose,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Close', style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailText(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: color, fontFamily: 'ComicSans'),
        ),
      ),
    );
  }
}