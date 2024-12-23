import 'package:flutter/material.dart';
import 'package:purchase_order/utils/size.dart';

class BottomBanner extends StatelessWidget {
  const BottomBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Screen.height(context) / 6),
      decoration: BoxDecoration(color: const Color.fromRGBO(0, 45, 114, 1)),
      width: Screen.width(context),
      height: Screen.width(context) / 10,
      child: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0, bottom: 4),
          child: Text(
            'Porfolio by Luccas F. Leme',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
