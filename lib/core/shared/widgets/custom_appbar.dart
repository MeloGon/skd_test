import 'package:flutter/material.dart';
//import 'package:tennis_court/core/config.dart';

class CustomAppbar extends PreferredSize {
  final double height;
  final bool? goBack;
  final String? title;
  final TextStyle? titleStyle;
  final Widget? actions;

  CustomAppbar({
    super.key,
    this.height = kToolbarHeight,
    this.title,
    this.goBack,
    this.titleStyle,
    this.actions,
  }) : super(
            child: Container(),
            preferredSize: const Size.fromHeight(kToolbarHeight));

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      flexibleSpace: Container(
          // decoration: const BoxDecoration(
          //   gradient: LinearGradient(
          //       begin: Alignment.centerLeft,
          //       end: Alignment.centerRight,
          //       colors: <Color>[AppColors.black, AppColors.green82BC00]),
          // ),
          ),
      leading: (goBack ?? false)
          ? InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.keyboard_arrow_left,
                size: 30.0,
              ),
            )
          : null,
      title: Text(title ?? '', style: titleStyle),
      actions: [actions ?? const SizedBox.shrink()],
    );
  }
}
