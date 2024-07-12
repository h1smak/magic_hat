import 'package:flutter/material.dart';

class AccessDeniedWidget extends StatelessWidget {
  final String? imageUrl;

  const AccessDeniedWidget({
    this.imageUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          imageUrl ?? "",
          height: 250,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 100,
              height: 100,
              color: Colors.grey.shade200,
              child: const Icon(
                Icons.person,
                size: 30,
              ),
            );
          },
        ),
        const SizedBox(width: 8),
        const Expanded(
          child: Text(
            'ACCESS DENIED',
            style: TextStyle(
              color: Colors.red,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
