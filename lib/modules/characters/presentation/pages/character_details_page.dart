import 'package:cached_network_image/cached_network_image.dart';
import 'package:desafio_marvel/core/services/analytics_service.dart';
import 'package:desafio_marvel/core/widgets/custom_app_bar.dart';
import 'package:desafio_marvel/modules/characters/domain/entities/chacacter_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CharacterDetailsPage extends StatefulWidget {
  final CharacterEntity characterInfo;

  const CharacterDetailsPage({super.key, required this.characterInfo});

  @override
  State<CharacterDetailsPage> createState() => _CharacterDetailsPageState();
}

class _CharacterDetailsPageState extends State<CharacterDetailsPage> {
  @override
  void initState() {
    super.initState();
    AnalyticsService.logScreenView('CharacterDetailsPage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onBack: () {
          Modular.to.pop();
        },
      ),
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                ClipRRect(
                  child: ClipRRect(
                    child: CachedNetworkImage(
                      imageUrl: widget.characterInfo.thumbnailUrl,
                      placeholder: (context, url) => Shimmer(
                        duration: const Duration(seconds: 2),
                        color: Colors.white,
                        child: Container(color: Colors.black38),
                      ),

                      errorWidget: (context, url, error) => const Center(
                        child: Icon(
                          Icons.image_not_supported_rounded,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),

                      fit: BoxFit.fill,
                      height: 400,
                      width: double.infinity,
                    ),
                  ),
                ),
                Container(
                  height: 400,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black],
                      stops: [0.5, 1.0],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.black87,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.characterInfo.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "BIOGRAPHY",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.characterInfo.description.length > 2
                        ? widget.characterInfo.description
                        : "No description available.",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
