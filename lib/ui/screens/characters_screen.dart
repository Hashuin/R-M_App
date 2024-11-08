import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/character_service.dart';
import '../../domain/models/character_model.dart';
import '../../infrastructure/adapters/graphql_character_service.dart';
import '../../infrastructure/graphql_config.dart';
import '../widgets/card_detail.dart';
import '../widgets/character_card_widget.dart';
import 'package:shimmer/shimmer.dart';
import '../widgets/pagination_widget.dart';
import '../widgets/search_bar.dart' as custom;

class CharactersScreen extends ConsumerStatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);
  @override
  CharactersScreenState createState() => CharactersScreenState();
}

class CharactersScreenState extends ConsumerState<CharactersScreen>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<int> currentPage = ValueNotifier(1);
  int totalPages = 1;
  final ScrollController _scrollController = ScrollController();
  Character? selectedCharacter;
  bool isDetailCardVisible = false;

  final ValueNotifier<String> _searchNotifier = ValueNotifier('');

  late final AnimationController _animationController;
  late final CharacterService characterService;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    final client = GraphQLConfig().initializeClient().value;
    final characterPort = GraphQLCharacterService(client);
    characterService = CharacterService(characterPort: characterPort);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    currentPage.dispose();
    super.dispose();
  }

  Future<List<Character>> fetchCharacters(int page) async {
    final charactersResponse = await characterService.getCharacters(page, _searchNotifier.value);
    totalPages = (charactersResponse.totalCount / 20).ceil();
    return charactersResponse.characters;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: const Text(
          'Rick and Morty Characters',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          ValueListenableBuilder<String>(
            valueListenable: _searchNotifier,
            builder: (context, value, child) {
              return ValueListenableBuilder<int>(
                valueListenable: currentPage,
                builder: (context, page, child) {
                  return FutureBuilder<List<Character>>(
                    future: fetchCharacters(page),
                    builder: (context, snapshot) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 800),
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          return FadeTransition(opacity: animation, child: child);
                        },
                        child: _buildBody(snapshot),
                      );
                    },
                  );
                },
              );
            },
          ),
          if (isDetailCardVisible && selectedCharacter != null)
            Positioned.fill(
              child: GestureDetector(
                onTap: closeDetailCard,
                child: Container(
                  color: Colors.black54,
                  child: DetailCard(
                    character: selectedCharacter!,
                    onClose: closeDetailCard,
                    animationController: _animationController,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBody(AsyncSnapshot<List<Character>> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return _loadingWidget();
    } else if (snapshot.hasError) {
      return _errorWidget();
    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return const Center(child: Text('No characters found'));
    } else {
      final characters = snapshot.data!;
      final filteredCharacters = characters.where((character) {
        return character.name.toLowerCase().contains(_searchNotifier.value.toLowerCase());
      }).toList();

      return Center(
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                color: Colors.teal.shade50,
                child: custom.SearchBar(
                  searchNotifier: _searchNotifier,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: filteredCharacters.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        showDetailCard(filteredCharacters[index]);
                      },
                      child: CharacterCard(character: filteredCharacters[index]),
                    ),
                  ),
                ),
              ),
              _paginationWidget(),
            ],
          ),
        ),
      );
    }
  }

  void showDetailCard(Character character) {
    setState(() {
      selectedCharacter = character;
      isDetailCardVisible = true;
    });
    _animationController.forward(from: 0.0);
  }

  void closeDetailCard() {
    _animationController.reverse(from: 1.0).then((value) {
      setState(() {
        isDetailCardVisible = false;
        selectedCharacter = null;
      });
    });
  }

  Widget _loadingWidget() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              width: 50,
              height: 50,
              color: Colors.white,
            ),
            title: Container(
              height: 10,
              width: double.infinity,
              color: Colors.white,
            ),
            subtitle: Container(
              height: 10,
              width: 100,
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }

  Widget _errorWidget() {
    return Center(
      child: TextButton(
        child: const Text('Retry'),
        onPressed: () {
          fetchCharacters(currentPage.value);
          setState(() {});
        },
      ),
    );
  }

  Widget _paginationWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: PaginationWidget(
        totalPages: totalPages,
        currentPage: currentPage.value,
        onPageChanged: (newPage) {
          currentPage.value = newPage;
        },
      ),
    );
  }
}