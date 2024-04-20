import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adivina_el_numero/views/helpers.dart';
import 'package:adivina_el_numero/views/providers/adivina_el_numero_provider.dart';
import 'package:adivina_el_numero/views/widgets/custom_listview.dart';

class AdivinaElNumeroView extends StatefulWidget {
  const AdivinaElNumeroView({Key? key}) : super(key: key);

  @override
  State<AdivinaElNumeroView> createState() => _AdivinaElNumeroViewState();
}

class _AdivinaElNumeroViewState extends State<AdivinaElNumeroView> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final adivinaProvider = context.watch<AdivinaElNumeroProvider>();
    void check() {
      adivinaProvider.checkNumSecreto(_textController.text);
      if (adivinaProvider.errorCastValue) {
        Helpers.customDialog(
            context: context,
            description:
                'Valor inválido. Por favor ingrese un número entre 1 y ${adivinaProvider.numMax}',
            color: Colors.red,
            icon: Icons.error_outline);
      }
        _textController.clear();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Adivinar el número secreto')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Seleccione dificultad: ',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 5),
              DropdownButton<int>(
                value: adivinaProvider.nivelSeleccion,
                items: const [
                  DropdownMenuItem(
                    value: 0,
                    child: Text('Fácil'),
                  ),
                  DropdownMenuItem(
                    value: 1,
                    child: Text('Medio'),
                  ),
                  DropdownMenuItem(
                    value: 2,
                    child: Text('Avanzado'),
                  ),
                  DropdownMenuItem(
                    value: 3,
                    child: Text('Extremo'),
                  ),
                ],
                onChanged: (value) => context
                    .read<AdivinaElNumeroProvider>()
                    .setNivelSeleccion(value!),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _textController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Ingresa el número',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Intentos: ${adivinaProvider.intentosRestantes}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: check,
            child: const Text('Enviar número'),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomListView(
                  title: "Menor que:",
                  itemCount: adivinaProvider.menorQue.length,
                  items: adivinaProvider.menorQue,
                ),
                CustomListView(
                  title: "Mayor que:",
                  itemCount: adivinaProvider.mayorQue.length,
                  items: adivinaProvider.mayorQue,
                ),
                Container(
                  width: 100,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          'Historial:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Expanded(
                        child: ListView.builder(
                          itemCount: adivinaProvider.historialColor.length,
                          itemBuilder: (BuildContext context, int index) {
                            final historial = adivinaProvider.historialColor;
                            return Center(
                              child: Text(
                                historial[index].result.toString(),
                                style: TextStyle(
                                  color: historial[index].color,
                                  fontSize: 16,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
