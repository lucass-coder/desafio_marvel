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
              child: Image.network(
                'https://logodownload.org/wp-content/uploads/2017/05/marvel-logo-1.png',
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
