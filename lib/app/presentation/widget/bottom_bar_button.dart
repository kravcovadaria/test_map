import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_map/app/presentation/widget/app_icon.dart';

class BottomBarButton extends StatelessWidget {
  const BottomBarButton({
    super.key,
    required this.icon,
    required this.caption,
    required this.onTap,
    this.selected = false,
  });

  final String icon;
  final String caption;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Align(child: GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 64.r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppIcon.square(icon,
                color: selected
                    ? Colors.white
                    : Theme.of(context).textTheme.labelSmall?.color,
                size: 20.r),
            Padding(
              padding: EdgeInsets.only(top: 7.r),
              child: Text(
                caption,
                textAlign: TextAlign.center,
                style: selected
                    ? Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: Colors.white)
                    : Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ],
        ),
      ),),
    );
  }
}
