import 'package:flutter/material.dart';
import 'package:hogwarts_sorting_magic_hat_mobile_application/providers/bottom_nav_provider.dart';
import 'package:hogwarts_sorting_magic_hat_mobile_application/providers/character_provider.dart';
import 'package:hogwarts_sorting_magic_hat_mobile_application/ui/details_screen.dart';
import 'package:hogwarts_sorting_magic_hat_mobile_application/ui/widgets/statistic_row.dart';
import 'package:provider/provider.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final characterProvider = Provider.of<CharacterProvider>(context);
    final bottomNavProvider = Provider.of<BottomNavProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('List Screen'),
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
        child: Column(
          children: [
            const StatisticsRow(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Filter characters...',
                  suffixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  characterProvider.searchCharacters(value);
                },
              ),
            ),
            Expanded(
              child: Consumer<CharacterProvider>(
                builder: (context, characterProvider, _) {
                  List<Map<String, dynamic>> filteredCharacters =
                      characterProvider.searchedCharacters;
                  return ListView.builder(
                    itemCount: filteredCharacters.length,
                    itemBuilder: (context, index) {
                      final guessed = filteredCharacters[index];
                      final character = guessed['character'];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                character: character,
                                guessedCorrectly: guessed['successful'],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          color: Colors.white54,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Image.network(
                                  character.image!,
                                  width: 70,
                                  height: 70,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 70,
                                      height: 70,
                                      color: Colors.grey.shade200,
                                      child: const Icon(
                                        Icons.person,
                                        size: 30,
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                        character.name!,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ),
                                    Text('Attempts: ${guessed['attempts']}'),
                                  ],
                                ),
                                const Spacer(),
                                guessed['successful']
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.green,
                                        size: 32,
                                      )
                                    : Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              bottomNavProvider.selectIndex(0);
                                              characterProvider
                                                  .reloadCharacter(character);
                                            },
                                            child: const Icon(
                                              Icons.replay_outlined,
                                               size: 32,
                                            ),
                                          ),
                                          const Icon(
                                            Icons.close,
                                            color: Colors.red,
                                            size: 32,
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
