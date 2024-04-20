import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adivina_el_numero/views/adivina_el_numero_view.dart';
import 'package:adivina_el_numero/views/providers/adivina_el_numero_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AdivinaElNumeroProvider(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: AdivinaElNumeroView(),
      ),
    );
  }
}
