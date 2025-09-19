import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Function()? onBack;
  const CustomAppBar({
    super.key,
    this.onBack,
    this.preferredSize = const Size.fromHeight(160),
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
  @override
  final Size preferredSize;
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: widget.preferredSize,
      child: Container(
        color: Colors.black,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: widget.onBack != null,
              replacement: SizedBox(width: 24),
              child: IconButton(
                key: Key('back_button'),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  weight: 0.5,
                ),
                iconSize: 24,
                onPressed: widget.onBack,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 48, bottom: 12, right: 24),
              child: CachedNetworkImage(
                imageUrl:
                    'https://logodownload.org/wp-content/uploads/2017/05/marvel-logo-1.png',
                placeholder: (context, url) =>
                    const SizedBox(width: 100, height: 40),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/images/marvel_logo.png',
                  fit: BoxFit.contain,
                  width: 100,
                  height: 40,
                ),
                fit: BoxFit.contain,
                width: 100,
                height: 40,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
