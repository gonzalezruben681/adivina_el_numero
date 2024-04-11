import 'package:flutter/material.dart';

class Helpers {
 static Future<dynamic> customDialog({required BuildContext context, Color? color, IconData? icon, String? title, String? description}) {
    return showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 8),
                Text( title ?? 'Error', style: TextStyle(color: color)),
              ],
            ),
            content: Text(description ?? ""
                ),
            actions: [
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Aceptar',
                    style: TextStyle(color: Color(0xff335c9f)),
                  ),
                ),
              ),
            ],
          ),
        );
  }
}