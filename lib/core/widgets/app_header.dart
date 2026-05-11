import 'package:flutter/material.dart';
import 'package:ai_planning_companion/core/theme/spacing.dart';

class AppHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? leftAction;
  final List<Widget>? rightActions;
  final Color backgroundColor;
  final EdgeInsets padding;

  const AppHeader({
    Key? key,
    required this.title,
    this.subtitle,
    this.leftAction,
    this.rightActions,
    this.backgroundColor = Colors.transparent,
    this.padding = const EdgeInsets.symmetric(horizontal: Spacing.md, vertical: Spacing.sm),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (leftAction != null) ...[
                leftAction!,
                const SizedBox(width: Spacing.sm),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    if (subtitle != null)
                      Padding(
                        padding: const EdgeInsets.only(top: Spacing.xs),
                        child: Text(
                          subtitle!,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (rightActions != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: rightActions!,
                )
            ],
          ),
        ],
      ),
    );
  }
}
