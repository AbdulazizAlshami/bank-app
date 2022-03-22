import 'package:flutter/material.dart';
import 'app_text.dart';

class ResponsiveButton extends StatelessWidget {
  bool? isResponsive;
  double? width;

  ResponsiveButton({
    Key? key,
    this.isResponsive = false,
    this.width = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        width: isResponsive == true ? double.maxFinite : width,
        height: 40,
        margin: EdgeInsets.only(bottom: 420),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blueGrey,
        ),
        child: Row(
          mainAxisAlignment: isResponsive == true
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: [
            isResponsive == false
                ? Container(
                margin: const EdgeInsets.only(
                  left: 9,
                ),
                child: Center(
                    child: AppText(
                      text: "OK",
                      color: Colors.white,
                    )))
                : Container(),
          ],
        ),
      ),
    );
  }
}
