import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hogwarts_sorting_magic_hat_mobile_application/providers/character_provider.dart';

class HouseButton extends StatelessWidget {
  final String house;
  final Image? image;

  const HouseButton({
    required this.house,
    this.image,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final characterProvider =
        Provider.of<CharacterProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OutlinedButton(
        onPressed: () => characterProvider.guessHouse(house),
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          side: const BorderSide(color: Colors.black, width: 3),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              image ?? const SizedBox.shrink(),
              Text(
                house,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
