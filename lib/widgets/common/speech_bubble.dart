import 'package:flutter/material.dart';

class SpeechBubble extends StatelessWidget {
  final String message;
  final Function? onTap;
  final EdgeLocation edgeLocation;

  const SpeechBubble({
    super.key,
    required this.message,
    this.onTap,
    this.edgeLocation = EdgeLocation.none,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(),
      child: Column(
        children: [
          if (edgeLocation == EdgeLocation.top)
            Transform.flip(
              flipY: true,
              child: ClipPath(
                clipper: TriangleClipper(),
                child: Container(
                  color: Colors.white,
                  height: 10,
                  width: 20,
                ),
              ),
            ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            child: Text(message),
          ),
          if (edgeLocation == EdgeLocation.bottom)
            ClipPath(
              clipper: TriangleClipper(),
              child: Container(
                color: Colors.white,
                height: 10,
                width: 20,
              ),
            ),
        ],
      ),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width / 2, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}

enum EdgeLocation { bottom, top, none }
