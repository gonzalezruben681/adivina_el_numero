import 'dart:math';
import 'package:flutter/material.dart';
import '../../doiman/models/historial_model.dart';

class AdivinaElNumeroProvider extends ChangeNotifier {
  int _nivelSeleccion = 0;
  final List<int> menorQue = [];
  final List<int> mayorQue = [];
  int numMax = 0;
  int? guess;
  int intentosRestantes = 0;
  int _numSecreto = 0;
  int _intentosMax = 0;
  bool errorCastValue = false;
  final List<Historial> _historialColor = [];
  int get nivelSeleccion => _nivelSeleccion;
  int get numSecreto => _numSecreto;
  List<Historial> get historialColor => _historialColor;

  void setNivelSeleccion(int value) {
    _nivelSeleccion = value;
    iniciaJuego();
    notifyListeners();
  }

  void iniciaJuego() {
    switch (_nivelSeleccion) {
      case 0:
        numMax = 10;
        _intentosMax = 5;
        _numSecreto = Random().nextInt(numMax) + 1;
        break;
      case 1:
        numMax = 20;
        _intentosMax = 8;
        _numSecreto = Random().nextInt(numMax) + 1;
        break;
      case 2:
        numMax = 100;
        _intentosMax = 15;
        _numSecreto = Random().nextInt(numMax) + 1;
        break;
      case 3:
        numMax = 1000;
        _intentosMax = 25;
        _numSecreto = Random().nextInt(numMax) + 1;
        break;
      default:
        _numSecreto = 0;
    }
    intentosRestantes = _intentosMax;
    menorQue.clear();
    mayorQue.clear();
  }

  void checkNumSecreto(String adivinar) {
    if (intentosRestantes > 0) {
      guess = int.tryParse(adivinar);
      if (guess != null && guess! >= 1 && guess! <= numMax) {
        errorCastValue = false;
        if (guess == _numSecreto) {
          _numSecreto = 0;
          _historialColor.add(Historial(
            result: guess!,
            color: Colors.green,
          ));
          iniciaJuego();
        } else {
          intentosRestantes--;
          if (guess! > _numSecreto) {
            menorQue.add(guess!);
          } else {
            mayorQue.add(guess!);
          }
          if (intentosRestantes == 0) {
            _numSecreto = 0;
            _historialColor.add(Historial(
              result: guess!,
              color: Colors.red,
            ));
            iniciaJuego();
          }
        }
        notifyListeners();
      } else {
        errorCastValue = true;
        notifyListeners();
      }
    } else {
      iniciaJuego();
      notifyListeners();
    }
  }
}
