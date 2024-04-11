import 'dart:math';
import 'package:adivina_el_numero/views/widgets/custom_listview.dart';
import 'package:flutter/material.dart';

class AdivinaElNumeroView extends StatefulWidget {
  const AdivinaElNumeroView({Key? key}) : super(key: key);

  @override
  State<AdivinaElNumeroView> createState() => _AdivinaElNumeroViewState();
}

class _AdivinaElNumeroViewState extends State<AdivinaElNumeroView> {
  int _nivelSeleccion = 0;
  int _numSecreto = 0;
  int _numMax = 0;
  int _intentosMax = 0;
  int _intentosRestantes = 0;
  int? guess;
  final List<int> _menorQue = [];
  final List<int> _mayorQue = [];
  final TextEditingController _textController = TextEditingController();
  final Map<int, Color> _historialColores = {};

  @override
  void initState() {
    _iniciaJuego();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adivinar el número secreto'),
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
                value: _nivelSeleccion,
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
                onChanged: (value) {
                  setState(() {
                    _nivelSeleccion = value!;
                    _iniciaJuego();
                  });
                },
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
                'Intentos: $_intentosRestantes',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _check,
            child: const Text('Ingresar número'),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomListView(
                  title: "Menor que:",
                  itemCount: _menorQue.length,
                  items: _menorQue,
                ),
                CustomListView(
                  title: "Mayor que:",
                  itemCount: _mayorQue.length,
                  items: _mayorQue,
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
                          itemCount: _historialColores.length,
                          itemBuilder: (BuildContext context, int index) {
                            int guess = _historialColores.keys.elementAt(index);
                            Color color =
                                _historialColores.values.elementAt(index);
                            return Center(
                              child: Text(
                                guess.toString(),
                                style: TextStyle(
                                  color: color,
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

  void _iniciaJuego() {
    switch (_nivelSeleccion) {
      case 0:
        _numMax = 10;
        _intentosMax = 5;
        break;
      case 1:
        _numMax = 20;
        _intentosMax = 8;
        break;
      case 2:
        _numMax = 100;
        _intentosMax = 15;
        break;
      case 3:
        _numMax = 1000;
        _intentosMax = 25;
        break;
    }
    if (_numSecreto == 0) {
      _numSecreto = Random().nextInt(_numMax) + 1;
    }
    _intentosRestantes = _intentosMax;
    _menorQue.clear();
    _mayorQue.clear();
  }

  void _check() {
    if (_intentosRestantes > 0) {
      setState(() {
        guess = int.tryParse(_textController.text);
        if (guess != null && guess! >= 1 && guess! <= _numMax) {
          if (guess == _numSecreto) {
            _historialColores[guess!] = Colors.green;
            _numSecreto = 0;
            _iniciaJuego();
          } else {
            _intentosRestantes--;
            if (guess! > _numSecreto) {
              _menorQue.add(guess!);
            } else {
              _mayorQue.add(guess!);
            }
            if (_intentosRestantes == 0) {
              _historialColores[guess!] = Colors.red;
              _numSecreto = 0;
              _iniciaJuego();
            }
          }
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Error', style: TextStyle(color: Colors.red)),
                ],
              ),
              content: Text(
                  'Valor inválido. Por favor ingrese un número entre 1 y $_numMax'),
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
        _textController.clear();
      });
    } else {
      _iniciaJuego();
    }
  }
}
