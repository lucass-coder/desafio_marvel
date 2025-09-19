import 'package:desafio_marvel/core/config/analytics_constants.dart';
import 'package:desafio_marvel/core/services/analytics_service.dart';
import 'package:desafio_marvel/modules/characters/domain/entities/chacacter_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
        AnalyticsService.logCustomEvent(
          name: AnalyticsEvents.viewCharacterDetails,
          parameters: {
            AnalyticsParams.itemId: character.id.toString(),
            AnalyticsParams.itemName: character.name,
            AnalyticsParams.contentType: 'character-card',
          },
        );
        Modular.to.pushNamed(
          '/character-details',
          arguments: {'characterInfo': character},
        );
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
                  colors: [Colors.black87, Colors.transparent],
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

    if (isCarousel) {
      return SizedBox(width: 140, child: cardContent);
    }

    return cardContent;
  }
}
