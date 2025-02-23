import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppbarBackTitle extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? isBackable;
  final Widget? reverseLeading;
  const AppbarBackTitle({
    super.key,
    this.title,
    this.isBackable = true,
    this.reverseLeading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: isBackable == true
          ? Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )
          : null,
      actions: [
        reverseLeading ?? Container(),
      ],
      title: title != null ? Text(title!) : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
