import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Container(
        height: 75,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              iconSize: 30.0,
              icon: Icon(Icons.home),
              onPressed: () {},
            ),
            IconButton(
              iconSize: 30.0,
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              iconSize: 30.0,
              icon: Icon(Icons.notifications),
              onPressed: () {},
            ),
            IconButton(
              iconSize: 30.0,
              icon: Icon(Icons.list),
              onPressed: () {},
            )
          ],
        ).paddingSymmetric(
          horizontal: 50,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
