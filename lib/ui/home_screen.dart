import 'package:flutter/material.dart';
import 'package:hogwarts_sorting_magic_hat_mobile_application/providers/character_provider.dart';
import 'package:hogwarts_sorting_magic_hat_mobile_application/ui/widgets/house_button.dart';
import 'package:hogwarts_sorting_magic_hat_mobile_application/ui/widgets/statistic_row.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final characterProvider = Provider.of<CharacterProvider>(context);
    List<String> houses = [
      'Gryffindor',
      'Slytherin',
      'Ravenclaw',
      'Hufflepuff',
      'Not in House'
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
        backgroundColor: Colors.grey.shade300,
        actions: [
          TextButton(
            onPressed: characterProvider.resetGame,
            child: const Text('Reset', style: TextStyle(color: Colors.black)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RefreshIndicator(
          onRefresh: () => characterProvider.loadRandomCharacter(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const StatisticsRow(),
                if (characterProvider.currentCharacter != null)
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Image.network(
                          characterProvider.currentCharacter!.image ?? "",
                          height: 100,
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
                        const SizedBox(height: 10),
                        Text(
                          characterProvider.currentCharacter!.name ?? "",
                          style: const TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 0.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return HouseButton(
                      house: houses[index],
                      image: Image.asset(
                        'assets/images/${houses[index].toLowerCase()}.png',
                        width: 50,
                        height: 50,
                      ),
                    );
                  },
                ),
                HouseButton(house: houses.last),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
