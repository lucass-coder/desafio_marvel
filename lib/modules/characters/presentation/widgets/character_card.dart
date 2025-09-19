import 'package:desafio_marvel/modules/characters/domain/entities/chacacter_entity.dart';
import 'package:flutter/material.dart';

class CharacterCard extends StatelessWidget {
  final CharacterEntity character;
  final bool isCarousel;

  const CharacterCard.carousel({super.key, required this.character})
    : isCarousel = true;

  const CharacterCard.grid({super.key, required this.character})
    : isCarousel = false;

  @override
  Widget build(BuildContext context) {
    final cardContent = GestureDetector(
      onTap: () {
        //TODO: Navegar para a página de detalhes do personagem
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          alignment: isCarousel ? Alignment.bottomLeft : Alignment.bottomCenter,
          children: [
            Image.network(
              character.thumbnailUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: isCarousel
                    ? const BorderRadius.vertical(bottom: Radius.circular(16))
                    : null,
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                ),
              ),
              child: Text(
                character.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // Se for um card de carrossel, ele precisa de uma largura fixa.
    if (isCarousel) {
      return SizedBox(width: 140, child: cardContent);
    }

    return cardContent;
  }
}
