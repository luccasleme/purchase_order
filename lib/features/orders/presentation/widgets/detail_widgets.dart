import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:purchase_order/core/utils/size.dart';

class DetailDrawer extends StatelessWidget {
  const DetailDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: Screen.height(context) / 3,
        width: Screen.width(context),
        decoration: BoxDecoration(
            color: const Color.fromRGBO(124, 137, 163, 1),
            borderRadius: BorderRadius.circular(25)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            margin: EdgeInsets.only(
              bottom: Screen.height(context) / 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.grey.shade100,
            ),
            child: const TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                label: Padding(
                  padding: EdgeInsets.only(
                    left: 8.0,
                  ),
                  child: Text('Justifique para reprovar'),
                ),
                border: InputBorder.none,
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
          ),
        ),
      ),
    ).animate().slide(
        begin: const Offset(0, 0.3),
        duration: const Duration(milliseconds: 250),
        delay: Duration.zero);
  }
}
